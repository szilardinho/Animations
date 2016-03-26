//
//  ViewController.m
//  Animations
//
//  Created by Szi Gabor on 9/1/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "ViewController.h"

//Remove explosion subView from super
//replace wire.frames with CGRect Bezier Paths


@interface ViewController ()

@end

@implementation ViewController
@synthesize animator,
            bomb,fire,explosion,wire1,wire2,wire3,wire4,wire5,paddle;
#define ARC4RANDOM_MAX      0x10
#define GUTTER_WIDTH 100

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"steel.png"]];
    
    
    [self createBomb];
    [self createWires];
    [self createFire];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    [self createBombBehavior];

}

-(void)createBomb
{
    bomb = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Bomb-Cool-icon.png"]];
    bomb.center = CGPointMake(185, 50);
    [self.view addSubview:bomb];
    [self createBombBehavior];
}

-(void)createFire
{
    fire = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"firepit.png"]];
    fire.center = CGPointMake(185, 630);
    [self.view addSubview:fire];
}


-(void)createWires
{
    wire1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barbed.png"]];
    wire1.center = CGPointMake(75, 400);
    [self.view addSubview:wire1];
    
    wire2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barbed.png"]];
    wire2.center = CGPointMake(365, 200);
    [self.view addSubview:wire2];
    
    
    wire3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barbed.png"]];
    wire3.center = CGPointMake(305, 500);
    [self.view addSubview:wire3];
    
    wire4 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barbed.png"]];
    wire4.center = CGPointMake(405, 350);
    [self.view addSubview:wire4];
    
    wire5 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barbed.png"]];
    wire5.center = CGPointMake(20, 250);
    [self.view addSubview:wire5];
}

-(void)createBombBehavior
{
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc]initWithItems:@[bomb]];
    [animator addBehavior:gravity];
    
    double randNum = arc4random() % (8 - 4) + 4; //create the random number.
    UIPushBehavior *push =[[UIPushBehavior alloc]initWithItems:@[bomb] mode:UIPushBehaviorModeInstantaneous];
    push.active = YES;
    push.pushDirection = CGVectorMake(randNum, -randNum);
    push.magnitude = randNum;
    [animator addBehavior:push];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:@[bomb]];
    collision.collisionDelegate = self;
//    collision.collisionMode = UICollisionBehaviorModeEverything;

    [collision setTranslatesReferenceBoundsIntoBoundary:YES];
    
    [collision addBoundaryWithIdentifier:@"View" forPath: [UIBezierPath bezierPathWithRect: wire1.frame]];
    [collision addBoundaryWithIdentifier:@"View2" forPath: [UIBezierPath bezierPathWithRect: wire2.frame]];
    [collision addBoundaryWithIdentifier:@"View3" forPath: [UIBezierPath bezierPathWithRect: wire3.frame]];
    [collision addBoundaryWithIdentifier:@"View4" forPath: [UIBezierPath bezierPathWithRect: wire4.frame]];
    [collision addBoundaryWithIdentifier:@"View5" forPath: [UIBezierPath bezierPathWithRect: wire5.frame]];
    [collision addBoundaryWithIdentifier:@"Fire" forPath: [UIBezierPath bezierPathWithRect: CGRectMake(0, self.view.frame.size.height-1, self.view.frame.size.width, 1) ]];
    [animator addBehavior:collision];
    
    UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc]initWithItems:@[bomb]];
    item.elasticity = .85;
    item.density = 3.0;
    item.friction = 0;
    item.allowsRotation = YES;
    
    [animator addBehavior:item];
    

 

}






- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(id <NSCopying>)identifier atPoint:(CGPoint)p {
    
    if ([@"Fire" isEqualToString:(NSString*)identifier]){
        
        [behavior removeItem:bomb];
        
        explosion = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"explosion.png"]];
        explosion.center = CGPointMake(bomb.center.x, bomb.center.y);
        [self.view addSubview:explosion];
        [bomb removeFromSuperview];
        
        UIView* view = (UIView*)explosion;
        [UIView animateWithDuration:0.5 animations:^{
            view.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        }];
        
        [UIView animateWithDuration:2.0 animations:^{
            view.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
            view.alpha = 0;
        }
        completion:^(BOOL finished) {
            [behavior removeItem:view];
            [view removeFromSuperview];
        }];
            [self createBomb];
    }
}

@end

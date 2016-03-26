//
//  ViewController.h
//  Animations
//
//  Created by Szi Gabor on 9/1/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController< UICollisionBehaviorDelegate,UIDynamicAnimatorDelegate>

@property (strong, nonatomic)UIDynamicAnimator *animator;

@property (strong, nonatomic)UIImageView *bomb;
@property (strong, nonatomic)UIImageView *fire;
@property (strong, nonatomic)UIImageView *explosion;
@property (strong, nonatomic)UIImageView *wire1;
@property (strong, nonatomic)UIImageView *wire2;
@property (strong, nonatomic)UIImageView *wire3;
@property (strong, nonatomic)UIImageView *wire4;
@property (strong, nonatomic)UIImageView *wire5;
@property (strong, nonatomic)UIView *paddle;


-(void)createBomb;
-(void)createWires;
-(void)createBombBehavior;

@end


//
//  LogInViewController.h
//  Animations
//
//  Created by Szi Gabor on 9/9/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface LogInViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) ViewController *VC;

- (IBAction)loginButton:(id)sender;
@end

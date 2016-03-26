//
//  LogInViewController.m
//  Animations
//
//  Created by Szi Gabor on 9/9/15.
//  Copyright (c) 2015 Szi Gabor. All rights reserved.
//

#import "LogInViewController.h"

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// THE  USERNAME IS  - szi
// THE PASSWORD IS - 123


- (IBAction)loginButton:(id)sender
{
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *params = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
    NSData *data = [params dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://envir2-ipuwuqxzkd.elasticbeanstalk.com/applogin.jsp"]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: data];
    
    NSError *error;
    NSURLResponse *response;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString* newStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
    if ([username length] == 0 || [password length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oooops!" message:@"Please complete all the fields properly or else we'll be forced to whoop that ass!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alert show];
    }
    else if ([[newStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@"success"])
    {
        // THE  USERNAME IS  - szi
        // THE PASSWORD IS - 123
        NSLog(@"The login was a %@",newStr );
        [self  performSegueWithIdentifier:@"showGame" sender:self];
    }
    else
    {
        NSLog(@"The login was a%@",newStr );
    }
}
@end

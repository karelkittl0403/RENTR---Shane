//
//  LoginViewController.m
//  RENTR
//
//  Created by kgh on 4/6/16.
//  Copyright © 2016 kgh. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "Header.h"
#import <Parse/Parse.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface LoginViewController ()<UITextFieldDelegate>
{
    BOOL isLandlord;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.txt_email.delegate = self;
    self.txt_password.delegate = self;
    isLandlord = FALSE;
    self.lbl_tenant.textColor = [UIColor colorWithRed:29.0/255.0 green:166.0/255.0 blue:100.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Exchange Landlord or tenant
- (IBAction)sw_onOff:(id)sender {
    
    if (!isLandlord) {
        
        [self.sw_land_tenant setOn:NO animated:YES];
        self.lbl_landlord.textColor = [UIColor colorWithRed:29.0/255.0 green:166.0/255.0 blue:100.0/255.0 alpha:1.0];
        self.lbl_tenant.textColor = [UIColor darkGrayColor];
    }else {
        
        [self.sw_land_tenant setOn:YES animated:YES];
        self.lbl_tenant.textColor = [UIColor colorWithRed:29.0/255.0 green:166.0/255.0 blue:100.0/255.0 alpha:1.0];
        self.lbl_landlord.textColor = [UIColor darkGrayColor];
    }
    isLandlord = !isLandlord;
}

// Login action
- (IBAction)btn_click_login:(id)sender {
    
    isLandlord = self.sw_land_tenant.selected;
    // Exception process
    if ([self.txt_email.text isEqualToString:@""] || [self.txt_password.text isEqualToString:@""]) {
        
        if ([self.txt_email.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please put your Email address." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please put your Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }
    }
    else {
        
        // Login using Parse
        [SVProgressHUD show];
        PFQuery *query = [PFUser query];
        [query whereKey:PF_USER_EMAIL equalTo:[self.txt_email.text lowercaseString]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
          
            if ([objects count]!= 0) {
                PFUser *user = [objects objectAtIndex:0];
                [PFUser logInWithUsernameInBackground:user.username password:self.txt_password.text block:^(PFUser *user, NSError *error){
                    
                    [SVProgressHUD dismiss];
                    if (!error) {
                        NSLog(@"login success");
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                        message:@"Successful login."
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                        [self.navigationController pushViewController:homeVC animated:YES];
                        
                        
                    }else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                        message:@"You entered an invalid email or password. Please try again."
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                    }
                    
                }];

//                if ([user[PF_USER_EMAILVERIFIED] boolValue]) {
//                    [PFUser logInWithUsernameInBackground:user.username password:self.txt_password.text block:^(PFUser *user, NSError *error){
//                        
//                        [SVProgressHUD dismiss];
//                        if (!error) {
//                            NSLog(@"login success");
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                            message:@"Successful login."
//                                                                           delegate:self
//                                                                  cancelButtonTitle:@"OK"
//                                                                  otherButtonTitles:nil];
//                            [alert show];
//                            HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
//                            [self.navigationController pushViewController:homeVC animated:YES];
//
//                            
//                        }else{
//                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                            message:@"Invalid Password."
//                                                                           delegate:self
//                                                                  cancelButtonTitle:@"Confirm"
//                                                                  otherButtonTitles:nil];
//                            [alert show];
//                        }
//                        
//                    }];
//                }else{
//                    [SVProgressHUD dismiss];
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                    message:@"Please check your email to confirm."
//                                                                   delegate:self
//                                                          cancelButtonTitle:@"OK"
//                                                          otherButtonTitles:nil];
//                    [alert show];
//                }
            }
            else{
                [SVProgressHUD dismiss];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"You entered an invalid email or password. Please try again."
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
}

// Convert Signup action
- (IBAction)btn_click_convertSignup:(id)sender {
    
    SignUpViewController *signupVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    [self.navigationController pushViewController:signupVC animated:YES];

}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

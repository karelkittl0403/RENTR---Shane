//
//  SignUpViewController.m
//  RENTR
//
//  Created by kgh on 4/6/16.
//  Copyright © 2016 kgh. All rights reserved.
//

#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "Header.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface SignUpViewController ()<UITextFieldDelegate>
{
    BOOL isLandlord;
}
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.txt_firstname.delegate = self;
    self.txt_lastname.delegate = self;
    self.txt_email.delegate = self;
    self.txt_password.delegate = self;
    self.txt_confirmPassword.delegate = self;
    isLandlord = FALSE;
    self.lbl_tenant.textColor = [UIColor colorWithRed:29.0/255.0 green:166.0/255.0 blue:100.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Exchange whether landlord or tenant
- (IBAction)sw_onOff:(id)sender {
    
    if (!isLandlord) {
        
        [self.sw_landlord_tenant setOn:NO animated:YES];
        self.lbl_landlord.textColor = [UIColor colorWithRed:29.0/255.0 green:166.0/255.0 blue:100.0/255.0 alpha:1.0];
        self.lbl_tenant.textColor = [UIColor darkGrayColor];
    }else {
        
        [self.sw_landlord_tenant setOn:YES animated:YES];
        self.lbl_tenant.textColor = [UIColor colorWithRed:29.0/255.0 green:166.0/255.0 blue:100.0/255.0 alpha:1.0];
        self.lbl_landlord.textColor = [UIColor darkGrayColor];
    }
    isLandlord = !isLandlord;
}

// Go back action
- (IBAction)btn_click_back:(id)sender {

    [self.navigationController popViewControllerAnimated:YES];
}

// Signup action
- (IBAction)btn_click_signup:(id)sender {
    
    // Exception process
    if ([self.txt_firstname.text isEqualToString:@""] || [self.txt_lastname.text isEqualToString:@""] || [self.txt_email.text isEqualToString:@""] ||
        [self.txt_password.text isEqualToString:@""] || [self.txt_confirmPassword.text isEqualToString:@""] || [self.txt_phone.text isEqualToString:@""]) {
        
        if ([self.txt_firstname.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please put your Firstname." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }else if ([self.txt_lastname.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please put your Lastname." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }else if ([self.txt_email.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please put your Email address." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }else if ([self.txt_password.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please put your Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }else if ([self.txt_phone.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please put your Phone Number." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please put your Confirm Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];

        }
    }
    else {
        
        // Check whether password confirm
        if (![self.txt_password.text isEqualToString:self.txt_confirmPassword.text]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Doesn't match Password." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }else {
            
            // Signup using Parse
            [SVProgressHUD show];
            PFQuery *query = [PFUser query];
            [query whereKey:PF_USER_EMAIL equalTo:[self.txt_email.text lowercaseString]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
                
                if ([objects count]!= 0) {
                    [SVProgressHUD dismiss];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                    message:@"Already existed user"
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                else{
                    PFUser *user = [PFUser user];
                    user.username = [NSString stringWithFormat:@"%@ %@", self.txt_firstname.text, self.txt_lastname.text];
                    user.email = [self.txt_email.text lowercaseString];
                    user.password = self.txt_confirmPassword.text;
                    user[PF_USER_FIRSTNAME] = self.txt_firstname.text;
                    user[PF_USER_LASTNAME] = self.txt_lastname.text;
                    user[PF_USER_PHONE] = self.txt_phone.text;
                    user[PF_USER_TYPE] = (isLandlord) ? @"0" : @"1";
                    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                        
                        [SVProgressHUD dismiss];
                        if (error) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pardon, Internet connect failed."
                                                                            message:@"Please try again."
                                                                           delegate:self
                                                                  cancelButtonTitle:@"Try"
                                                                  otherButtonTitles:nil];
                            [alert show];
                            
                        }else{
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulation!"
                                                                            message:@"Successfully registered."
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                            [alert show];
                            HomeViewController *homeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
                            [self.navigationController pushViewController:homeVC animated:YES];

                        }
                    }];
                }
            }];
        }
    }
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

//
//  SignUpViewController.h
//  RENTR
//
//  Created by kgh on 4/6/16.
//  Copyright © 2016 kgh. All rights reserved.
//

#import "LoginViewController.h"

@interface SignUpViewController : UIViewController


@property (strong, nonatomic) IBOutlet UISwitch *sw_landlord_tenant;

@property (strong, nonatomic) IBOutlet UILabel *lbl_landlord;
@property (strong, nonatomic) IBOutlet UILabel *lbl_tenant;

@property (strong, nonatomic) IBOutlet UITextField *txt_firstname;
@property (strong, nonatomic) IBOutlet UITextField *txt_lastname;
@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_phone;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;
@property (strong, nonatomic) IBOutlet UITextField *txt_confirmPassword;

@property (strong, nonatomic) IBOutlet UIButton *btn_signup;
@property (strong, nonatomic) IBOutlet UIButton *btn_back;

@end

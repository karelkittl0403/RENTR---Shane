//
//  LoginViewController.h
//  RENTR
//
//  Created by kgh on 4/6/16.
//  Copyright © 2016 kgh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITextField *txt_email;
@property (strong, nonatomic) IBOutlet UITextField *txt_password;

@property (strong, nonatomic) IBOutlet UILabel *lbl_landlord;
@property (strong, nonatomic) IBOutlet UILabel *lbl_tenant;

@property (strong, nonatomic) IBOutlet UISwitch *sw_land_tenant;

@property (strong, nonatomic) IBOutlet UIButton *btn_login;
@property (strong, nonatomic) IBOutlet UIButton *btn_convertSignup;


@end

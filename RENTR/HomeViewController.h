//
//  HomeViewController.h
//  RENTR
//
//  Created by kgh on 4/6/16.
//  Copyright © 2016 kgh. All rights reserved.
//

#import "LoginViewController.h"
#import <ParseUI/ParseUI.h>

@interface HomeViewController : UIViewController


@property (strong, nonatomic) IBOutlet UIButton *btn_settings;

@property (strong, nonatomic) IBOutlet PFImageView *img_mainProfile;
@property (strong, nonatomic) IBOutlet UILabel *lbl_rent;
@property (strong, nonatomic) IBOutlet UILabel *lbl_salary;
@property (strong, nonatomic) IBOutlet UILabel *lbl_description;



@end

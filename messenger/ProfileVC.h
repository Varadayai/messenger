//
//  ProfileVC.h
//  DealHunter
//
//  Created by Nishant Tyagi on 8/30/14.
//  Copyright (c) 2014 Leunack Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController <UITextFieldDelegate , UIScrollViewDelegate>
{

}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *userNameTF;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *reEnterPwdTF;
@property (strong, nonatomic) IBOutlet UISwitch *notificationSwitch;
@property  (nonatomic , strong) NSMutableDictionary *responseDict;


- (IBAction)enableNotification:(UISwitch *)sender;
- (IBAction)signUpBtnTouched:(UIButton *)sender;

@end

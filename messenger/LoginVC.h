//
//  LoginVC.h
//  App Reader
//
//  Created by Nishant Tyagi on 7/12/13.
//  Copyright (c) 2013 Nishant Tyagi. All rights reserved.
//
//amdv@amdv.com
// Password123#
#import <UIKit/UIKit.h>



@interface LoginVC : UIViewController <UITextFieldDelegate , UIScrollViewDelegate , UIAlertViewDelegate>
{
    UIInterfaceOrientation _currentOrientation;
    NSOperationQueue *_taskOpQueue;
    BOOL isCompleted;
    IBOutlet UIButton *offlineButton;
    IBOutlet UIButton *onlineButton;
    IBOutlet UIImageView *chekImg,*unchekImg;
    NSString *facebookid;

}
// Properties

//fb stuff
//@property (weak, nonatomic) IBOutlet FBLoginView *loginButton;
@property (weak, nonatomic)  UILabel *lblLoginStatus;
@property (weak, nonatomic)  UILabel *lblUsername;
@property (weak, nonatomic) UILabel *lblEmail;



@property (assign) BOOL IsOnlineSelected;
@property (assign) BOOL IsOfflineSelected;

@property (weak, nonatomic) IBOutlet UIImageView *companyImage;
@property  (nonatomic , strong) NSMutableDictionary *responseDict;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *usernameTF;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *passwordTF;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *forgotPasswordTF;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *forgotEmailTF;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *LoginBtn;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *popUpView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *popUpView2;

// Methods
- (IBAction)commonBtnTouched:(UIButton *)sender;


- (IBAction)closeBtnTouched:(UIButton *)sender;
- (IBAction)sendPwdBtnTouched:(UIButton *)sender;
- (void)downloadImageFromPathToDirectory:(NSString *)path andImageName:(NSString *)imageName typIs:(int)name;




//For Online/Offline Methods
- (IBAction)OfflineModeButton:(id)sender;
- (IBAction)OnlineModeButton:(id)sender;

- (IBAction)SelectionDone:(UIButton *)sender;
- (IBAction)loginOAuth;

-(IBAction)fbLogin:(id)sender;
-(IBAction)rememberPass:(UIButton *)sender;





@end

//
//  AMBubbleTableViewController.m
//  AMBubbleTableViewController
//
//  Created by Andrea Mazzini on 30/06/13.
//  Copyright (c) 2013 Andrea Mazzini. All rights reserved.
//

#import "AMBubbleTableViewController.h"
#import "AMBubbleTableCell.h"
#import "DAKeyboardControl.h"


#define kInputHeight 40.0f
#define kLineHeight 30.0f
#define kButtonWidth 78.0f

#define kOFFSET_FOR_KEYBOARD 80.0

#define SCROLLVIEW_CONTENT_HEIGHT 460
#define SCROLLVIEW_CONTENT_WIDTH  320

BOOL keyboardVisible;



@interface AMBubbleTableViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) NSMutableDictionary*	options;
@property (nonatomic, strong) UIImageView*	imageInput;
@property (nonatomic, strong) UIImageView*	imageInputBack;
@property (nonatomic, strong) UIButton*		buttonSend;
@property (nonatomic, strong) UIButton*		buttonSend2;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;
@property (nonatomic, strong) UITextView*	tempTextView;
@property (nonatomic, assign) float			previousTextFieldHeight;

@end



@implementation AMBubbleTableViewController

BOOL toggleIsOn;


- (void)viewDidLoad
{
	[super viewDidLoad];
    
   
    
	[self setupView];
}

- (void)setBubbleTableOptions:(NSDictionary *)options
{
	[self.options addEntriesFromDictionary:options];
}

- (NSMutableDictionary*)options
{
	if (_options == nil) {
		_options = [[AMBubbleGlobals defaultOptions] mutableCopy];
	}
	return _options;
}

- (void)setTableStyle:(AMBubbleTableStyle)style
{
	switch (style) {
		case AMBubbleTableStyleDefault:
			[self.options addEntriesFromDictionary:[AMBubbleGlobals defaultStyleDefault]];
			break;
		case AMBubbleTableStyleSquare:
			[self.options addEntriesFromDictionary:[AMBubbleGlobals defaultStyleSquare]];
			break;
		case AMBubbleTableStyleFlat:
			[self.options addEntriesFromDictionary:[AMBubbleGlobals defaultStyleFlat]];
			break;
		default:
			break;
	}
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleKeyboardWillShow:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleKeyboardWillHide:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setupView
{
	UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
																						action:@selector(handleTapGesture:)];
    
    
    self.lbl1 = [[UILabel alloc] init];
    [self.lbl1 setFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, kInputHeight+5)];
    self.lbl1.backgroundColor=[UIColor colorWithRed:0.0f/255.0f green:131.0f/255.0f blue:174.0f/255.0f alpha:1];
    self.lbl1.textColor=[UIColor whiteColor];
    self.lbl1.userInteractionEnabled=NO;
    self.lbl1.text= @"Messaging";
    [self.lbl1 setFont:[UIFont systemFontOfSize:17]];
    self.lbl1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lbl1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(slide:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"menu_tab.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(11.0, 19.0, 25.0, 19.0);
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 addTarget:self
               action:@selector(dialog:)
     forControlEvents:UIControlEventTouchUpInside];
    [button2 setBackgroundImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    button2.frame = CGRectMake(280.0, 19.0, 19.0, 19.0);
    [self.view addSubview:button2];

    
	// Table View
    CGRect tableFrame = CGRectMake(0.0f, kInputHeight+5, self.view.frame.size.width, self.view.frame.size.height - (kInputHeight+35));
	self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
	[self.tableView addGestureRecognizer:gestureRecognizer];
	[self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	[self.tableView setDataSource:self];
	[self.tableView setDelegate:self];
	[self.tableView setBackgroundColor:self.options[AMOptionsBubbleTableBackground]];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.view addSubview:self.tableView];
	
    // Input background
    CGRect inputFrame = CGRectMake(0.0f, self.view.frame.size.height - kInputHeight, self.view.frame.size.width, kInputHeight);
	self.imageInput = [[UIImageView alloc] initWithImage:self.options[AMOptionsImageBar]];
	[self.imageInput setFrame:inputFrame];
	[self.imageInput setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin)];
	[self.imageInput setUserInteractionEnabled:YES];
	
	[self.view addSubview:self.imageInput];
	
	// Input field
	CGFloat width = self.imageInput.frame.size.width - kButtonWidth;
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(6.0f, 3.0f, width, kLineHeight)];
    [self.textView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.textView setScrollIndicatorInsets:UIEdgeInsetsMake(10.0f, 0.0f, 10.0f, 8.0f)];
    [self.textView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [self.textView setScrollsToTop:NO];
    [self.textView setUserInteractionEnabled:YES];
    [self.textView setFont:self.options[AMOptionsTextFieldFont]];
    [self.textView setTextColor:self.options[AMOptionsTextFieldFontColor]];
    [self.textView setBackgroundColor:self.options[AMOptionsTextFieldBackground]];
    [self.textView setKeyboardAppearance:UIKeyboardAppearanceDefault];
    [self.textView setKeyboardType:UIKeyboardTypeDefault];
    [self.textView setReturnKeyType:UIReturnKeyDefault];
	
	[self.textView setDelegate:self];
    [self.imageInput addSubview:self.textView];
	
	// This text view is used to get the content size
	self.tempTextView = [[UITextView alloc] init];
    self.tempTextView.font = self.textView.font;
    self.tempTextView.text = @"";
    CGSize size = [self.tempTextView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)];
    self.previousTextFieldHeight = size.height;
    
	// Input field's background
//    self.imageInputBack = [[UIImageView alloc] initWithFrame:CGRectMake(self.textView.frame.origin.x - 1.0f,
//																		0.0f,
//																		self.textView.frame.size.width + 2.0f,
//																		self.imageInput.frame.size.height)];
//    [self.imageInputBack setImage:self.options[AMOptionsImageInput]];
//    [self.imageInputBack setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
//    [self.imageInputBack setBackgroundColor:[UIColor clearColor]];
//	[self.imageInputBack setUserInteractionEnabled:NO];
//    [self.imageInput addSubview:self.imageInputBack];

	// Send button
    self.buttonSend = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonSend setAutoresizingMask:(UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin)];
    
    UIImage *sendBack = self.options[AMOptionsImageButton];
    UIImage *sendBackHighLighted = self.options[AMOptionsImageButtonHighlight];
    [self.buttonSend setBackgroundImage:sendBack forState:UIControlStateNormal];
    [self.buttonSend setBackgroundImage:sendBack forState:UIControlStateDisabled];
    [self.buttonSend setBackgroundImage:sendBackHighLighted forState:UIControlStateHighlighted];
	[self.buttonSend.titleLabel setFont:self.options[AMOptionsButtonFont]];

    NSString *title = NSLocalizedString(@"Send",);
    [self.buttonSend setTitle:title forState:UIControlStateNormal];
    [self.buttonSend setTitle:title forState:UIControlStateHighlighted];
    [self.buttonSend setTitle:title forState:UIControlStateDisabled];
    self.buttonSend.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    
    UIColor *titleShadow = [UIColor colorWithRed:0.325f green:0.463f blue:0.675f alpha:1.0f];
    [self.buttonSend setTitleShadowColor:titleShadow forState:UIControlStateNormal];
    [self.buttonSend setTitleShadowColor:titleShadow forState:UIControlStateHighlighted];
    self.buttonSend.titleLabel.shadowOffset = CGSizeMake(0.0f, -1.0f);

    [self.buttonSend setTitleColor:self.options[AMOptionsButtonTextColor] forState:UIControlStateNormal];
    [self.buttonSend setTitleColor:self.options[AMOptionsButtonHighlightedTextColor] forState:UIControlStateHighlighted];
    [self.buttonSend setTitleColor:self.options[AMOptionsButtonDisabledTextColor] forState:UIControlStateDisabled];
    [self.buttonSend setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateDisabled];
    
    [self.buttonSend setEnabled:NO];
    [self.buttonSend setFrame:CGRectMake(self.imageInput.frame.size.width - 65.0f, [self.options[AMOptionsButtonOffset] floatValue], 59.0f, 26.0f)];
    [self.buttonSend addTarget:self	action:@selector(sendPressed:) forControlEvents:UIControlEventTouchUpInside];
	
    [self.imageInput addSubview:self.buttonSend];
    
    toggleIsOn=YES;
}

-(void)slide:(UIButton*)button{
 
    [SIDE_MENU_CONTROLLER openLeftSideViewControllerAnimated:YES completion:nil];

    
}

-(void)dialog:(UIButton*)button{
    
    
    if(toggleIsOn){
        
        
        
        _paintView=[[UIView alloc]initWithFrame:CGRectMake(0, 45, 320, 560)];
        [_paintView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:_paintView];
        
        
        UILabel *lbl2 = [[UILabel alloc] init];
        [lbl2 setFrame:CGRectMake(18.0f, 20.0f, 20, 20)];
        lbl2.backgroundColor=[UIColor clearColor];
        lbl2.textColor=[UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1];
        lbl2.userInteractionEnabled=NO;
        lbl2.text= @"To";
        [lbl2 setFont:[UIFont systemFontOfSize:14]];
        //self.lbl1.textAlignment = NSTextAlignmentCenter;
        [_paintView addSubview:lbl2];

        
        UITextField* textF = [[UITextField alloc] initWithFrame:CGRectMake(50, 20, 180, 20)];
        
                            
        textF.borderStyle = UITextBorderStyleNone;
        textF.textColor = [UIColor colorWithRed:184.0f/255.0f green:184.0f/255.0f blue:184.0f/255.0f alpha:1];
        textF.font = [UIFont systemFontOfSize:17];
        textF.placeholder = @"search name";
        textF.autocorrectionType = UITextAutocorrectionTypeNo;
        textF.keyboardType = UIKeyboardTypeDefault;
        textF.returnKeyType = UIReturnKeyDefault;
        textF.clearButtonMode = UITextFieldViewModeWhileEditing;
        textF.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textF.delegate = self;
        [_paintView addSubview:textF];
        
        
        // Input field
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f,
                                                                         self.view.bounds.size.height - 40.0f,
                                                                         self.view.bounds.size.width,
                                                                         40.0f)];
        toolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:toolBar];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f,
                                                                               6.0f,
                                                                               toolBar.bounds.size.width - 68.0f,
                                                                               30.0f)];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [toolBar addSubview:textField];
        
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        //[sendButton setTitle:@"Send" forState:UIControlStateNormal];
        [sendButton setBackgroundImage:[UIImage imageNamed:@"sent-btn"] forState:UIControlStateNormal];
        
        sendButton.frame = CGRectMake(toolBar.bounds.size.width - 48.0f,
                                      6.0f,
                                      46.0f,
                                      30.0f);
        [toolBar addSubview:sendButton];

        
        
        self.view.keyboardTriggerOffset = toolBar.bounds.size.height;
        
        [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
            /*
             Try not to call "self" inside this block (retain cycle).
             But if you do, make sure to remove DAKeyboardControl
             when you are done with the view controller by calling:
             [self.view removeKeyboardControl];
             */
            
            
            CGRect toolBarFrame = toolBar.frame;
            toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
            toolBar.frame = toolBarFrame;
            
            //CGRect tableViewFrame = tableView.frame;
            // tableViewFrame.size.height = toolBarFrame.origin.y;
            // tableView.frame = tableViewFrame;
        } constraintBasedActionHandler:nil];
        
    }
    else {
        
    
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
        _paintView.hidden=YES;

        
    }
    
    toggleIsOn = !toggleIsOn;
    
    
}

-(void)sendPressed2:(id)sender{
    
    
    
}



#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataSource numberOfRows];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	AMBubbleCellType type = [self.dataSource cellTypeForRowAtIndexPath:indexPath];
	NSString* cellID = [NSString stringWithFormat:@"cell_%d", type];
	NSString* text = [self.dataSource textForRowAtIndexPath:indexPath];
	NSDate* date = [self.dataSource timestampForRowAtIndexPath:indexPath];
	AMBubbleTableCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    // Add utility buttons
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];

	
	NSAssert(text != nil || date != nil, @"Text and Date cannot be both nil");
	
	UIImage* avatar;
	UIColor* color;
	
	if ([self.dataSource respondsToSelector:@selector(usernameColorForRowAtIndexPath:)]) {
		color = [self.dataSource usernameColorForRowAtIndexPath:indexPath];
	}
	if ([self.dataSource respondsToSelector:@selector(avatarForRowAtIndexPath:)]) {
		avatar = [self.dataSource avatarForRowAtIndexPath:indexPath];
	}

	if (cell == nil) {
		cell = [[AMBubbleTableCell alloc] initWithOptions:self.options
										  reuseIdentifier:cellID];

		if ([self.options[AMOptionsBubbleSwipeEnabled] boolValue]) {
			UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
			swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
			[cell addGestureRecognizer:swipeGesture];
		}
		if ([self.options[AMOptionsBubblePressEnabled] boolValue]) {
			UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
			[cell addGestureRecognizer:longPressGesture];
		}
	}
	
	// iPad cells are set by default to 320 pixels, this fixes the quirk
	cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x,
										cell.contentView.frame.origin.y,
										self.tableView.frame.size.width,
										cell.contentView.frame.size.height);
	
	// Used by the gesture recognizer
	cell.tag = indexPath.row;
    
    
	
	NSString* stringDate;
	if (type == AMBubbleCellTimestamp) {
		[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];	// Jan 1, 2000
		[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];	// 1:23 PM
		stringDate = [self.dateFormatter stringFromDate:date];
		[cell setupCellWithType:type
					  withWidth:self.tableView.frame.size.width
					  andParams:@{ @"date": stringDate }];
	} else {
		[self.dateFormatter setDateFormat:@"HH:mm"];					// 13:23
		NSString* username;
		if ([self.dataSource respondsToSelector:@selector(usernameForRowAtIndexPath:)]) {
			username = [self.dataSource usernameForRowAtIndexPath:indexPath];
		}
		stringDate = [self.dateFormatter stringFromDate:date];
		[cell setupCellWithType:type
					  withWidth:self.tableView.frame.size.width
					  andParams:@{
		 @"text": text,
		 @"date": stringDate,
		 @"index": @(indexPath.row),
		 @"username": (username ? username : @""),
		 @"avatar": (avatar ? avatar: @""),
		 @"color": (color ? color: @"")
		 }];
	}
    
    [self scrollToBottomAnimated:YES];
	
	return cell;
}

- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)sender
{
	if ([self.delegate respondsToSelector:@selector(swipedCellAtIndexPath:withFrame:andDirection:)]) {
		[self.delegate swipedCellAtIndexPath:[NSIndexPath indexPathForRow:sender.view.tag inSection:0] withFrame:sender.view.frame andDirection:sender.direction];
	}
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)sender
{
	if ([self.delegate respondsToSelector:@selector(longPressedCellAtIndexPath:withFrame:)]) {
		if (sender.state == UIGestureRecognizerStateBegan) {
			[self.delegate longPressedCellAtIndexPath:[NSIndexPath indexPathForRow:sender.view.tag inSection:0] withFrame:sender.view.frame];
		}
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	AMBubbleCellType type = [self.dataSource cellTypeForRowAtIndexPath:indexPath];
	NSString* text = [self.dataSource textForRowAtIndexPath:indexPath];
	NSString* username = @"";
	
	if ([self.dataSource respondsToSelector:@selector(usernameForRowAtIndexPath:)]) {
		username = [self.dataSource usernameForRowAtIndexPath:indexPath];
	}
	
	if (type == AMBubbleCellTimestamp) {
		return [self.options[AMOptionsTimestampHeight] floatValue];
	}
    
    // Set MessageCell height.
	CGSize size;
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
#ifdef __IPHONE_7_0
		size = [text boundingRectWithSize:CGSizeMake(kMessageTextWidth, CGFLOAT_MAX)
								  options:NSStringDrawingUsesLineFragmentOrigin
							   attributes:@{NSFontAttributeName:self.options[AMOptionsBubbleTextFont]}
								  context:nil].size;
#endif
	} else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
		size = [text sizeWithFont:self.options[AMOptionsBubbleTextFont]
				constrainedToSize:CGSizeMake(kMessageTextWidth, CGFLOAT_MAX)
					lineBreakMode:NSLineBreakByWordWrapping];
#pragma GCC diagnostic pop
	}
	
	CGSize usernameSize = CGSizeZero;
	
	if (![username isEqualToString:@""] && type == AMBubbleCellReceived) {
		if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
#ifdef __IPHONE_7_0
			usernameSize = [username boundingRectWithSize:CGSizeMake(kMessageTextWidth, CGFLOAT_MAX)
												  options:NSStringDrawingUsesLineFragmentOrigin
											   attributes:@{NSFontAttributeName:self.options[AMOptionsTimestampFont]}
												  context:nil].size;
#endif
		} else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
			usernameSize = [username sizeWithFont:self.options[AMOptionsTimestampFont]
								constrainedToSize:CGSizeMake(kMessageTextWidth, CGFLOAT_MAX)
									lineBreakMode:NSLineBreakByWordWrapping];
#pragma GCC diagnostic pop
		}
	}
	
	// Account for either the bubble or accessory size
    return MAX(size.height + 17.0f + usernameSize.height,
			   [self.options[AMOptionsAccessorySize] floatValue] + [self.options[AMOptionsAccessoryMargin] floatValue]);
}

#pragma mark - Keyboard Handlers

- (void)handleKeyboardWillShow:(NSNotification *)notification
{
	[self resizeView:notification];
	//[self scrollToBottomAnimated:YES];
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
	[self resizeView:notification];	
}

- (void)resizeView:(NSNotification*)notification
{
	CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	CGFloat viewHeight = (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ? MIN(self.view.frame.size.width,self.view.frame.size.height) : MAX(self.view.frame.size.width,self.view.frame.size.height));
	CGFloat keyboardY = [self.view convertRect:keyboardRect fromView:nil].origin.y;
	CGFloat diff = keyboardY - viewHeight;
	
	// This check prevents an issue when the view is inside a UITabBarController
	if (diff > 0) {
		double fraction = diff/keyboardY;
		duration *= (1-fraction);
		keyboardY = viewHeight;
	}
	
	// Thanks to Raja Baz (@raja-baz) for the delay's animation fix.	
	CGFloat delay = 0.0f;
	CGRect beginRect = [[notification.userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	diff = beginRect.origin.y - viewHeight;
	if (diff > 0) {
		double fraction = diff/beginRect.origin.y;
		delay = duration * fraction;
		duration -= delay;
	}
	
	void (^completition)(void) = ^{
		CGFloat inputViewFrameY = keyboardY - self.imageInput.frame.size.height;
		
		self.imageInput.frame = CGRectMake(self.imageInput.frame.origin.x,
										   inputViewFrameY,
										   self.imageInput.frame.size.width,
										   self.imageInput.frame.size.height);
		UIEdgeInsets insets = self.tableView.contentInset;
		insets.bottom = viewHeight - self.imageInput.frame.origin.y - kInputHeight;
		
		self.tableView.contentInset = insets;
		self.tableView.scrollIndicatorInsets = insets;
	};
	
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
#ifdef __IPHONE_7_0
		[UIView animateWithDuration:0.5
							  delay:0
			 usingSpringWithDamping:500.0f
			  initialSpringVelocity:0.0f
							options:UIViewAnimationOptionCurveLinear
						 animations:completition
						 completion:nil];
#endif
	} else {
		[UIView animateWithDuration:duration
							  delay:delay
							options:[AMBubbleGlobals animationOptionsForCurve:curve]
						 animations:completition
						 completion:nil];
	}
}

- (void)resizeTextViewByHeight:(CGFloat)delta
{
	int numLines = self.textView.contentSize.height / self.textView.font.lineHeight;

	self.textView.contentInset = UIEdgeInsetsMake((numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f,
                                                  (numLines >= 6 ? 4.0f : 0.0f),
                                                  0.0f);
	
	// Adjust table view's insets
	CGFloat viewHeight = (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) ? self.view.frame.size.width : self.view.frame.size.height;
    
	UIEdgeInsets insets = self.tableView.contentInset;
    insets.bottom = viewHeight - self.imageInput.frame.origin.y - kInputHeight;

	self.tableView.contentInset = insets;
	self.tableView.scrollIndicatorInsets = insets;

	// Slightly scroll the table
	[self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y + delta) animated:YES];
}

- (void)handleTapGesture:(UIGestureRecognizer*)gesture
{
	[self.textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
	[self.buttonSend setEnabled:([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)];

	CGFloat maxHeight = self.textView.font.lineHeight * 5;
	CGFloat textViewContentHeight = self.textView.contentSize.height;
	
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
		// Fixes the wrong content size computed by iOS7
		if (textView.text.UTF8String[textView.text.length-1] == '\n') {
			textViewContentHeight += textView.font.lineHeight;
		}
	}
	
    if ([@"" isEqualToString:textView.text]) {
    	self.tempTextView = [[UITextView alloc] init];
    	self.tempTextView.font = self.textView.font;
    	self.tempTextView.text = self.textView.text;
		
    	CGSize size = [self.tempTextView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)];
        textViewContentHeight  = size.height;
    }

	CGFloat delta = textViewContentHeight - self.previousTextFieldHeight;
	BOOL isShrinking = textViewContentHeight < self.previousTextFieldHeight;

	delta = (textViewContentHeight + delta >= maxHeight) ? 0.0f : delta;
	
	if(!isShrinking)
        [self resizeTextViewByHeight:delta];
    
    if(delta != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             UIEdgeInsets insets = self.tableView.contentInset;
                             insets.bottom = self.tableView.contentInset.bottom + delta;
                             self.tableView.contentInset = insets;
                             self.tableView.scrollIndicatorInsets = insets;
							 
                             [self scrollToBottomAnimated:NO];
							 
                             self.imageInput.frame = CGRectMake(0.0f,
                                                               self.imageInput.frame.origin.y - delta,
                                                               self.imageInput.frame.size.width,
                                                               self.imageInput.frame.size.height + delta);
                         }
                         completion:^(BOOL finished) {
                             if(isShrinking)
                                 [self resizeTextViewByHeight:delta];
                         }];
        
        self.previousTextFieldHeight = MIN(textViewContentHeight, maxHeight);
    }
	
	// This is a workaround for an iOS7 bug:
	// http://stackoverflow.com/questions/18070537/how-to-make-a-textview-scroll-while-editing
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
		if([textView.text hasSuffix:@"\n"]) {
			double delayInSeconds = 0.2;
			dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
			dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
				CGPoint bottomOffset = CGPointMake(0, self.textView.contentSize.height - self.textView.bounds.size.height);
				[self.textView setContentOffset:bottomOffset animated:YES];
			});
		}
	}
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    NSInteger bottomRow = [self.dataSource numberOfRows] - 1;
    if (bottomRow >= 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bottomRow inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath
							  atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

- (void)sendPressed:(id)sender
{
	[self.delegate didSendText:self.textView.text];
	[self.textView setText:@""];
	[self textViewDidChange:self.textView];
	[self resizeTextViewByHeight:self.textView.contentSize.height - self.previousTextFieldHeight];
    [self.buttonSend setEnabled:NO];
	[self scrollToBottomAnimated:YES];
}

- (void)reloadTableScrollingToBottom:(BOOL)scroll
{
	//[self.tableView reloadData];
	if (scroll) {
		//[self scrollToBottomAnimated:NO];
	}
}

- (NSDateFormatter*)dateFormatter
{
	if (_dateFormatter == nil) {
		_dateFormatter = [[NSDateFormatter alloc] init];
		[_dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale currentLocale] localeIdentifier]]];
	}
	return _dateFormatter;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[self.tableView reloadData];
}

@end

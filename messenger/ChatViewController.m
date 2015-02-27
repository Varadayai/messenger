//
//  ChatViewController.m
//  messenger
//
//  Created by saurabh sindhu on 04/02/15.
//  Copyright (c) 2015 saurabh. All rights reserved.
//

#import "ChatViewController.h"


@interface ChatViewController ()<AMBubbleTableDataSource, AMBubbleTableDelegate>

@property (nonatomic, strong) NSMutableArray* data;


@end

@implementation ChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Bubble Table setup
    
//    [myNav willMoveToParentViewController:self];
//    myNav.view.frame = CGRectMake(0, 0, 320, 30);  //Set a frame or constraints
//    [self.view addSubview:myNav.view];
//    [self addChildViewController:myNav];
//    [myNav didMoveToParentViewController:self];
	
	[self setDataSource:self]; // Weird, uh?
	[self setDelegate:self];
	
	[self setTitle:@"Message"];
	
	// Dummy data
	self.data = [[NSMutableArray alloc] initWithArray:@[
														@{
															@"text": @"He felt that hey were enjoying it.",
															@"date": [NSDate date],
															@"type": @(AMBubbleCellReceived),
															@"username": @"Stevie",
															@"color": [UIColor redColor]
															},
														@{
															@"text": @"My dad isn’t famous. My dad plays jazz. You can’t get famous playing jazz",
															@"date": [NSDate date],
															@"type": @(AMBubbleCellSent)
															},
														@{
															@"date": [NSDate date],
															@"type": @(AMBubbleCellTimestamp)
															},
														@{
															@"text": @"I'd far rather be happy than right any day.",
															@"date": [NSDate date],
															@"type": @(AMBubbleCellReceived),
															@"username": @"John",
															@"color": [UIColor orangeColor]
															},
														@{
															@"text": @"The only reason for walking into the jaws of Death is so's you can steal His gold teeth.",
															@"date": [NSDate date],
															@"type": @(AMBubbleCellSent)
															},
														@{
															@"text": @"The gods had a habit of going round to atheists' houses and smashing their windows.",
															@"date": [NSDate date],
															@"type": @(AMBubbleCellReceived),
															@"username": @"Jimi",
															@"color": [UIColor blueColor]
															},
														@{
															@"text": @"you are lucky. Your friend is going to meet Bel-Shamharoth. You will only die.",
															@"date": [NSDate date],
															@"type": @(AMBubbleCellSent)
															},
														@{
															@"text": @"Guess the quotes!",
															@"date": [NSDate date],
															@"type": @(AMBubbleCellSent)
															},
														]
				 ];
	
	// Set a style
	[self setTableStyle:AMBubbleTableStyleFlat];
	
	[self setBubbleTableOptions:@{AMOptionsBubbleDetectionType: @(UIDataDetectorTypeAll),
								  AMOptionsBubblePressEnabled: @NO,
								  AMOptionsBubbleSwipeEnabled: @YES,
                                  AMOptionsButtonTextColor: [UIColor colorWithRed:1.0f green:1.0f blue:184.0f/256 alpha:1.0f]}];
	
	// Call super after setting up the options
	[super viewDidLoad];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
//    self.tableView.opaque = NO;
//    self.tableView.backgroundView = nil;
    

}

- (void)swipedCellAtIndexPath:(NSIndexPath *)indexPath withFrame:(CGRect)frame andDirection:(UISwipeGestureRecognizerDirection)direction
{
	NSLog(@"swiped");
}

#pragma mark - AMBubbleTableDataSource

- (NSInteger)numberOfRows
{
	return self.data.count;
}

- (AMBubbleCellType)cellTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [self.data[indexPath.row][@"type"] intValue];
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.data[indexPath.row][@"text"];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [NSDate date];
}

- (UIImage*)avatarForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return [UIImage imageNamed:@"avatar"];
}

#pragma mark - AMBubbleTableDelegate

- (void)didSendText:(NSString*)text
{
	NSLog(@"User wrote: %@", text);
	
	[self.data addObject:@{ @"text": text,
							@"date": [NSDate date],
							@"type": @(AMBubbleCellSent)
							}];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.data.count - 1) inSection:0];
	[self.tableView beginUpdates];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
	[self.tableView endUpdates];
    // Either do this:
    [self scrollToBottomAnimated:YES];
    // or this:
	// [super reloadTableScrollingToBottom:YES];
}

- (NSString*)usernameForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.data[indexPath.row][@"username"];
}

- (UIColor*)usernameColorForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return self.data[indexPath.row][@"color"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

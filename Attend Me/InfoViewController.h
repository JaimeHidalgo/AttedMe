//
//  InfoViewController.h
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>
@interface InfoViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (strong,nonatomic) PFObject *currentStudent;

@end

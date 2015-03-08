//
//  InfoViewController.m
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//

#import "InfoViewController.h"
#import <Parse/Parse.h>
#import <MessageUI/MessageUI.h>
@interface InfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *studentsPhoto;
@property (weak, nonatomic) IBOutlet UILabel *roomLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateArribalLabel;
@property (weak, nonatomic) IBOutlet UILabel *chasidesShiurLabel;
@property (weak, nonatomic) IBOutlet UILabel *gemaraShiurLabel;

@end

@implementation InfoViewController

@synthesize currentStudent,nameLabel,lastNameLabel,studentsPhoto,roomLabel,emailLabel,dateArribalLabel,chasidesShiurLabel,gemaraShiurLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSString *name = [currentStudent objectForKey:@"Name"];
    NSString *lastName = [currentStudent objectForKey:@"LastName"];
    NSString *email = [currentStudent objectForKey:@"email"];
    NSString *chasidusShiur = [currentStudent objectForKey:@"chasidusShiur"];
    NSString *gemaraShiur = [currentStudent objectForKey:@"gemaraShiur"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM dd,YYYY"];
    NSString *dateArribal = [formatter stringFromDate:[currentStudent objectForKey:@"dateArribal"]];
    
    NSString *room = [currentStudent objectForKey:@"room"];
    nameLabel.text = name;
    lastNameLabel.text = lastName;
    roomLabel.text = room;
    emailLabel.text = email;
    chasidesShiurLabel.text = chasidusShiur;
    gemaraShiurLabel.text = gemaraShiur;
    dateArribalLabel.text = dateArribal;
    
    PFFile *userImageFile = currentStudent[@"Photo"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            studentsPhoto.image = [UIImage imageWithData:imageData];
        }
    }];
    
    
}
- (IBAction)email:(id)sender {
    NSString *emailTitle = @"Test Email";
    NSString *messageBody = @"ios programming is so fun";
    NSArray *toRecipents = [NSArray arrayWithObject:@"jhmcf316@gmail.com"];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    [self presentViewController:mc animated:YES completion:NULL];
    
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
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
//
//  ViewController.m
//  Attend Me
//
//  Created by F@5 on 2/18/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//


#import "ViewController.h"
#import "MyLoginViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *labelStatus;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    if (![PFUser currentUser]) {
        
        MyLoginViewController *logInViewController = [[MyLoginViewController alloc]init];
        
        [logInViewController setDelegate:self];
        PFSignUpViewController *signupViewController = [[PFSignUpViewController alloc]init];
        [signupViewController setDelegate:self];
        [logInViewController setSignUpController:signupViewController];
        [self presentViewController:logInViewController animated:YES completion:NULL];
    } else{
        //self.labelStatus.text = [NSString stringWithFormat:@"Welcome %@",[PFUser currentUser].username];
        
    }
}
- (BOOL) logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password{
    
    if (username&& password &&username.length && password.length){
        return YES;
        
    }
    
    NSLog(@"Missing information");
    return NO;
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    NSLog(@"you log in");
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void) logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error{
    NSLog(@"Failed to log in...");
}

- (void) logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end

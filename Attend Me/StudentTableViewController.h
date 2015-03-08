//
//  StudentTableViewController.h
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "InfoViewController.h"
#import <GameKit/GameKit.h>
@interface StudentTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *studentsArray;
}

@property (nonatomic, strong) IBOutlet UITableView *tableview;
@property (weak, nonatomic) PFObject *student;
@property (weak, nonatomic) IBOutlet UILabel *LastName;

@end

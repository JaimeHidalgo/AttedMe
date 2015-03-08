//
//  ShiurTableViewController.h
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayAttendanceTableTableViewController.h"
#import "AttendanceCollectionViewControllerTableViewController.h"
@interface ShiurTableViewController : UITableViewController
@property (nonatomic,strong) NSString *classNameNow;
@property (nonatomic, strong) NSMutableArray *arrayToPass;
@end

//
//  AttendanceCollectionViewControllerTableViewController.h
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttendanceCollectionViewController : UICollectionViewController
@property (nonatomic, strong) NSString *classNameParse;
@property (nonatomic, strong) NSString *rowNameParse;
@property (nonatomic,strong) NSArray *objectArray;
@property (nonatomic, strong) NSMutableArray *students;
@property (nonatomic, strong)  NSMutableArray *otherStudents;
@property (readonly) NSUInteger shiurCount;
@end

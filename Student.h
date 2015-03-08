//
//  Student.h
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
@interface Student : NSObject
@property NSString *name;
@property NSString *lastName;
@property NSString *email;
@property NSString *phoneNumber;
@property NSString *attention;
@property NSString *chasidusShiur;
@property NSString *gemaraShiur;
@property NSString *room;
@property NSString *dateArrived;
@property UIImage *photo;
@end
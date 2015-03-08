//
//  AttendanceCollectionViewControllerTableViewController.m
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//

#import "AttendanceCollectionViewControllerTableViewController.h"
#import "cell.h"
#import "Student.h"
#import <Parse/Parse.h>
@interface AttendanceCollectionViewController (){
    
    NSString *onlyForRabbi;
    NSMutableArray *chasidusGemaraShiur;
    NSMutableArray *shacharisMincha;
    NSMutableArray *gemaraShiur;
    NSMutableArray *chasidusShiur;
    int counting;
    int stam;
    
    int a;
}


@end

@implementation AttendanceCollectionViewController
@synthesize classNameParse, rowNameParse,objectArray,students,otherStudents,shiurCount;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self performSelector:@selector(retrieveFromParse)];
    self.title = rowNameParse;
    a = 0;
    
    counting = 0;
    
    chasidusShiur = [[NSMutableArray alloc]init];
    gemaraShiur = [[NSMutableArray alloc]init];
    chasidusGemaraShiur = [[NSMutableArray alloc]init];
    shacharisMincha = [[NSMutableArray alloc]init];
    otherStudents = [[NSMutableArray alloc]init];
    if ([rowNameParse  isEqual: @"Chasiduss Morning"]) {
        rowNameParse = @"chasidussMorning";
    }else if([rowNameParse  isEqual: @"Guemara Morning"]){
        rowNameParse = @"guemaraMorning";
    }else if ([rowNameParse  isEqual: @"Shacharis"]){
        rowNameParse = @"shacharis";
    }else if ([rowNameParse  isEqual: @"Afteernoon Sedder"]){
        rowNameParse = @"afternoonSedder";
    }else if ([rowNameParse  isEqual: @"Chasidus Night"]){
        rowNameParse = @"chasidusNight";
    }else if([rowNameParse isEqual:@"Mincha"]){
        rowNameParse = @"mincha";
    }
    if ([rowNameParse  isEqual: @"chasidussMorning"]) {
        PFObject * rabbi = [PFUser currentUser];
        NSString *rabbiName = [rabbi objectForKey:@"username"];
        for (int i = 0 ; i < [students count]; i++) {
            Student *tempStudent = [[Student alloc]init];
            tempStudent = [students objectAtIndex:i];
            if ( [tempStudent.chasidusShiur isEqual:rabbiName]) {
                [chasidusGemaraShiur addObject:tempStudent];
                shiurCount++;
            
            }else if([tempStudent.gemaraShiur isEqual:rabbiName]){
                [gemaraShiur addObject:tempStudent];
            }else{
             
                [otherStudents addObject:tempStudent];
            }
        }
        PFQuery *query = [PFQuery queryWithClassName:classNameParse];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if ([objects count] == 0) {
                for (int i = 0 ; i < [chasidusGemaraShiur count]; i++) {
                    Student *student = [[Student alloc]init];
                    student = [chasidusGemaraShiur objectAtIndex:i];
                    NSString *name = student.name;
                    NSString *lastName = student.lastName;
                    NSString *attend = @"2";
                    PFObject *save =[PFObject objectWithClassName:classNameParse];
                    save[@"name"] = name;
                    save[@"lastName"] = lastName;
                    save[rowNameParse] = attend;
                    [save saveInBackground];
                }
            }else{
                for (Student *alef in gemaraShiur) {
                    NSLog(@"the name is %@",alef.name);
                }
                NSLog(@"antes de la comparacion el objects es %lu y gemara es %lu",(unsigned long)[objects count],(unsigned long)[gemaraShiur count]);
                if ([objects count] == [gemaraShiur count]) {
                    NSLog(@"hola amigos t");
                    for (int j = 0 ; [gemaraShiur count]; j++) {
                        Student *student = [[Student alloc]init];
                        student = [chasidusGemaraShiur objectAtIndex:j];
                        NSString *name = student.name;
                        NSString *lastName = student.lastName;
                        NSString *attend = @"2";
                        
                        PFObject *save =[PFObject objectWithClassName:classNameParse];
                        save[@"name"] = name;
                        save[@"lastName"] = lastName;
                        save[rowNameParse] = attend;
                        [save saveInBackground];
                    }
                }

                for (int i = 0; i < [chasidusGemaraShiur count]; i++) {
                    for (int j = 0; j < [objects count]; j++) {
                        PFObject *tempObject = [objects objectAtIndex:j];
                        Student *studentChasidus = [[Student alloc]init];
                        Student *studentObjects = [[Student alloc]init];
                        studentChasidus = [chasidusGemaraShiur objectAtIndex:i];
                        studentObjects.lastName = [tempObject objectForKey:@"lastName"];
                        studentObjects.attention = [tempObject objectForKey:rowNameParse];
                        if ([studentChasidus.lastName isEqual:studentObjects.lastName]) {
                            if (studentObjects.attention == NULL) {
                                NSString *lastName = studentObjects.lastName;
                                
                                PFQuery *querySave = [PFQuery queryWithClassName:classNameParse];
                                [querySave whereKey:@"lastName" hasPrefix:lastName];
                                [querySave getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                                    object[rowNameParse] = @"2";
                                    [object saveInBackground];
                                }];
                            }
                            
                        }
                    }
                }
            }
        }];
    }else if ([rowNameParse  isEqual: @"guemaraMorning"]) {
        PFObject * rabbi = [PFUser currentUser];
        NSString *rabbiName = [rabbi objectForKey:@"username"];
        for (int i = 0 ; i < [students count]; i++) {
            Student *tempStudent = [[Student alloc]init];
            tempStudent = [students objectAtIndex:i];
            if ([tempStudent.gemaraShiur isEqual:rabbiName]) {
                [chasidusGemaraShiur addObject:tempStudent];
                shiurCount++;
            }else if([tempStudent.chasidusShiur isEqual:rabbiName]){
                [chasidusShiur addObject:tempStudent];
            }else{
                [otherStudents addObject:tempStudent];
            }
        }
        PFQuery *query = [PFQuery queryWithClassName:classNameParse];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if ([objects count] == 0) {
                for (int i = 0 ; i < [chasidusGemaraShiur count]; i++) {
                    Student *student = [[Student alloc]init];
                    student = [chasidusGemaraShiur objectAtIndex:i];
                    NSString *name = student.name;
                    NSString *lastName = student.lastName;
                    NSString *attend = @"2";
                    PFObject *save =[PFObject objectWithClassName:classNameParse];
                    save[@"name"] = name;
                    save[@"lastName"] = lastName;
                    save[rowNameParse] = attend;
                    [save saveInBackground];
                }
            }else{
                if ([chasidusShiur count] == [objects count]) {
                    NSLog(@"hola amigos");
                    for (int i = 0; i < [chasidusShiur  count]; i++) {
                        
                        Student *student = [[Student alloc]init];
                        student = [chasidusGemaraShiur objectAtIndex:i];
                        NSString *name = student.name;
                        NSString *lastName = student.lastName;
                        NSString *attend = @"2";
                        NSLog(@"the student is %@",student.name);
                        PFObject *save =[PFObject objectWithClassName:classNameParse];
                        save[@"name"] = name;
                        save[@"lastName"] = lastName;
                        save[rowNameParse] = attend;
                        [save saveInBackground];
                    }
                }
                
                for (int i = 0; i < [chasidusGemaraShiur count]; i++) {
                    for (int j = 0; j < [objects count]; j++) {
                        PFObject *tempObject = [objects objectAtIndex:j];
                        Student *studentChasidus = [[Student alloc]init];
                        Student *studentObjects = [[Student alloc]init];
                        studentChasidus = [chasidusGemaraShiur objectAtIndex:i];
                        studentObjects.lastName = [tempObject objectForKey:@"lastName"];
                        studentObjects.attention = [tempObject objectForKey:rowNameParse];
                        if ([studentChasidus.lastName isEqual:studentObjects.lastName]) {
                            if (studentObjects.attention == NULL) {
                                NSString *lastName = studentObjects.lastName;
                                
                                PFQuery *querySave = [PFQuery queryWithClassName:classNameParse];
                                [querySave whereKey:@"lastName" hasPrefix:lastName];
                                [querySave getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                                    object[rowNameParse] = @"2";
                                    [object saveInBackground];
                                }];
                            }
                            
                        }
                    }
                }
            }
        }];
    }else{
        NSLog(@"hola esta parte se esta haciendo!!");
        shiurCount = [students count];
        PFObject * rabbi = [PFUser currentUser];
        NSString *rabbiName = [rabbi objectForKey:@"username"];
        for (int i = 0 ; i < [students count]; i++) {
            Student *tempStudent = [[Student alloc]init];
            tempStudent = [students objectAtIndex:i];
            [shacharisMincha addObject:tempStudent];
            if ([tempStudent.gemaraShiur isEqual:rabbiName]|| [tempStudent.chasidusShiur isEqual:rabbiName]) {
                [chasidusGemaraShiur addObject:tempStudent];
            }else{
                
                [otherStudents addObject:tempStudent];
            }
        }
        PFQuery *query = [PFQuery queryWithClassName:classNameParse];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if ([objects count] == 0) {
                for (int i = 0; i < [students count]; i++) {
                    Student *student = [[Student alloc]init];
                    student = [students objectAtIndex:i];
                    NSString *name = student.name;
                    NSString *lastName = student.lastName;
                    NSString *attend = @"2";
                    PFObject *save =[PFObject objectWithClassName:classNameParse];
                    save[@"name"] = name;
                    save[@"lastName"] = lastName;
                    save[rowNameParse] = attend;
                    [save saveInBackground];
                }
            }else{
                
                if ([objects count] == [chasidusGemaraShiur count]) {
                    for (int i = 0; i < [otherStudents count]; i++) {
                        Student *student = [[Student alloc]init];
                        student = [otherStudents objectAtIndex:i];
                        NSString *name = student.name;
                        NSString *lastName = student.lastName;
                        NSString *attend = @"2";
                        PFObject *save =[PFObject objectWithClassName:classNameParse];
                        save[@"name"] = name;
                        save[@"lastName"] = lastName;
                        save[rowNameParse] = attend;
                        [save saveInBackground];
                    }
                }
                for (int i = 0; i < [shacharisMincha count]; i++) {
                    
                    for (int j = 0; j < [objects count]; j++) {
                        
                        PFObject *tempObject = [objects objectAtIndex:j];
                        Student *tempStudent = [[Student alloc]init];
                        tempStudent = [shacharisMincha objectAtIndex:i];
                        Student *studentCompare = [[Student alloc]init];
                        studentCompare.lastName = [tempObject objectForKey:@"lastName"];
                        studentCompare.attention = [tempObject objectForKey:rowNameParse];
                        if ([studentCompare.lastName isEqual:tempStudent.lastName]) {
                            if (studentCompare.attention == NULL) {
                                
                                NSString *lastName = studentCompare.lastName;
                                PFQuery *querySave = [PFQuery queryWithClassName:classNameParse];
                                [querySave whereKey:@"lastName" hasPrefix:lastName];
                                [querySave getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                                    object[rowNameParse] = @"2";
                                    [object saveInBackground];
                                }];
                            }
                        }
                    }
                }
            }
        }];
        
    }
    
}


-(void)retrieveFromParse{
    PFQuery *retrieveNames = [PFQuery queryWithClassName:classNameParse];
    [retrieveNames orderByAscending:@"lastName"];
    [retrieveNames findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        if(!error){
            objectArray = [[NSArray alloc]initWithArray:objects];
        }[self.collectionView reloadData];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return shiurCount;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    cell *aCell =[collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    if ([rowNameParse  isEqual: @"Chasiduss Morning"]) {
        rowNameParse = @"chasidussMorning";
    }else if([rowNameParse  isEqual: @"Guemara Morning"]){
        rowNameParse = @"guemaraMorning";
    }else if ([rowNameParse  isEqual: @"Shacharis"]){
        rowNameParse = @"shacharis";
    }else if ([rowNameParse  isEqual: @"Afteernoon Sedder"]){
        rowNameParse = @"afternoonSedder";
    }else if ([rowNameParse  isEqual: @"Chasidus Night"]){
        rowNameParse = @"chasidusNight";
    }else if([rowNameParse isEqual:@"Mincha"]){
        rowNameParse = @"mincha";
    }
    
    Student *tempStudent = [[Student alloc]init];
    if (([rowNameParse isEqual:@"mincha"]) || ([rowNameParse isEqual:@"shacharis"])||([rowNameParse isEqual:@"afternoonSedder"])|| ([rowNameParse isEqual:@"chasidusNight"])){
        tempStudent = [shacharisMincha objectAtIndex:indexPath.row];
        aCell.NameLabel.text = tempStudent.name;
        
        
        aCell.studentPhoto.image = tempStudent.photo;
        PFQuery *query = [PFQuery queryWithClassName:classNameParse];
        [query whereKey:@"lastName" hasPrefix:tempStudent.lastName];
        [ query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            tempStudent.attention = [object objectForKey:rowNameParse];
            
            if([tempStudent.attention isEqual:@"2"]){
                aCell.backgroundColor = [UIColor greenColor];
            }else if ([tempStudent.attention isEqual:@"1"]){
                aCell.backgroundColor = [UIColor orangeColor];
            }else if ([tempStudent.attention isEqual:@"0"]){
                aCell.backgroundColor = [UIColor redColor];
            }
        }];
    }else{
        
        Student *tempObject = [chasidusGemaraShiur objectAtIndex:indexPath.row];
        aCell.NameLabel.text = tempObject.name;
        
        PFQuery *query = [PFQuery queryWithClassName:classNameParse];
        [query whereKey:@"lastName" hasPrefix:tempObject.lastName];
        [ query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            tempObject.attention = [object objectForKey:rowNameParse];
            
            if([tempObject.attention isEqual:@"2"]){
                aCell.backgroundColor = [UIColor greenColor];
            }else if ([tempObject.attention isEqual:@"1"]){
                aCell.backgroundColor = [UIColor orangeColor];
            }else if ([tempObject.attention isEqual:@"0"]){
                aCell.backgroundColor = [UIColor redColor];
            }
        }];
        aCell.studentPhoto.image = tempObject.photo;
        
        aCell.backgroundColor = [UIColor greenColor];
    }
    
    
    return aCell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([rowNameParse  isEqual: @"Chasiduss Morning"]) {
        rowNameParse = @"chasidussMorning";
    }else if([rowNameParse  isEqual: @"Guemara Morning"]){
        rowNameParse = @"guemaraMorning";
    }else if ([rowNameParse  isEqual: @"Shacharis"]){
        rowNameParse = @"shacharis";
    }else if([rowNameParse  isEqual: @"Mincha"]){
        rowNameParse = @"mincha";
    }else if ([rowNameParse  isEqual: @"Afteernoon Sedder"]){
        rowNameParse = @"afternoonSedder";
    }else if ([rowNameParse  isEqual: @"Chasidus Night"]){
        rowNameParse = @"chasidusNight";
    }
    PFQuery *query = [PFQuery queryWithClassName:classNameParse];
    if ([rowNameParse  isEqual: @"chasidussMorning"]||[rowNameParse  isEqual: @"guemaraMorning"]) {
        Student *tempObject = [chasidusGemaraShiur objectAtIndex:indexPath.row] ;
        NSString *nombre = tempObject.name;
        NSString *lastName = tempObject.lastName;
        [query whereKey:@"lastName" hasPrefix:lastName];
        [query whereKey:@"name" hasPrefix:nombre];
    } else {
        Student *tempObject = [students objectAtIndex:indexPath.row];
        
        NSString *nombre = tempObject.name;
        NSString *lastName = tempObject.lastName;
        [query whereKey:@"lastName" hasPrefix:lastName];
        [query whereKey:@"name" hasPrefix:nombre];
    }
    
    
    
    
    if (cell.backgroundColor == [UIColor greenColor]){
        cell.backgroundColor = [UIColor redColor];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            object[rowNameParse] = @"0";
            [object saveInBackground];
        }];
    }else if (cell.backgroundColor == [UIColor redColor]){
        cell.backgroundColor = [UIColor orangeColor];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            object[rowNameParse] = @"1";
            [object saveInBackground];
        }];
    }else if (cell.backgroundColor == [UIColor orangeColor]){
        cell.backgroundColor = [UIColor greenColor];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            object[rowNameParse] = @"2";
            [object saveInBackground];
        }];
        
    }
    
}




@end
//
//  DayAttendanceTableTableViewController.m
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//

#import "DayAttendanceTableTableViewController.h"
#import "Student.h"
#import <Parse/Parse.h>
@interface DayAttendanceTableViewController (){
    NSArray *daysArray;
    
    NSMutableArray *studentsToPass;
    
}

@end

@implementation DayAttendanceTableViewController
@synthesize tempNames;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    daysArray = @[@"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Motzei Shabbos"];
    [self performSelector:@selector(retrieveNames)];
    
   
    
}
-(void)retrieveNames{
    PFQuery *retrieveNames = [PFQuery queryWithClassName:@"Students"];
    [retrieveNames orderByAscending:@"LastName"];
    [retrieveNames findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        studentsToPass = [[NSMutableArray alloc]init];
         NSLog(@"the array is %@",studentsToPass);
        if(!error){
            tempNames = [[NSArray alloc]initWithArray:objects];
            for (int i = 0; i < [tempNames count]; i++) {
                PFObject *tempObject = [tempNames objectAtIndex:i];
                Student *student = [[Student alloc]init];
                student.name = [tempObject objectForKey:@"Name"];
                student.lastName = [tempObject objectForKey:@"LastName"];
                student.room = [tempObject objectForKey:@"room"];
                student.email = [tempObject objectForKey:@"email"];
                student.phoneNumber = [tempObject objectForKey:@"Phone_Number"];
                student.chasidusShiur = [tempObject objectForKey:@"chasidusShiur"];
                student.gemaraShiur = [tempObject objectForKey:@"gemaraShiur"];
                PFFile *imageParse = [tempObject objectForKey:@"Photo"];
                [imageParse getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if(!error){
                        student.photo = [UIImage imageWithData:data];
                    }
                }];
                [studentsToPass addObject:student];
            }
            
        }
        if ([objects count] == 0) {
            
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return daysArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = daysArray[indexPath.row];
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    ShiurTableViewController *acvc = [segue destinationViewController];
    
    // Pass the selected object to the new view controller.
    
        acvc.arrayToPass = studentsToPass;
        acvc.classNameNow = [daysArray objectAtIndex:indexPath.row];
    

    
    
}

@end
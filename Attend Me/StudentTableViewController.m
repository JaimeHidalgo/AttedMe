//
//  StudentTableViewController.m
//  Attend Me
//
//  Created by F@5 on 2/22/15.
//  Copyright (c) 2015 F@5. All rights reserved.
//

#import "StudentTableViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "InfoViewController.h"

@interface StudentTableViewController ()
@property (strong,nonatomic) NSString *passStudent;
@end

@implementation StudentTableViewController
@synthesize passStudent;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self performSelector:@selector(retrieveFromParse)];
}
-(void)retrieveFromParse{
    PFQuery *retrieveNames = [PFQuery queryWithClassName:@"Students"];
    [retrieveNames findObjectsInBackgroundWithBlock:^(NSArray *objects,NSError *error){
        if(!error){
            studentsArray = [[NSArray alloc]initWithArray:objects];
            
        }[self.tableView reloadData];
        
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
    return studentsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cellStudent";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *tempObject = [studentsArray objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    NSString *lastName = [tempObject objectForKey:@"LastName"];
    NSString *name = [tempObject objectForKey:@"Name"];
    NSString *together = [NSString stringWithFormat:@"%@ %@",name,lastName];
    cell.textLabel.text = together;
    
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
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    InfoViewController *pvc = [segue destinationViewController];
    
    //[[segue destinationViewController] setObject:object];
    NSLog(@"Antes de ser parado el objeto:%@",passStudent);
    pvc.currentStudent = [studentsArray objectAtIndex:indexPath.row];
}


@end


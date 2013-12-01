//
//  SubsystemViewController.m
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "SubsystemViewController.h"


@implementation SubsystemViewController

@synthesize subsystems;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Get subsystem
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 //   [CampusAPI setSessionID:[CampusAPI getAuth:@"123" withPassword:@"123"]];
    
    isNeedUpdate = true;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(isNeedUpdate) {
        if ([CampusAPI sessionID]!=nil) {
            //subsystems = [CampusAPI getPermissions:[CampusAPI sessionID]];
            userData = [CampusAPI getCurrentUser:[CampusAPI sessionID]];
            photo = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:userData.urlPhoto]];
            [self.tableView reloadData];
            isNeedUpdate = false;
        }
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [userData.profiles count]+[userData.employees count] + [userData.personalities count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier1 = @"SubsystemCell";
    static NSString *CellIdentifier2 = @"InfoCell";
    static NSString *CellIdentifier3 = @"PersonalitiesCell";
    static NSString *CellIdentifier4 = @"EmployeesCell";
    
    if (indexPath.row == 0) {
        
        InfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell.image setImage:photo];
        cell.fullName.text = userData.fullName;
        return cell;
        
    } else if(indexPath.row > 0 && indexPath.row < (1 +[userData.personalities count])) {
        NSLog(@"%ld in (%d,%d)", (long)indexPath.row, 0, 1 +[userData.personalities count]);
        PersonalitiesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PersonalitiesCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        Personalities *personalities = [userData.personalities objectAtIndex:indexPath.row-1];
        cell.subdivisionName.text = personalities.subdivisionName;
        cell.studyGroupName.text = personalities.studyGroupName;
        cell.isContract.text = personalities.isContract?@"Так":@"Ні";
        cell.speciality.text = personalities.specialty;
        return cell;
    } else if(indexPath.row >= (1 +[userData.personalities count]) && indexPath.row < (1 +[userData.personalities count] + [userData.employees count])) {
         NSLog(@"%ld in (%d,%d)", (long)indexPath.row,  [userData.personalities count], 1 +[userData.personalities count] + [userData.employees count] );
        EmployeeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier4];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EmployeesCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        Employee *employee = [userData.employees objectAtIndex:indexPath.row - [userData.personalities count] - 1];
        cell.subdivisionName.text = employee.subdivisionName;
        cell.position.text = employee.position;
        cell.academicDegree.text = employee.academicDegree;
        cell.academicStatus.text = employee.academicStatus;
        return cell;
    } else {
        NSLog(@"%ld in (%d,%d)", (long)indexPath.row,  1 +[userData.personalities count] + [userData.employees count], indexPath.row + [userData.personalities count] + [userData.employees count] + 1);
        SubsystemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SubsystemCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        Profile *profile = [userData.profiles objectAtIndex:indexPath.row - [userData.personalities count] -[userData.employees count] - 1];
        cell.subSystemName.text = profile.subsystemName;
        cell.isCreate.text = profile.isCreate?@"Так":@"Ні";
        cell.isRead.text = profile.isRead?@"Так":@"Ні";
        cell.isUpdate.text = profile.isUpdate?@"Так":@"Ні";
        cell.isDelete.text = profile.isDelete?@"Так":@"Ні";
        
        return cell;
    }
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end

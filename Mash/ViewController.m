//
//  ViewController.m
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"
#import "VideoPlayerViewController.h"
#import "Video.h"
#import "SendVideoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.groups = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Group"];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                Group *testGroup = [[Group alloc] init];
                testGroup.groupName = object[@"name"];
                
                [self.groups addObject:testGroup];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Cell";
    
    Cell *cell = (Cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.groupLabel.text = [[self.groups objectAtIndex:indexPath.row] groupName];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedGroup = [self.groups objectAtIndex:indexPath.row];

    [self performSegueWithIdentifier:@"watchMash" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"watchMash"])
    {
        VideoPlayerViewController* destvc = [segue destinationViewController];
        destvc.group = self.selectedGroup;
    }
    
    else if ([segue.identifier isEqualToString:@"chooseGroups"])
    {
        SendVideoViewController *destvc = [segue destinationViewController];
        destvc.groupNames = self.groups;
        destvc.videoURL = [[self.videoURL absoluteString] substringFromIndex:7];
        
    }
}

- (IBAction)captureVideo:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *)kUTTypeMovie, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.videoURL = info[UIImagePickerControllerMediaURL];
    
    [picker dismissViewControllerAnimated:YES completion:^(){
        [self performSegueWithIdentifier:@"chooseGroups" sender:self];
    }];
    

}


@end

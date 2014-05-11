//
//  SendVideoViewController.m
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import "SendVideoViewController.h"
#import "Cell.h"
#import "Group.h"
#import <Parse/Parse.h>

@interface SendVideoViewController ()
{
    long incrementName;
}
@end

@implementation SendVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableview.allowsMultipleSelection = YES;
    self.recipients = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groupNames count];
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
    
    cell.groupLabel.text = [[self.groupNames objectAtIndex:indexPath.row] groupName];
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell* cell = (Cell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.groupImage.image = [UIImage imageNamed:@"selected.png"];
    [self.recipients addObject:cell.groupLabel.text];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell* cell = (Cell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.groupImage.image = [UIImage imageNamed:@"select.png"];
    [self.recipients removeObject:cell.groupLabel.text];

}

-(IBAction)sendVideo:(id)sender
{
    incrementName++;
    PFFile* videoFile = [PFFile fileWithName:[NSString stringWithFormat:@"%ld", incrementName] contentsAtPath:self.videoURL];
    [videoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        PFQuery *query = [PFQuery queryWithClassName:@"Group"];
        [query whereKey:@"name" containedIn:self.recipients];
        [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError*error){
            for (PFObject*object in objects)
            {
                PFObject *group = object;
                PFObject *video = [PFObject objectWithClassName:@"Video"];
                video[@"group"]= group;
                
                [video setObject:videoFile forKey:@"file"];
                [video setObject:[NSNumber numberWithInt:self.duration] forKey:@"duration"];
                [video saveInBackground];
            }
        }];
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

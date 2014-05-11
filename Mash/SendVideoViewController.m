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
#import <CommonCrypto/CommonDigest.h>

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
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
    backView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = backView;
    cell.backgroundColor = [UIColor clearColor];
    
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
    cell.groupImage.image = [UIImage imageNamed:@"selected_full.png"];
    [self.recipients addObject:cell.groupLabel.text];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Cell* cell = (Cell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.groupImage.image = [UIImage imageNamed:@"select_thin.png"];
    [self.recipients removeObject:cell.groupLabel.text];

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}

-(IBAction)sendVideo:(id)sender
{
    NSDate *date = [NSDate date];
    double timePassed_ms = [date timeIntervalSinceNow] * -1000.0;
    NSString*dateString = [NSString stringWithFormat:@"%f", timePassed_ms];
    
    PFFile* videoFile = [PFFile fileWithName:[NSString stringWithFormat:@"%@", [self md5:dateString]] contentsAtPath:self.videoURL];
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

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}

@end

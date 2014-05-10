//
//  VideoPlayerViewController.m
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "MashActionViewController.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

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
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
    self.videoController = [[MPMoviePlayerController alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mashEnded)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    if(self.videoURL==0)
        NSLog(@"Err");
    else
    {
        [self.videoController setContentURL:self.videoURL];
        [self.videoController.view setFrame:CGRectMake (0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [self.videoController setScalingMode:MPMovieScalingModeFill];
        [self.videoController setShouldAutoplay:YES];
        [self.view addSubview:self.videoController.view];
    }
    
    [self.videoController play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mashEnded {
    
    [self performSegueWithIdentifier:@"mashEnded" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"mashEnded"])
    {
        MashActionViewController *destvc = [segue destinationViewController];
        destvc.videoURL = self.videoURL;
    }
}


@end

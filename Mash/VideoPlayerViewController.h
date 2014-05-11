//
//  VideoPlayerViewController.h
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Parse/Parse.h>
#import "Group.h"
#import "ActionView.h"
#import "MashActionViewController.h"

@interface VideoPlayerViewController : UIViewController <ActionViewDelegate, MashActionViewDelegate>

@property (strong, nonatomic) Group * group;
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@property (strong, nonatomic) Mash* mash;
@end

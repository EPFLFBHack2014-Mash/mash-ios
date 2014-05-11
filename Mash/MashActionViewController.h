//
//  MashActionViewController.h
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MashActionViewDelegate;


@interface MashActionViewController : UIViewController
@property (nonatomic, weak) id<MashActionViewDelegate> delegate;
- (IBAction)replay:(id)sender;
-(IBAction)mashItUp:(id)sender;
-(IBAction)saveToCameraRoll:(id)sender;

@property (strong, nonatomic) NSURL *videoURL;

@end


@protocol MashActionViewDelegate <NSObject>

- (void)didPressReplay:(MashActionViewController*)view;
- (void)didPressMash:(MashActionViewController*)view;
- (void)didPressSave:(MashActionViewController*)view;

@end
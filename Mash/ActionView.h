//
//  ActionView.h
//  Mash
//
//  Created by Dylan Bourgeois on 11/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActionViewDelegate;

@interface ActionView : UIView

@property (nonatomic, weak) id<ActionViewDelegate> delegate;
- (IBAction)replay:(id)sender;
-(IBAction)mashItUp:(id)sender;

@property (nonatomic, strong) NSURL *videoURL;

@end

@protocol ActionViewDelegate <NSObject>

- (void)childViewDidPressReplay:(ActionView*)view;
- (void)childViewDidPressMash:(ActionView*)view;

@end
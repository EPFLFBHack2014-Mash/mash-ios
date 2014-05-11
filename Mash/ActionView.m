//
//  ActionView.m
//  Mash
//
//  Created by Dylan Bourgeois on 11/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import "ActionView.h"

@implementation ActionView
{
    BOOL hidden;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(IBAction)mashItUp:(id)sender
{
    id<ActionViewDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(childViewDidPressMash:)]) {
        [strongDelegate childViewDidPressMash:self];
    }
}

-(IBAction)save:(id)sender
{
    NSURL *mashUrl = self.videoURL;
    UISaveVideoAtPathToSavedPhotosAlbum([mashUrl relativePath],self,nil, nil);
}

- (IBAction)replay:(id)sender {
    
    id<ActionViewDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(childViewDidPressReplay:)]) {
        [strongDelegate childViewDidPressReplay:self];
    }
}



@end

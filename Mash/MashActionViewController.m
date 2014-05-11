//
//  MashActionViewController.m
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import "MashActionViewController.h"

@interface MashActionViewController ()

@end

@implementation MashActionViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveToCameraRoll:(id)sender{
    id<MashActionViewDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(didPressSave:)]) {
        [strongDelegate didPressSave:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)mashItUp:(id)sender
{
    id<MashActionViewDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(didPressMash:)]) {
        [strongDelegate didPressMash:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)replay:(id)sender {
    
    id<MashActionViewDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(didPressReplay:)]) {
        [strongDelegate didPressReplay:self];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}



@end

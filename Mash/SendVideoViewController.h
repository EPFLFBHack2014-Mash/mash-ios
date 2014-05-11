//
//  SendVideoViewController.h
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendVideoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) IBOutlet UITableView* tableview;

@property (nonatomic, strong) NSArray* groupNames;

@property (nonatomic, strong) NSString* videoURL;

@property (nonatomic,strong) NSMutableArray* recipients;

@property(nonatomic) int duration;

@property(nonatomic, strong) IBOutlet UINavigationBar*navigationBar;

@end

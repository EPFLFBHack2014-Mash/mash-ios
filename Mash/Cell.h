//
//  Cell.h
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell

@property (nonatomic,weak) IBOutlet UIImageView* groupImage;
@property (nonatomic, weak) IBOutlet UILabel* groupLabel;

@end

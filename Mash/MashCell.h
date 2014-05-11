//
//  MashCell.h
//  Mash
//
//  Created by Dylan Bourgeois on 11/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MashCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel* groupLabel;
@property (nonatomic, weak) IBOutlet UILabel*numberOfPermutationsLabel;
@end

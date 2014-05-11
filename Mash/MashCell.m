//
//  MashCell.m
//  Mash
//
//  Created by Dylan Bourgeois on 11/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import "MashCell.h"

@implementation MashCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

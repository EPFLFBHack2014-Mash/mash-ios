//
//  Group.h
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mash.h"

@interface Group : NSObject

@property(nonatomic, strong) NSString *groupName;
@property(nonatomic, strong) Mash *mash;

@end

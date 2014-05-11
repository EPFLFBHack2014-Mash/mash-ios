//
//  Mash.h
//  Mash
//
//  Created by Dylan Bourgeois on 10/05/14.
//  Copyright (c) 2014 Dylan Bourgeois. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mash : NSObject

/* Req to server for a new mash which is returned */
-(Mash*)mashItUp;

@property(strong, nonatomic) NSURL*mashURL;
@end

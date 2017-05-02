//
//  DMNSolDescription.m
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "DMNSolDescription.h"

@implementation DMNSolDescription

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _sol = [dictionary[@"sol"] integerValue];
        _numberOfPhotosTaken = [dictionary[@"total_photos"] integerValue];
        _cameras = [dictionary[@"cameras"] copy];
    }
    return self;
}

@end

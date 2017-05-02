//
//  DMNRover.h
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DMNRoverStatus) {
    DMNRoverStatusActive,
    DMNRoverStatusComplete,
};

@interface DMNRover : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDate *launchDate;
@property (nonatomic, strong, readonly) NSDate *landingDate;
@property (nonatomic, readonly) NSInteger maxSol;
@property (nonatomic, strong, readonly) NSDate *maxDate;
@property (nonatomic, readonly) NSInteger numberOfPhotos;
@property (nonatomic, strong, readonly) NSArray *solDescriptions;

@property (nonatomic, readonly) DMNRoverStatus status;

@end

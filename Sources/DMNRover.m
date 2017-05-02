//
//  DMNRover.m
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "DMNRover.h"
#import "DMNSolDescription.h"

@implementation DMNRover


- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        if (!_name) { return nil; }
        NSString *launchDateString = dictionary[@"launch_date"];
        _launchDate = [[[self class] dateFormatter] dateFromString:launchDateString];
        NSString *landingDateString = dictionary[@"landing_date"];
        _landingDate = [[[self class] dateFormatter] dateFromString:landingDateString];
        _status = [dictionary[@"status"] isEqualToString:@"active"] ? DMNRoverStatusActive : DMNRoverStatusComplete;
        _maxSol = [dictionary[@"max_sol"] integerValue];
        NSString *maxDateString = dictionary[@"max_date"];
        _maxDate = [[[self class] dateFormatter] dateFromString:maxDateString];
        _numberOfPhotos = [dictionary[@"total_photos"] integerValue];
        
        //Think this is broken.
        
        NSArray *solDescriptionDictionaries = dictionary[@"photos"];
        NSMutableArray *solDescriptions = [NSMutableArray array];
        for (NSDictionary *dict in solDescriptionDictionaries) {
            DMNSolDescription *solDescription = [[DMNSolDescription alloc] initWithDictionary:dict];
            if (!solDescription) { continue; }
            [solDescriptions addObject:solDescription];
        }
        _solDescriptions = [solDescriptions copy];
    }
    return self;
}

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
    });
    return dateFormatter;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ - %@ photos", [super description], self.name, @(self.numberOfPhotos)];
}

@end

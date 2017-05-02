//
//  DMNPhoto.m
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "DMNPhoto.h"

@implementation DMNPhoto


- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (!dictionary[@"id"]) { return nil; }
        
        //Fix me
        
        _photoID = [dictionary[@"id"] integerValue];
        _solDate = [dictionary[@"sol"] integerValue];
        _cameraName = dictionary[@"camera"][@"name"];
        NSString *earthDateString = dictionary[@"earth_date"];
        _earthDate = [[[self class] dateFormatter] dateFromString:earthDateString];
        _photoURL = [NSURL URLWithString:dictionary[@"img_src"]];
        if (!_photoURL) { return nil; }
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

- (BOOL)isEqual:(id)object
{
    if (!object || ![object isKindOfClass:[DMNPhoto class]]) { return NO; }
    DMNPhoto *photo = object;
    if (photo.photoID != self.photoID) { return NO; }
    if (photo.solDate != self.solDate) { return NO; }
    if (![photo.cameraName isEqualToString:self.cameraName]) { return NO; }
    if (![photo.earthDate isEqualToDate:self.earthDate]) { return NO; }
    return YES;
}

@end

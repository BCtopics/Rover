//
//  DMNPhoto.h
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMNPhoto : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSInteger *photoID;
@property (nonatomic, readonly) NSInteger *solDate;
@property (nonatomic, strong, readonly) NSString *cameraName;
@property (nonatomic, strong, readonly) NSDate *earthDate;

@property (nonatomic, strong, readonly) NSURL *photoURL;


@end

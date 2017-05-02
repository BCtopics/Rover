//
//  DMNSolDescription.h
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMNSolDescription : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic, readonly) NSInteger sol;
@property (nonatomic, readonly) NSInteger numberOfPhotosTaken;
@property (nonatomic, strong, readonly) NSArray *cameras;


@end

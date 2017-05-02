//
//  DMNMarsRoverClient.h
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMNRover.h"
#import "DMNPhoto.h"
#import "DMNSolDescription.h"

@interface DMNMarsRoverClient : NSObject

- (void)fetchAllMarsRoversWithCompletion:(void(^)(NSArray *roverNames, NSError *error))completion;

- (void)fetchMissionManifestForRoverNamed:(NSString *)name completion:(void(^)(DMNRover *rover, NSError *error))completion;

- (void)fetchPhotosFromRover:(DMNRover *)rover onSol:(NSInteger)sol completion:(void(^)(NSArray *photos, NSError *error))completion;

- (void)fetchPhotoDataForPhoto:(DMNPhoto *)photo completion:(void(^)(NSData *photoData, NSError *error))completion;

@end

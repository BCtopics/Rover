//
//  DMNMarsRoverClient.m
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "DMNMarsRoverClient.h"


@implementation DMNMarsRoverClient

+ (NSString *)apiKey {
    static NSString *apiKey = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *apiKeysURL = [[NSBundle mainBundle] URLForResource:@"APIKeys" withExtension:@"plist"];
        if (!apiKeysURL) {
            NSLog(@"Error! APIKeys file not found!");
            return;
        }
        NSDictionary *apiKeys = [[NSDictionary alloc] initWithContentsOfURL:apiKeysURL];
        apiKey = apiKeys[@"APIKey"];
    });
    return apiKey;
}

+ (NSURL *)baseURL
{
    //This may or may not be the right url...
    return [NSURL URLWithString:@"https://api.nasa.gov/mars-photos/api/v1"];
}

+ (NSURL *)URLForInfoForRover:(NSString *)roverName

{
    NSURL *url = [self baseURL];
    url = [url URLByAppendingPathComponent:@"manifests"];
    url = [url URLByAppendingPathComponent:roverName];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
    return urlComponents.URL;
}

+ (NSURL *)urlForPhotosFromRover:(NSString *)roverName onSol:(NSInteger)sol
{
    NSURL *url = [self baseURL];
    url = [url URLByAppendingPathComponent:@"rovers"];
    url = [url URLByAppendingPathComponent:roverName];
    url = [url URLByAppendingPathComponent:@"photos"];
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"sol" value:[@(sol) stringValue]],
                                 [NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
    return urlComponents.URL;
}


-()

@end

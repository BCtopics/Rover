//
//  DMNMarsRoverClient.m
//  Rover
//
//  Created by Bradley GIlmore on 5/2/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

#import "DMNMarsRoverClient.h"
#import "DMNRover.h"
#import "DMNPhoto.h"


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

+ (NSURL *)roversEndpoint
{
    NSURL *url = [[self baseURL] URLByAppendingPathComponent:@"rovers"];
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:YES];
    urlComponents.queryItems = @[[NSURLQueryItem queryItemWithName:@"api_key" value:[self apiKey]]];
    return urlComponents.URL;
}



-(void)fetchAllMarsRoversWithCompletion:(void (^)(NSArray *roverNames, NSError *error))completion
{

    NSURL *url = [[self class] roversEndpoint];
    //^^ Here we get the the url from the roversEndPoint.
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        if (error) {
            return completion(nil, error);
        }//^^ Here we are checking if there are any errors. If there are we will return through the completion that error.
        
        
        
        if (!data) {
            return completion(nil, [NSError errorWithDomain:@"Invalid Domain" code:-1 userInfo:nil]);
        }//^^ Here is where we make sure there is data. If there is not data it will return an error saying Invalid Domain.
        
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //^^ We are now trying to serialize the data to JSON format.
        
        NSArray *roverDicts = nil;
        if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]] ||
            !(roverDicts = jsonDict[@"rovers"])) {
            //^^ This checks to make sure that the the dictionary created from the jsonDict up there is an actualy dictionary.
            
            
            NSDictionary *userInfo = nil;
            
            if (error) { userInfo = @{NSUnderlyingErrorKey : error}; }
            
            NSError *localError = [NSError errorWithDomain:@"Invalid Domain" code:-1 userInfo:userInfo];
            
            return completion(nil, localError);
            
            //^^ all the stuff above this just makes sure that there are no errors, if there are it will pass them up through the completion.
        }
        
        NSMutableArray *roverNames = [NSMutableArray array];
        //^^ This creates a mutableArray called rover names. this is where we will put the names of the rovers we get back.
        for (NSDictionary *dict in roverDicts) {
            NSString *name = dict[@"name"];
            if (name) { [roverNames addObject:name]; }
        }
        //^^ This inititializes the rovers names into the roverNames array.
        
        completion(roverNames, nil);
    }] resume];
}



-(void)fetchPhotoDataForPhoto:(DMNPhoto *)photo completion:(void (^)(NSData *, NSError *))completion
{
    
}



-(void)fetchPhotosFromRover:(DMNRover *)rover onSol:(NSInteger)sol completion:(void (^)(NSArray *, NSError *))completion
{
    
}



-(void)fetchMissionManifestForRoverNamed:(NSString *)name completion:(void (^)(DMNRover *, NSError *))completion
{
    NSURL *url = [[self class] URLForInfoForRover:name];
    //^^ This will get our baseurl based off of the name we passed in.
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        if (error) {
            return completion(nil, error);
        } //^^ Checks for errors, if there is an error it will return that error.
        
        if (!data) {
            return completion(nil, [NSError errorWithDomain:@"Invalid Domain" code:-1 userInfo:nil]);
            //^^ Checks to make sure that data is there. If there is no data given back it will send an NSError back saying Invalid Domain.
        }
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        //^^ This serializes the data Into JSON.
        
        
        NSDictionary *manifest = nil;
        //^^ Creates an empty dictionary.
        
        if (!jsonDict || ![jsonDict isKindOfClass:[NSDictionary class]] ||
            
            !(manifest = jsonDict[@"photo_manifest"])) {
            //^^ This is assigning manifest to be equal to jsonDict[@"photo_manifest"]
            
            NSDictionary *userInfo = nil;
            
            if (error) { userInfo = @{NSUnderlyingErrorKey : error}; }
            
            NSError *localError = [NSError errorWithDomain:@"Invalid Domain" code:-1 userInfo:userInfo];
            
            return completion(nil, localError);
            
            //^^ This part creates localErrors and sends it back up through the completion if the data was not correct.
        }
        
        completion([[DMNRover alloc] initWithDictionary:manifest], nil);
        //^^ This is initializing a DMNRover with the manifest dictionary.
    }] resume];
}

@end












































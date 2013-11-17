//
//  CampusAPI.m
//  Campus
//
//  Created by admin on 17.11.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import "CampusAPI.h"

@implementation CampusAPI
/**
 * Returns user session id after successful authentication or nil if  authentication is failed.
 */
+(NSString*) getAuth:(NSString*)login withPassword:(NSString*)password {
    NSString * result = [CampusAPI getDataFrom:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/User/Auth?login=%@&password=%@", login, password]];
    NSLog(@"Result %@", result);
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSArray *ar =[CampusAPI fetchedData:dataResult withKey:@"Data"];
        return ar;
    } else {
        return result;
    }
}

/**
 * Returns user session id after successful authentication or nil if  authentication is failed.
 */
+(NSArray*) getPermissions:(NSString*)sessionID {
    NSString * result = [CampusAPI getDataFrom:[NSString stringWithFormat:@"http://api.ecampus.kpi.ua/User/GetPermissions?sessionId=%@&", sessionID]];
    NSLog(@"Result %@", result);
    if (result != nil) {
        NSData *dataResult = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableArray *subsystems = [CampusAPI fetchedSubsystemData:dataResult];
        return subsystems;
    } else {
        return nil;
    }
}


/**
 * Get data from url by GET request
 */
+ (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}


/**
 * Parse JSON by key
 */
+ (NSArray*)fetchedData:(NSData *)responseData withKey:(NSString*)key {
    //parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: responseData
                          
                          options:kNilOptions
                          error:&error];
    
    NSArray* latestKeys = [json objectForKey:key];
    
    NSLog(@"%@: %@",key, latestKeys);
    return latestKeys;
}

/**
 * Parse JSON for subsystems
 */
+ (NSArray*)fetchedSubsystemData:(NSData *)responseData {
    //parse out the json data
    NSMutableArray *subsystem = [[NSMutableArray alloc] init];
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData: responseData
                          
                          options:kNilOptions
                          error:&error];
    NSArray* data     = [json objectForKey:@"Data"];
    for (NSDictionary *s in data) {
        SubsystemProfile *sp = [[SubsystemProfile alloc] init];
        [sp setSubsystemName:  s[@"SubsystemName"]];
        [sp setIsCreate:       [s[@"IsCreate"] boolValue]];
        [sp setIsDelete:       [s[@"IsDelete"] boolValue]];
        [sp setIsRead:         [s[@"IsRead"] boolValue]];
        [sp setIsUpdate:       [s[@"IsUpdate"] boolValue]];
        [subsystem addObject:sp];
    }
    
  //  NSLog(@"%@: %@",key, latestKeys);
    return subsystem;
}
@end

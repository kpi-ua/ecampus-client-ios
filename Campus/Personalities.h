//
//  Personalities.h
//  Campus
//
//  Created by admin on 01.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Personalities : NSObject {
    int        subdivisionID;
    NSString   *subdivisionName;
    NSString   *studyGroupName;
    BOOL       isContract;
    NSString   *specialty;
}
@property (nonatomic)           int subdivisionID;
@property (nonatomic, retain)   NSString *subdivisionName;
@property (nonatomic, retain)   NSString *studyGroupName;
@property (nonatomic)           BOOL isContract;
@property (nonatomic, retain)   NSString *specialty;
@end

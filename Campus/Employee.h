//
//  Employee.h
//  Campus
//
//  Created by admin on 01.12.13.
//  Copyright (c) 2013 КБ ИС. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject {
    int        subdivisionID;
    NSString   *subdivisionName;
    NSString   *position;
    NSString   *academicDegree;
    NSString   *academicStatus;
}
@property (nonatomic)           int subdivisionID;
@property (nonatomic, retain)   NSString *subdivisionName;
@property (nonatomic, retain)   NSString *studyGroupName;
@property (nonatomic, retain)   NSString *position;
@property (nonatomic, retain)   NSString *academicDegree;
@property (nonatomic, retain)   NSString *academicStatus;

@end

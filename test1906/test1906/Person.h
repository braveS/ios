//
//  Person.h
//  test1906
//
//  Created by mobindus on 6/19/13.
//  Copyright (c) 2013 mobindustry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * firstname;
@property (nonatomic, retain) NSString * lastname;

@end

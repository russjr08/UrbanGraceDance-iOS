//
//  User.m
//  Urban Grace Dance
//
//  Created by Russell Richardson on 5/31/15.
//  Copyright (c) 2015 Russell Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@implementation User

-(instancetype) initWithJson:(NSDictionary *)data {
    self = [super init];
    
    self._id = data[@"_id"];
    self.username = data[@"username"];
    self.first_name = data[@"first_name"];
    self.last_name = data[@"last_name"];
    self.phone_number = data[@"phone_number"];
    self.email_address = data[@"email_address"];
    self.notification = data[@"notification"];
    self.isAdmin = data[@"isAdmin"];
    
    // TODO: Payment and Student data
    
    return self;
}

@end
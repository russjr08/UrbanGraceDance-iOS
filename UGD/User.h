//
//  User.h
//  Urban Grace Dance
//
//  Created by Russell Richardson on 5/31/15.
//  Copyright (c) 2015 Russell Richardson. All rights reserved.
//

#ifndef Urban_Grace_Dance_User_h
#define Urban_Grace_Dance_User_h

@interface User : NSObject

@property NSString *_id;
@property NSString *username;
@property NSString *first_name;
@property NSString *last_name;
@property NSString *phone_number;
@property NSString *email_address;
@property BOOL isAdmin;
@property BOOL notification;

-(instancetype) initWithJson: (NSDictionary *) data;

@end

#endif

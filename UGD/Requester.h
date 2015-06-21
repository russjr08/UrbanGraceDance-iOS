//
//  Requester.h
//  Urban Grace Dance
//
//  Created by Russell Richardson on 5/31/15.
//  Copyright (c) 2015 Russell Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface Requester : NSObject
@property NSString *token;
@property bool loggedIn;

-(void) login:(NSString *)username withPassword:(NSString *) password withCompletion: (void (^)(bool))callback;

-(bool) isLoggedIn;

-(User *) getLoggedInUser;

+(Requester *) getInstance;


@end

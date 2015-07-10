//
//  Requester.m
//  Urban Grace Dance
//
//  Created by Russell Richardson on 5/31/15.
//  Copyright (c) 2015 Russell Richardson. All rights reserved.
//

#import "Requester.h"

@interface Requester()
-(NSString *) getEndpoint: (NSString *)endpoint;
@end

@implementation Requester

NSString *DEFAULT_ENDPOINT = @"http://192.168.1.99:3000/api/v1/";

static Requester *instance = nil;

@synthesize token;
@synthesize loggedIn;

-(instancetype) init {
    
    self = [super init];
    instance = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults stringForKey: @"auth-token"] != NULL) {
        self.loggedIn = YES;
        self.token = [defaults stringForKey:@"auth-token"];
        
        NSLog(@"We are logged in!");
        
    } else {
        self.loggedIn = NO;
        NSLog(@"We are NOT logged in... :(");
    }
    
    return self;
}

-(NSString *) getEndpoint: (NSString *)endpoint {
    return [NSString stringWithFormat:@"%@%@/", DEFAULT_ENDPOINT, endpoint];
}


-(bool) isLoggedIn {
    return loggedIn;
}

-(User *) getLoggedInUser {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[self getEndpoint:@"me"]]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    [request addValue:token forHTTPHeaderField:@"x-access-token"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    
    
    NSError *parsingError;
    
    NSDictionary *serializedResults = [NSJSONSerialization JSONObjectWithData:response options:0 error:&parsingError];
    User *user = [[User alloc] initWithJson:serializedResults];

    return user;
}

+(Requester *) getInstance {
    return instance;
}

@end

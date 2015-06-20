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

-(void) login:(NSString *)username withPassword:(NSString *)password {
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL *url = [NSURL URLWithString:[self getEndpoint: @"login"]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString * params = [NSString stringWithFormat:@"username=%@&password=%@", username, password];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               
                                                                NSError *parsingError;
                                                               
                                                                NSDictionary *serializedResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parsingError];
                                                                   
                                                                self.token = serializedResults[@"token"];
                                                               
                                                               
                                                               // TODO: Persist token to disk for later.
                                                               
                                                               NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                               NSLog(@"Data = %@",text);
                                                               NSLog(@"Token = %@", self.token);
                                                               
                                                               NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                               [defaults setObject: self.token forKey: @"auth-token"];
                                                               [defaults synchronize];
                                                               NSLog(@"Saved token to disk.");
                                                           }
                                                           
                                                       }];
    
    [dataTask resume]; // Not really resume... but 'start'
    
//    NSURL *url = [NSURL URLWithString: [self getEndpoint:@"login"]];
//    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    

}

-(bool) isLoggedIn {
    return loggedIn;
}

-(User *) getLoggedInUser {
    User *user = [[User alloc] init];
    
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
    
    return user;
}

+(Requester *) getInstance {
    return instance;
}

@end

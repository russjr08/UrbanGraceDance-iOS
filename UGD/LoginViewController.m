//
//  LoginViewController.m
//  UGD
//
//  Created by Russell Richardson on 6/20/15.
//  Copyright © 2015 Urban Grace Dance. All rights reserved.
//

#import "LoginViewController.h"
#import "Requester.h"

@interface LoginViewController ()


@end

@implementation LoginViewController {
    Requester *requester;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    requester = [[Requester alloc] init];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if([requester isLoggedIn]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyboard instantiateInitialViewController];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnClicked:(id)sender {
    
    NSString *stringURL = @"http://192.168.1.99:3000/auth/authorize";
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

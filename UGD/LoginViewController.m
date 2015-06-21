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

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation LoginViewController {
    Requester *requester;
}

@synthesize usernameField, passwordField;
@synthesize label;



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


- (IBAction)loginBtnClick:(id)sender {
    
    [requester login: usernameField.text withPassword: passwordField.text withCompletion:^(bool loggedIn) {
        if (loggedIn) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vc = [storyboard instantiateInitialViewController];
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            [self animateLoginLabel];
        }
    }];   

}

-(void) animateLoginLabel {
    
    [label setHidden: NO];
    
    // Save the original configuration.
    CGRect initialFrame = label.frame;
    
    // Displace the label so it's hidden outside of the screen before animation starts.
    CGRect displacedFrame = initialFrame;
    displacedFrame.origin.y = -100;
    label.frame = displacedFrame;
    
    // Restore label's initial position during animation.
    [UIView animateWithDuration:.6 animations:^{
        label.frame = initialFrame;
    }];
    
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

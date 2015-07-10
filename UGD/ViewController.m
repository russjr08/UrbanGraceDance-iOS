//
//  ViewController.m
//  UGD
//
//  Created by Russell Richardson on 6/20/15.
//  Copyright © 2015 Urban Grace Dance. All rights reserved.
//

#import "ViewController.h"
#import "Requester.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", [[Requester getInstance] getLoggedInUser]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

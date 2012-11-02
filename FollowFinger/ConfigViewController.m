//
//  ConfigViewController.m
//  FollowFinger
//
//  Created by Yang Peng on 11/2/12.
//  Copyright (c) 2012 yp. All rights reserved.
//

#import "ConfigViewController.h"

@interface ConfigViewController ()

- (void)setTitleLabel;

@end

@implementation ConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor redColor];
    [self setTitleLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitleLabel
{
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    title.center = self.view.center;
    title.text = @"config view";
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
}

@end

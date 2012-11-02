//
//  ViewController.m
//  FollowFinger
//
//  Created by Yang Peng on 11/2/12.
//  Copyright (c) 2012 yp. All rights reserved.
//

#import "ViewController.h"
#import "ConfigViewController.h"
#import "ContentViewController.h"

@interface ViewController ()

- (void)setbgcolor;
- (void)setbutton;
- (void)showContenView;

@end

@implementation ViewController

@synthesize finger = _finger;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [self setbgcolor];
    [self setbutton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setbgcolor
{
    static int index = 0;
    NSArray *uicolorarray = [NSArray arrayWithObjects: [UIColor orangeColor],
            [UIColor purpleColor],
            [UIColor brownColor],
            [UIColor grayColor],
            [UIColor redColor],
            [UIColor greenColor],
            [UIColor blueColor],
            [UIColor cyanColor],
            [UIColor yellowColor],
            nil];

    self.view.backgroundColor = uicolorarray[index++];
    index %= uicolorarray.count;
}


- (void)setbutton
{
    UIButton *contentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [contentButton setTitle:@"show content view" forState:UIControlStateNormal];
    contentButton.frame = CGRectMake(0, 0, 200, 40);
    contentButton.center = self.view.center;
    [contentButton addTarget:self action:@selector(showContenView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:contentButton];
}

- (void)showContenView
{
    NSLog(@"show button pressed");
    ContentViewController *contentViewController = [[ContentViewController alloc] init];
    [self.finger pushViewController:contentViewController];
}


- (UIViewController *)viewControllerToPush {
    //UIViewController *viewController = [[ViewController alloc] init];
    UIViewController *viewController = [[ConfigViewController alloc] init];
    return viewController;
}

@end

//
//  ViewController.m
//  UITest2
//
//  Created by oda on 2013/06/19.
//  Copyright (c) 2013年 seventhcode. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(double)random
{
    return (arc4random() % 100 ) / 100.0f;
}

-(UIColor *)randon_color
{
    return [UIColor colorWithRed:[self random] green:[self random] blue:[self random] alpha:[self random]];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray * views = [[NSMutableArray alloc] init];
    for (int index = 0 ;index < 100 ;index++)
    {
        UIView * view = [[UIView alloc] init];
        [view setBackgroundColor:[self randon_color]];
        [views addObject:view];
    }
    
    [pages setViews:views];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)virtical:(UIButton*)sender
{
    [pages setIsVirtical:YES];
}

-(IBAction)horizontal:(UIButton*)sender
{
    [pages setIsVirtical:NO];
}

-(IBAction)clip:(UISwitch*)sender
{
    [pages setClipsToBounds:sender.isOn];
}

@end

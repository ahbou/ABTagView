//
//  TVViewController.m
//  ABTagView
//
//  Created by Ahmed Bouchfaa on 26/03/2014.
//  Copyright (c) 2014 FIRST SHOT. All rights reserved.
//

#import "TVViewController.h"
#import "ABTagView.h"

@interface TVViewController () <ABTagViewDelegate>

@property (weak) IBOutlet ABTagView *tagView;

@end

@implementation TVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

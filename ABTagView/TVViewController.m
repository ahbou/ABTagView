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
{
    NSMutableArray *viewTags;
}



#pragma mark - SMTagField delegate
-(void)tagField:(ABTagView *)_tagField tagAdded:(NSString *)tag
{
     NSLog(@"added tag %@", tag);
}

-(void)tagField:(ABTagView *)_tagField tagRemoved:(NSString *)tag
{

    NSLog(@"removed tag %@", tag);

}

-(void)tagField:(ABTagView *)tagField tagTapped:(int)tagIndex
{
    
}

-(BOOL)tagField:(ABTagView *)_tagField shouldAddTag:(NSString *)tag
{
    // Limits to a maximum of 5 tags
    if(_tagField.tags.count >= 5)        return NO;
    
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];


    self.tagView.tagDelegate = self;

    self.tagView.tagBorderColor =   [UIColor colorWithRed:0/255.0 green:174/255.0 blue:239 /255.0 alpha:1.00];
    self.tagView.tagBackground =    [UIColor clearColor];
    self.tagView.tagTextColor =     [UIColor blackColor];
    self.tagView.placeholder = @"Type in your tags";

    viewTags = [@[@"one", @"two", @"three"] mutableCopy];
    self.tagView.tags = viewTags;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end

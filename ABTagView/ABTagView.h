//
//  ABTextView.h
//  ABTagView
//
//  Created by Ahmed Bouchfaa on 26/03/2014.
//  Copyright (c) 2014 FIRST SHOT. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABTagViewDelegate.h"
#import "ABTag.h"

@interface ABTagView : UITextField

//set tags array
@property (nonatomic, strong) NSMutableArray *tags;
//set font
@property (nonatomic, weak) UIFont  *selectedFont;
@property (nonatomic, weak) UIColor *tagBackground;
@property (nonatomic, weak) UIColor *tagBorderColor;
@property (nonatomic, weak) UIColor *tagTextColor;
//ABTagView delegate
@property (unsafe_unretained) id<ABTagViewDelegate> tagDelegate;

@end

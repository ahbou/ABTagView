//
//  ABTag.h
//  ABTagView
//
//  Created by Ahmed Bouchfaa on 26/03/2014.
//  Copyright (c) 2014 FIRST SHOT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ABTag : UIButton

-(id)initWithTag: (NSString *) tag andIndex:(NSInteger)index;

//Tag title
@property (nonatomic, strong) NSString  *value;
@property (nonatomic, strong) UIColor   *borderColor;
@property (nonatomic, strong) UIColor   *bgColor;
@property (nonatomic, strong) UIFont    *font;
@property (nonatomic, strong) UIColor   *textColor;

@end

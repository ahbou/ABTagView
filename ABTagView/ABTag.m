//
//  ABTag.m
//  ABTagView
//
//  Created by Ahmed Bouchfaa on 26/03/2014.
//  Copyright (c) 2014 FIRST SHOT. All rights reserved.
//

#import "ABTag.h"

@implementation ABTag
@synthesize value;
@dynamic borderColor, font, textColor, bgColor;

-(id)initWithTag:(NSString *)tag andIndex:(NSInteger)index{
    if(self = [super init]){
        self.backgroundColor    = [UIColor clearColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds= YES;
        self.layer.borderColor  = [UIColor colorWithRed:0/255.0 green:174/255.0 blue:239 /255.0 alpha:1.00].CGColor;
        self.layer.borderWidth  = 1.75;
        self.showsTouchWhenHighlighted = YES;

        value                   = tag;

        [self setTitle:[NSString stringWithFormat:@"%@", tag] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [self sizeToFit];

        CGRect selfFrame        = self.frame;
        selfFrame.size.height   = 26;
        self.frame              = selfFrame;
        self.tag = index;

        [self setUserInteractionEnabled:YES];

    }

    return self;
}

#pragma mark - Setters

-(void)setValue:(NSString *)aValue{
    [self setTitle:[NSString stringWithFormat:@" %@ ", aValue] forState:UIControlStateNormal];
    self.value                  = aValue;
    [self sizeToFit];
}

-(UIColor *)borderColor{
    return [UIColor colorWithCGColor: self.layer.borderColor];
}

-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor      = borderColor.CGColor;
}

-(UIFont *)font{
    return self.titleLabel.font;
}

-(void)setFont:(UIFont *)font{
    self.titleLabel.font    = font;
}

-(UIColor *)textColor{
    return [self titleColorForState: UIControlStateNormal];
}

-(void)setTextColor:(UIColor *)textColor{
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

@end

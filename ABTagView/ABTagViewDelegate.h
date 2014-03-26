//
//  ABTagViewDelegate.h
//  ABTagView
//
//  Created by Ahmed Bouchfaa on 26/03/2014.
//  Copyright (c) 2014 FIRST SHOT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ABTagView;
@protocol ABTagViewDelegate <NSObject>

@optional

//Called by delegate when a tag is added
-(void) tagField: (ABTagView *) tagField tagAdded: (NSString *) tag;

//Called by delegate when a tag is removed
-(void) tagField: (ABTagView *) tagField tagRemoved: (NSString *) tag;

//Called by delegate when a change happens typically added/removed
-(void) tagField: (ABTagView *) tagField tagsChanged: (NSArray *) tags;

// Whether a tag should be added. Defaults to YES
-(BOOL) tagField: (ABTagView *) tagField shouldAddTag: (NSString *) tag;

//Called by delegate when a tag is tapped
-(void) tagField: (ABTagView *) tagField tagTapped: (int) tagIndex;

@end
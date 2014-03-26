//
//  ABTextView.m
//  ABTagView
//
//  Created by Ahmed Bouchfaa on 26/03/2014.
//  Copyright (c) 2014 FIRST SHOT. All rights reserved.
//

#import "ABTagView.h"
#define DEFAULT_FONT [UIFont fontWithName:@"Helvetica-Neue" size:13.0f]

@interface ABTagView ()
@property (nonatomic, strong) UIView *tagsView;

-(void) tagsLayout;
-(void) setupUI;

@end

@implementation ABTagView
@synthesize tags;
@synthesize tagDelegate;


#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)]) {
        [self setupUI];
    }

    return self;
}


-(void)setFrame:(CGRect)frame{
    super.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
}

#pragma mark - UITextfield functions

- (CGRect) textRectForBounds: (CGRect) bounds
{
    CGRect origValue = [super textRectForBounds: bounds];

    return CGRectOffset(origValue, 0.0f, 0.0f);
}

- (CGRect) editingRectForBounds: (CGRect) bounds
{
    CGRect origValue = [super textRectForBounds: bounds];

    return CGRectOffset(origValue, 0.0f, 0.0f);
}

- (void)textFieldDidChange:(NSNotification*)aNotification
{
    if(self.text.length == 0) return;

    unichar lastChar    = [self.text characterAtIndex: self.text.length - 1];

    if(lastChar == ' ' || lastChar == ','){
        NSString *txtTag= [self.text substringToIndex: self.text.length - 1];
        if(txtTag.length == 0){
            self.text   = @"";
            return;
        }

        if([tags indexOfObject: txtTag] == NSNotFound){
            // Add tags
            BOOL shouldAddtag = (![tagDelegate respondsToSelector: @selector(tagField:shouldAddTag:)])?YES:[tagDelegate tagField:self shouldAddTag:txtTag];

            if (shouldAddtag){
                NSMutableArray *muteTags = [tags mutableCopy];
                //Uppercase
                NSString *value = [NSString stringWithFormat:@"%@%@", [[txtTag substringToIndex:1] uppercaseString], [txtTag substringFromIndex:1]];

                [muteTags addObject: value];
                tags = muteTags;

                if([tagDelegate respondsToSelector: @selector(tagField:tagAdded:)]){
                    [tagDelegate tagField:self tagAdded:txtTag];
                }

                [self tagsLayout];
            }
        }

        self.text       = @"";
    }
}

- (void)textFieldDidEndEditing:(NSNotification*)aNotification{
    if(self.text.length > 0)
        self.text = [self.text stringByAppendingString:@" "];

    [self textFieldDidChange: aNotification];
}


#pragma mark - Setters
-(void)deleteBackward{
    if(tags.count > 0 && self.text.length == 0){
        if([tagDelegate respondsToSelector:@selector(tagField:tagRemoved:)]){
            NSString *lastTag = [tags lastObject];
            [tagDelegate tagField:self tagRemoved: lastTag];
        }

        NSMutableArray *muteTags = [tags mutableCopy];
        [muteTags removeLastObject];
        tags = muteTags;

        [self tagsLayout];
    }

    [super deleteBackward];
}

-(void)setTags:(NSMutableArray *)aTags{
    tags = aTags;
    [self tagsLayout];
}

#pragma mark - Methods

-(void)setupUI{
    self.backgroundColor        = self.backgroundColor;
    self.opaque                 = NO;
    self.autocorrectionType     = UITextAutocorrectionTypeNo;
    self.borderStyle            = UITextBorderStyleNone;

    tags                        = [@[] mutableCopy];

    _tagsView                    = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    _tagsView.backgroundColor    = [UIColor clearColor];
    _tagsView.userInteractionEnabled = YES;

    self.leftView               = _tagsView;
    self.leftViewMode           = UITextFieldViewModeAlways;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:@"UITextFieldTextDidChangeNotification"
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidEndEditing:)
                                                 name:@"UITextFieldTextDidEndEditingNotification"
                                               object:nil];

}

-(void)tagsLayout{
    [_tagsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    CGRect tagsFrame        = _tagsView.frame;
    tagsFrame.size          = CGSizeMake(0, self.frame.size.height);
    _tagsView.frame          = tagsFrame;

    int i =0;
    for(NSString *txtTag in tags){
        ABTag *tag              = [[ABTag alloc] initWithTag: txtTag andIndex:i];
        tag.enabled =YES;
        tag.userInteractionEnabled = YES;

        if (self.selectedFont) {
            tag.font = self.selectedFont;
        } else {
            tag.font = DEFAULT_FONT;
        }

        //tap to remove
        [tag addTarget:self action:@selector(tagTapped:) forControlEvents:UIControlEventTouchUpInside];

        CGRect tagFrame         = tag.frame;
        tagFrame.origin.x       = _tagsView.frame.size.width;
        tagFrame.origin.y       = ((self.frame.size.height - tag.frame.size.height) / 2) + 6;
        tag.frame               = tagFrame;

        tagsFrame               = _tagsView.frame;
        tagsFrame.size.width   += (tag.frame.size.width + 5);
        _tagsView.frame          = tagsFrame;

        [_tagsView addSubview: tag];
        i++;
    }

    // If there's not enough room, free up first tags and reposition next ones
    CGFloat missingWidth= (_tagsView.frame.size.width - self.frame.size.width + 40);

    if(missingWidth > 0){
        // Remove old tags
        for(ABTag *tag in _tagsView.subviews){
            if(missingWidth < 0)
                break;

            missingWidth -= tag.frame.size.width;

            [tag removeFromSuperview];
        }

        tagsFrame                   = _tagsView.frame;
        tagsFrame.size.width        = 0;
        _tagsView.frame              = tagsFrame;

        // Reposition
        for(ABTag *tag in _tagsView.subviews){
            CGRect tagFrame         = tag.frame;
            tagFrame.origin.x       = _tagsView.frame.size.width + 5;

            float yPos = (self.frame.size.height - tag.frame.size.height) / 2;
            tagFrame.origin.y       = yPos;
            tag.frame               = tagFrame;

            tagsFrame               = _tagsView.frame;
            tagsFrame.size.width   += (tag.frame.size.width + 5);
            _tagsView.frame          = tagsFrame;

            //tap to remove
            [tag addTarget:self action:@selector(tagTapped:) forControlEvents:UIControlEventTouchUpInside];

            [_tagsView addSubview: tag];
        }
    }

    if([tagDelegate respondsToSelector:@selector(tagField:tagsChanged:)])
        [tagDelegate tagField: self tagsChanged: tags];
}

-(void)tagTapped:(id)sender
{
    if(tags.count > 0 && self.text.length == 0){
        if([tagDelegate respondsToSelector:@selector(tagField:tagRemoved:)]){
            NSString *tappedTag = tags[[sender tag]];
            [tagDelegate tagField:self tagRemoved: tappedTag];
            [self.tags removeObjectAtIndex:[sender tag]];
        }
        
        [self tagsLayout];
    }
    
}

#pragma mark - Helpers

-(void)awakeFromNib{
    [self setupUI];
    [super awakeFromNib];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidEndEditingNotification" object:nil];
}


@end

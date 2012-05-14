//
//  FilteringView.m
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FilteringView.h"

@implementation FilteringView
@synthesize tagToggleButtons;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
}


- (void)loadView
{
    // set background color
    [self setBackgroundColor: [UIColor colorWithRed:247.0f/255.0f green:246.0f/255.0f blue:250.0f/255.0f alpha:1.0]];
    [self loadContent];
}


-(void) loadContent
{    
    // iterate over sounds
    for (int i = 0; i < 10; i++) 
    {
        NSString* title = @"test";
        
        CGSize textSize = [title sizeWithFont:[UIFont fontWithName:@"DroidSans" size:10.0]];     
        CGRect frame = CGRectMake(i + textSize.width + 5, i + 10, textSize.width + 10, textSize.height + 10);
        
        // create tag button object
        TagToggleButton* tagButton = [[TagToggleButton alloc] initWithTitle:title frame:frame];
        [self addSubview: tagButton];        
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

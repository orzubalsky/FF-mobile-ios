//
//  FilteringView.m
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FilteringView.h"

@implementation FilteringView
@synthesize tagToggleButtons, containerView;

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
    
    // init scroll view and confifure it    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    containerView = [[UIScrollView alloc] initWithFrame:frame];    
    containerView.pagingEnabled = NO;    
    containerView.showsHorizontalScrollIndicator = NO;
    containerView.showsVerticalScrollIndicator = YES;        
    // set a temporary content size (this will be changed dynamically when the sounds are loaded)
    [containerView setContentSize:CGSizeMake(320, 580)];   
    
    [self addSubview:containerView];
}


-(void) loadContent:(NSArray*) tags
{    
    float xCursor = 10.0;
    float line = 0.0;     
    bool newLine = NO;
    
    tagToggleButtons = [[NSMutableArray alloc] init];
    
    // iterate over sounds
    for (int i = 0; i < [tags count]; i++) 
    {
        Tag* tag = [tags objectAtIndex:i];
        
        CGSize textSize = [tag.title sizeWithFont:[UIFont fontWithName:@"DroidSans" size:20.0]];     
        CGRect frame = CGRectMake(xCursor, line * 40.0, textSize.width + 10, textSize.height + 10);
        
        xCursor += textSize.width + 16.0;
        newLine = NO;
        
        if (xCursor >= (290 - textSize.width)) 
        {
            line++;
            xCursor = 10.0;
            newLine = YES;
        }        
        
        // create tag button object
        TagToggleButton* tagButton = [[TagToggleButton alloc] initWithTag:tag frame:frame];
        
        [tagToggleButtons addObject:tagButton];        
        [containerView addSubview: tagButton];        
    }
    
    // resize scroll content size to fit all tags
    [containerView setContentSize:CGSizeMake(320, (line+1)*45.0)];       
}

-(NSMutableArray*) gatherFilterTags 
{
    NSMutableArray* filterTags = [[NSMutableArray alloc] initWithObjects: nil];    
    NSLog(@"filter tags array init");
    NSLog(@"buttons: %i", [self.tagToggleButtons count]);
    
    
    for (int i = 0; i < [self.tagToggleButtons count]; i++) 
    {
        TagToggleButton* button = [tagToggleButtons objectAtIndex:i];
                
        if (button.state == UIControlStateSelected) 
        {
            NSString* tagId = button.tag.pk;
            NSLog(@"selected tag id: %@", tagId);            
            [filterTags addObject:button.tag.pk];
        }
    }
    
    return filterTags;
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

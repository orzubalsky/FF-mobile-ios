//
//  TagToggleButton.m
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TagToggleButton.h"

@implementation TagToggleButton
@synthesize tag;

- (id)initWithTag:(Tag*)inputTag frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {        
        tag = inputTag;
        
        [self setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState: UIControlStateSelected];
        [self setBackgroundColor:[UIColor colorWithRed:73.0f/255.0f green:46.0f/255.0f blue:127.0f/255.0f alpha:0.35]];
        [self addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];

        self.titleLabel.font = [UIFont fontWithName:@"DroidSans" size:20.0];
        
        [self setTitle:tag.title forState:UIControlStateNormal];
        [self setTitle:tag.title forState:UIControlStateSelected];

          }
    return self;
}

-(NSString*)buttonTapped:(UIButton*) sender
{
    [sender setSelected:!sender.selected];
    
    if (sender.selected)
    {
        [self setBackgroundColor:[UIColor colorWithRed:73.0f/255.0f green:46.0f/255.0f blue:127.0f/255.0f alpha:1.0]];    
    }
    else 
    {
        [self setBackgroundColor:[UIColor colorWithRed:73.0f/255.0f green:46.0f/255.0f blue:127.0f/255.0f alpha:0.35]];    
    }
    
    return self.tag.pk;
}


@end

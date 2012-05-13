//
//  SoundView.m
//  fantastic futures
//
//  Created by Or Zubalsky on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoundView.h"

@implementation SoundView
@synthesize titleLabel, lengthLabel, metaLabel, descriptionLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // background and drop shadow
        [self setBackgroundColor: [UIColor whiteColor]];
        self.layer.masksToBounds = NO;
        self.layer.shadowOffset = CGSizeMake(5, 5);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.1;        
        
        // title label
        CGRect titleFrame = CGRectMake(10, 10, 290, 100);
        titleLabel = [[FFLabel alloc] initWithStyle: titleFrame fontName:@"DroidSans-Bold" fontSize:24.0];
        [titleLabel setFont:[UIFont fontWithName:@"DroidSans-Bold" size:24.0]];        
        [titleLabel setTextColor: [UIColor colorWithRed:73.0f/255.0f green:46.0f/255.0f blue:127.0f/255.0f alpha:1.0]];       
        [titleLabel setNumberOfLines:0];
        [self addSubview: titleLabel];    
        
        // length label
        CGRect lengthFrame = CGRectMake(260, 10, 40, 30);
        lengthLabel = [[FFLabel alloc] initWithStyle: lengthFrame fontName:@"DroidSans" fontSize:11.0];   
        [self addSubview: lengthLabel];            
        
        // meta label
        CGRect metaFrame = CGRectMake(10, 110, 260, 30);
        metaLabel = [[FFLabel alloc] initWithStyle: metaFrame fontName:@"DroidSans" fontSize:11.0];    
        [self addSubview: metaLabel];          
        
        // description label
        CGRect descriptionFrame = CGRectMake(10, 120, 290, 170);
        descriptionLabel = [[FFLabel alloc] initWithStyle: descriptionFrame fontName:@"DroidSans" fontSize:11.0];    
        [descriptionLabel setNumberOfLines:0];
        [self addSubview: descriptionLabel];            
        
        // add/remove from composition button
        CGRect addButtonFrame = CGRectMake( 255, 255, 40, 40 );
        UIButton *addButton = [[UIButton alloc] initWithFrame: addButtonFrame];
        UIImage *offStateImagae = [UIImage imageNamed:@"addButtonOff.png"];
        UIImage *onStateImagae  = [UIImage imageNamed:@"addButtonOn.png"];
        [addButton setImage:offStateImagae forState: UIControlStateNormal];
        [addButton setImage:onStateImagae forState: UIControlStateSelected];
        [self addSubview: addButton];    
        [addButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [addButton release];
        [titleLabel release];          
        
    }
    return self;
}

-(void)buttonTapped:(UIButton*) sender
{
    [sender setSelected:!sender.selected];
}

- (void)populateSounds:(Sound*) sound
{
  
    titleLabel.text =[sound.title uppercaseString];
    CGSize titleTextSize = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(titleLabel.frame.size.width, MAXFLOAT) lineBreakMode:titleLabel.lineBreakMode];        
    titleLabel.frame = CGRectMake(10, 10, titleTextSize.width, titleTextSize.height);
    
    lengthLabel.text = sound.formatLength;
    CGSize lengthTextSize = [lengthLabel.text sizeWithFont:lengthLabel.font constrainedToSize:CGSizeMake(lengthLabel.frame.size.width, MAXFLOAT) lineBreakMode:lengthLabel.lineBreakMode];        
    lengthLabel.frame = CGRectMake(260, 10, lengthTextSize.width, lengthTextSize.height);    
    
    metaLabel.text = [NSString stringWithFormat:@"by %@ in %@", sound.author, sound.location];    
    CGSize metaTextSize = [metaLabel.text sizeWithFont:metaLabel.font constrainedToSize:CGSizeMake(metaLabel.frame.size.width, MAXFLOAT) lineBreakMode:metaLabel.lineBreakMode];            
    metaLabel.frame = CGRectMake(10, titleTextSize.height+10, metaTextSize.width, metaTextSize.height);    
    
    descriptionLabel.text = sound.description;
    CGSize descriptionTextSize = [descriptionLabel.text sizeWithFont:descriptionLabel.font constrainedToSize:CGSizeMake(descriptionLabel.frame.size.width, MAXFLOAT) lineBreakMode:descriptionLabel.lineBreakMode];        
    descriptionLabel.frame = CGRectMake(10, 120, 260, descriptionTextSize.height);
    [descriptionLabel alignBottom];
    
    
    
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

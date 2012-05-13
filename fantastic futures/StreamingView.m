//
//  StreamView.m
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StreamingView.h"

@implementation StreamingView

@synthesize scrollView;
@synthesize sounds;
@synthesize responseData, soundViews;

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
    // start loading sounds from the api
    [self loadSounds];
    
    // set background color
    [self setBackgroundColor: [UIColor colorWithRed:247.0f/255.0f green:246.0f/255.0f blue:250.0f/255.0f alpha:1.0]];
    
    // create a frame for the scroll view
    CGRect scrollRect= CGRectMake(0, 85, 320, 320 );
    
    // init scroll view and confifure it
    scrollView=[[UIScrollView alloc] initWithFrame:scrollRect];
    scrollView.pagingEnabled = YES;    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;    
    
    // set a temporary content size (this will be changed dynamically when the sounds are loaded)
    [scrollView setContentSize:CGSizeMake(640, 280)];    
    
    // add scroll view to the parent view
    [self addSubview: scrollView];
    
    // release stuff?
    [scrollView release];    
    [self release];
}


-(void)loadSounds
{
    NSLog(@"called loading sounds method");
	
    self.responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://test.fantasticfutures.fm/api/sounds"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"connection received response");
    
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection error!");
	[connection release];
	self.responseData = nil;
}


#pragma mark -
#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	self.responseData = nil;
    
	NSArray* jsonSounds = [(NSDictionary*)[responseString JSONValue] objectForKey:@"sounds"];
	[responseString release];
    
    // init sounds array in which we'll store the sounds from the api call
    sounds = [[NSMutableArray alloc] initWithObjects: nil];    
    
    [self loadContent:jsonSounds];    
}


-(void) loadContent:(NSArray*) jsonSounds
{
    // init soundViews array in which we'll store the views for each sound
    soundViews = [[NSMutableArray alloc] initWithObjects: nil];
    
    // resize scroll content size to fit all sounds
    [scrollView setContentSize:CGSizeMake(230*[jsonSounds count], 280)];    
    
    // iterate over sounds
    for (int i = 0; i < [jsonSounds count]; i++) 
    {
        // iterable json object from api call
        NSDictionary* jsonSound = [jsonSounds objectAtIndex:i];
        
        // create sound object
        Sound* sound = [[Sound alloc] init];
        
        sound.title         = [jsonSound objectForKey:@"title"];
        sound.length        = [[jsonSound objectForKey:@"length"] intValue];
        sound.author        = [jsonSound objectForKey:@"display_name"];
        sound.location      = [jsonSound objectForKey:@"location"];
        sound.description   = [jsonSound objectForKey:@"story"];  
        
        // add sound object to array
        [sounds addObject:sound];
        
        NSLog(@"%@", [jsonSound objectForKey:@"length"]);
        NSLog(@"processed sound %i: %@", i, sound.title);        
        
        // add soundView to array
        SoundView* soundView = [[SoundView alloc] init];
        [soundViews addObject:soundView];
        
        soundView = [[SoundView alloc] init];
        soundView.frame = CGRectMake(10 + i*320, 10, 300, 300);
        [soundView populateSounds:[sounds objectAtIndex: i]];
        [scrollView addSubview: soundView];        
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

//
//  FirstViewController.m
//  fantastic futures
//
//  Created by OR ZUBALSKY on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize scrollView;
@synthesize sounds;
@synthesize responseData, soundViews;
@synthesize filterView;
@synthesize streamView;



- (void)loadView
{
    // container view
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = containerView;
    [containerView release];    

    // frame for main subviews (stream / filter)
    frame = self.view.bounds;
    
    // declare main subviews
    streamView = [[StreamingView alloc] initWithFrame:frame];
    
    filterView = [[FilteringView alloc] initWithFrame:frame];
    filterView.backgroundColor = [UIColor blueColor];    
    
    displayingStreamView = YES;
    
    // add main subviews
    [containerView addSubview:streamView];
    
    // add/remove from composition button
    CGRect filterButtonFrame = CGRectMake(270, 10, 40, 40 );
    UIButton *filterButton = [[UIButton alloc] initWithFrame: filterButtonFrame];
    UIImage *offStateImagae = [UIImage imageNamed:@"addButtonOff.png"];
    UIImage *onStateImagae  = [UIImage imageNamed:@"addButtonOn.png"];
    [filterButton setImage:offStateImagae forState: UIControlStateNormal];
    [filterButton setImage:onStateImagae forState: UIControlStateSelected];
    [containerView addSubview: filterButton];    
    [filterButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];    
    
    
    // assign view
    self.view = containerView;
}

-(void)buttonTapped:(UIButton*) sender
{
    if(displayingStreamView) {
        [self.streamView removeFromSuperview];
        [self.view addSubview:filterView];
        
        displayingStreamView = NO;
    } else {
        [self.filterView removeFromSuperview];
        [self.view addSubview:streamView];
        
        displayingStreamView = YES;
    }
    //[self.view bringSubviewToFront:self.swapButton];
}

-(void)loadSounds
{
    NSLog(@"called loading sounds method");
	
    self.responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:soundsURL]];
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





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
    [super viewDidLoad];
         
    //[self loadSounds];
    
    
 
}


- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [scrollView release];
    [super dealloc];
}

@end

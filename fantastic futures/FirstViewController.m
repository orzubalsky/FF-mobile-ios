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
@synthesize titleLabel;
@synthesize lengthLabel;
@synthesize metaLabel;
@synthesize descriptionLabel;
@synthesize title;
@synthesize responseData, soundViews;




- (void)loadView
{
    // declate a variable for the view
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        
    // start loading sounds from the api
    [self loadSounds];
    
    // set background color
    [view setBackgroundColor: [UIColor colorWithRed:247.0f/255.0f green:246.0f/255.0f blue:250.0f/255.0f alpha:1.0]];
    
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
    [view addSubview: scrollView];
    
    // assign view
    self.view = view;
    
    // release stuff?
    [scrollView release];    
    [view release];
}


-(void)loadSounds
{
    NSLog(@"called loading sounds method");
	
    self.responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kLatestKivaLoansURL]];
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
    [self setTitle:nil];
    [self setTitleLabel:nil];
    [self setLengthLabel:nil];
    [self setMetaLabel:nil];
    [self setDescriptionLabel:nil];
    [self setTitleLabel:nil];
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
    [title release];
    [titleLabel release];
    [lengthLabel release];
    [metaLabel release];
    [descriptionLabel release];
    [titleLabel release];
    [scrollView release];
    [super dealloc];
}

@end

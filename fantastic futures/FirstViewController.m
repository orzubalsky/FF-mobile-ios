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
@synthesize sounds, tags;
@synthesize responseData, soundViews;
@synthesize filterView;
@synthesize streamView, switchButton;



- (void)loadView
{
    [self loadTags];
    
    // container view
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = containerView;
    [containerView release];    

    // frame for main subviews (stream / filter)
    frame = self.view.bounds;
    
    // declare main subviews
    streamView = [[StreamingView alloc] initWithUrl:@"http://test.fantasticfutures.fm/api/sounds" frame:frame];    
    filterView = [[FilteringView alloc] initWithFrame:frame];
    displayingStreamView = YES;
    
    // add main subview
    [containerView addSubview:streamView];
    
    // switch view button
    CGRect switchButtonFrame = CGRectMake(270, 10, 40, 40 );
    switchButton = [[UIButton alloc] initWithFrame: switchButtonFrame];
    UIImage *offStateImagae = [UIImage imageNamed:@"addButtonOff.png"];
    UIImage *onStateImagae  = [UIImage imageNamed:@"addButtonOn.png"];
    [switchButton setImage:offStateImagae forState: UIControlStateNormal];
    [switchButton setImage:onStateImagae forState: UIControlStateSelected];
    [containerView addSubview: switchButton];    
    [switchButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];    
    
    
    // assign view
    self.view = containerView;
}

-(void)buttonTapped:(UIButton*) sender
{
    NSLog(@"displaying stream view: %d", displayingStreamView);
    
    
    if(displayingStreamView) {
        NSLog(@"loading filter view");
        
        [self.streamView removeFromSuperview];
        [self.filterView loadContent:tags];
        [self.view addSubview:filterView];
        
        displayingStreamView = NO;
    } else {
        NSLog(@"loading stream view");
                
        NSMutableArray* filterTags = [self.filterView gatherFilterTags];
        NSString* tagIds = [filterTags componentsJoinedByString:@","];
        
        NSLog(@"tag string: %@", tagIds);
        
        NSString* apiUrl = [NSString stringWithFormat:@"http://test.fantasticfutures.fm/api/sounds/tags/%@", tagIds];
        
        NSLog(@"url: %@", apiUrl);
        
        
        [self.filterView removeFromSuperview];
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        frame = self.view.bounds;        
        streamView = [[StreamingView alloc] initWithUrl:apiUrl frame:frame];    
        [self.view addSubview:streamView];
        
        displayingStreamView = YES;
        
    }
    [self.view bringSubviewToFront:self.switchButton];
}

-(void)loadTags
{
    NSLog(@"called loading tags method");
	
    self.responseData = [NSMutableData data];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:tagsURL]];
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
    
	NSArray* jsonTags = [(NSDictionary*)[responseString JSONValue] objectForKey:@"tags"];
	[responseString release];

    // init sounds array in which we'll store the sounds from the api call
    tags = [[NSMutableArray alloc] initWithObjects: nil];    
    
    // iterate over sounds
    for (int i = 0; i < [jsonTags count]; i++) 
    {
        // iterable json object from api call
        NSDictionary* jsonTag = [jsonTags objectAtIndex:i];
        
        // create sound object
        Tag* tag = [[Tag alloc] init];

        tag.title           = [jsonTag objectForKey:@"title"];
        tag.pk              = [jsonTag objectForKey:@"id"];
        
        // add sound object to array
        [tags addObject:tag];
        
        NSLog(@"processed tag %i: %@", i, tag.title);        
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

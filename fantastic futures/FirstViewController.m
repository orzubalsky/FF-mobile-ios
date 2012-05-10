//
//  FirstViewController.m
//  fantastic futures
//
//  Created by OR ZUBALSKY on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize sounds;
@synthesize titleLabel;
@synthesize lengthLabel;
@synthesize metaLabel;
@synthesize descriptionLabel;
@synthesize title;
@synthesize responseData;
@synthesize testLabel, soundsLoaded;




- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    soundsLoaded = false;
    
    [self loadSounds];
    
    [view setBackgroundColor: [UIColor yellowColor]];
    
    CGRect labelFrame = CGRectMake( 10, 40, 100, 30 );
    testLabel = [[UILabel alloc] initWithFrame: labelFrame];
    [testLabel setText: @"My Label"];
    [testLabel setTextColor: [UIColor orangeColor]];
    [view addSubview: testLabel];    
    
    
    CGRect buttonFrame = CGRectMake( 10, 80, 100, 30 );
    UIButton *button = [[UIButton alloc] initWithFrame: buttonFrame];
    [button setTitle: @"My Button" forState: UIControlStateNormal];
    [button setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [button setTitleColor: [UIColor blueColor] forState: UIControlStateSelected];
    [view addSubview: button];    
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // add subviews 
    self.view = view;
    
    
    //[button release];
    [testLabel release];    
    [view release];
}

     -(void)buttonTapped:(UIButton*)sender
     {
         NSLog(@"HUZZAH");
         [sender setSelected:!sender.selected];
     }

-(void)loadSounds
{
    NSLog(@"called loading sounds method");
    NSLog(self.soundsLoaded ? @"Yes" : @"No");    
	
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
    soundsLoaded = true;
    NSLog(self.soundsLoaded ? @"Yes" : @"No");         
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
    
    // iterate over sounds
    for (int i = 0; i < [jsonSounds count]; i++) 
    {
        // iterable json object from api call
        NSDictionary* jsonSound = [jsonSounds objectAtIndex:i];
        
        // create sound object
        Sound* sound = [[Sound alloc] init];

        sound.title         = [jsonSound objectForKey:@"title"];
        sound.length        = (int) [jsonSound objectForKey:@"length"];
        sound.author        = [jsonSound objectForKey:@"user_id"];
        sound.location      = [jsonSound objectForKey:@"title"];
        sound.description   = [jsonSound objectForKey:@"title"];  
        
        // add sound object to array
        [sounds addObject:sound];
        
        NSLog(@"processed sound %i: %@", i, sound.title);
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
    
    // create a test sound
    Sound* sound1 = [sounds objectAtIndex:10];    
   
    NSLog(@"view sound title: %@", sound1.title);
    
    
    // display sound data;
    [testLabel setText: sound1.title];
    
    //testLabel.text = sound1.title;
    titleLabel.text = sound1.title;
    
    lengthLabel.text = sound1.formatLength;
    metaLabel.text = [NSString stringWithFormat:@"by %@ in %@)", sound1.author, sound1.location];    
    descriptionLabel.text = sound1.description;
    
    
    
}

- (void)viewDidUnload
{
    [self setTitle:nil];
    [self setTitleLabel:nil];
    [self setLengthLabel:nil];
    [self setMetaLabel:nil];
    [self setDescriptionLabel:nil];
    [self setTitleLabel:nil];
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
    [super dealloc];
}

@end

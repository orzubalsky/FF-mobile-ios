//
//  Sound.m
//  fantastic futures
//
//  Created by OR ZUBALSKY on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sound.h"

@implementation Sound
@synthesize title, author, location, description, length;


-(NSString*) formatLength
{
    int minutes = length / 60;
    int seconds = length % 60;
    
    NSString* minutesString = (minutes < 10) ? [NSString stringWithFormat:@"0%i", minutes] : [NSString stringWithFormat:@"%i", minutes];
    NSString* secondsString = (seconds < 10) ? [NSString stringWithFormat:@"0%i", seconds] : [NSString stringWithFormat:@"%i", seconds];
    
    return [NSString stringWithFormat:@"%@:%@", minutesString, secondsString];
}

@end

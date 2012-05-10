//
//  Sound.h
//  fantastic futures
//
//  Created by OR ZUBALSKY on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Playable.h"

@interface Sound : Playable

{
    NSString* title;
    int length;
    NSString* author;
    NSString* location;
    NSString* description;    
}
@property(readwrite, strong) NSString* title;
@property(readwrite, strong) NSString* author;
@property(readwrite, strong) NSString* location;
@property(readwrite, strong) NSString* description;
@property(readwrite) int length;

-(NSString*) formatLength;


@end

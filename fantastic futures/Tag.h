//
//  Tag.h
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Tag : NSObject
{
    int pk;
    NSString* title;
}
@property(readwrite, strong) NSString* title;
@property(readwrite) int pk;
@end

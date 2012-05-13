//
//  StreamView.h
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundView.h"
#import "JSON.h"
#define kLatestKivaLoansURL @"http://test.fantasticfutures.fm/api/sounds"

@interface StreamView : UIView
{
    NSMutableArray* sounds;
    NSMutableData* responseData;
    NSMutableArray* soundViews;
    UIScrollView* scrollView;
}
@property (retain, nonatomic) NSMutableData* responseData;
@property(readwrite, strong) NSMutableArray* sounds;
@property (retain, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) NSMutableArray* soundViews;

-(void) loadSounds;
@end

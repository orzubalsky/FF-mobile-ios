//
//  FirstViewController.h
//  fantastic futures
//
//  Created by OR ZUBALSKY on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilteringView.h"
#import "StreamingView.h"
#import "JSON.h"
#define soundsURL @"http://test.fantasticfutures.fm/api/sounds"

@interface FirstViewController : UIViewController
{
    NSMutableArray* sounds;
    NSMutableData* responseData;
    NSMutableArray* soundViews;
    FilteringView* filterView;
    StreamingView* streamView;
    bool displayingStreamView;
    
}
@property (retain, nonatomic) NSMutableData* responseData;
@property(readwrite, strong) NSMutableArray* sounds;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) NSMutableArray* soundViews;
@property (retain, nonatomic) FilteringView *filterView;
@property (retain, nonatomic) StreamingView *streamView;

-(void) loadSounds;

@end

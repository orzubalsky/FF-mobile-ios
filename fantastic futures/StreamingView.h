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

@interface StreamingView : UIView
{
    NSMutableArray* sounds;
    NSMutableData* responseData;
    NSMutableArray* soundViews;
    UIScrollView* scrollView;
    NSString* url;
}
@property (retain, nonatomic) NSMutableData* responseData;
@property(readwrite, strong) NSMutableArray* sounds;
@property (retain, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) NSMutableArray* soundViews;
@property (retain, nonatomic) NSString* url;


-(void) loadSounds;
-(void) loadView;
-(void) loadContent:(NSArray*) jsonSounds;
- (id)initWithUrl:(NSString*) _url frame:(CGRect)frame;
@end

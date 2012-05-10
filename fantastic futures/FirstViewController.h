//
//  FirstViewController.h
//  fantastic futures
//
//  Created by OR ZUBALSKY on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sound.h"
#import "JSON.h"
#define kLatestKivaLoansURL @"http://test.fantasticfutures.fm/api/sounds"

@interface FirstViewController : UIViewController
{
    NSMutableArray* sounds;
    NSMutableData* responseData;
    bool soundsLoaded;
}
@property (retain, nonatomic) NSMutableData* responseData;
@property(readwrite, strong) NSMutableArray* sounds;
@property (retain, nonatomic) UILabel *testLabel;
@property (retain, nonatomic) IBOutlet UITextView *lengthLabel;
@property (retain, nonatomic) IBOutlet UITextView *metaLabel;
@property (retain, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (retain, nonatomic) IBOutlet UITextView *titleLabel;
@property(readwrite) bool soundsLoaded;

-(void) loadSounds;

@end

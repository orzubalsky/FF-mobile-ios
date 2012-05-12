//
//  FirstViewController.h
//  fantastic futures
//
//  Created by OR ZUBALSKY on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoundView.h"
#import "JSON.h"
#define kLatestKivaLoansURL @"http://test.fantasticfutures.fm/api/sounds"

@interface FirstViewController : UIViewController
{
    NSMutableArray* sounds;
    NSMutableData* responseData;
    NSMutableArray* soundViews;
}
@property (retain, nonatomic) NSMutableData* responseData;
@property(readwrite, strong) NSMutableArray* sounds;
@property (retain, nonatomic) IBOutlet UITextView *lengthLabel;
@property (retain, nonatomic) IBOutlet UITextView *metaLabel;
@property (retain, nonatomic) IBOutlet UITextView *descriptionLabel;
@property (retain, nonatomic) IBOutlet UITextView *titleLabel;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) NSMutableArray* soundViews;


-(void) loadSounds;

@end

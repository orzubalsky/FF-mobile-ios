//
//  SoundView.h
//  fantastic futures
//
//  Created by Or Zubalsky on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Sound.h"

@interface SoundView : UIView

@property (retain, nonatomic) UITextView *testLabel;
@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *metaLabel;
@property (retain, nonatomic) UILabel *lengthLabel;
@property (retain, nonatomic) UILabel *descriptionLabel;

-(void) populateSounds:(Sound*)sound;
-(void)buttonTapped:(UIButton*)sender;
@end

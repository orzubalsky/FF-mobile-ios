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
#import "FFLabel.h"

@interface SoundView : UIView

@property (retain, nonatomic) FFLabel *titleLabel;
@property (retain, nonatomic) FFLabel *metaLabel;
@property (retain, nonatomic) FFLabel *lengthLabel;
@property (retain, nonatomic) FFLabel *descriptionLabel;

-(void) populateSounds:(Sound*)sound;
-(void)buttonTapped:(UIButton*)sender;
@end

//
//  FilteringView.h
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tag.h"
#import "TagToggleButton.h"

@interface FilteringView : UIView
{
    UIScrollView* containerView;
    NSMutableArray* tagToggleButtons;    
}
@property (retain, nonatomic) NSMutableArray* tagToggleButtons;
@property (retain, nonatomic) UIScrollView *containerView;

-(void) loadView;
-(void) loadContent:(NSArray*) tags;
@end

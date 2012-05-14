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
    NSMutableArray* tags;
    NSMutableArray* tagToggleButtons;
    
}
@property (retain, nonatomic) NSMutableArray* tagToggleButtons;
-(void) loadView;
-(void) loadContent;
@end

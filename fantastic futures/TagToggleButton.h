//
//  TagToggleButton.h
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tag.h"

@interface TagToggleButton : UIButton
{
    Tag* tag;
}
@property (retain, nonatomic) Tag* tag;

- (id)initWithTag:(Tag*)tag frame:(CGRect)frame;

@end

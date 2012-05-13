//
//  FFLabel.h
//  fantastic futures
//
//  Created by Or Zubalsky on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFLabel : UILabel

- (id) initWithStyle: (CGRect)frame fontName:(NSString*) fontName fontSize:(float) fontSize;
- (void)alignTop;
- (void)alignBottom;

@end

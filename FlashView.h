//
//  FlashView.h
//  mastergolf
//
//  Created by wujungao on 1/26/16.
//  Copyright © 2016 Master. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlashView : UIView

-(void)startTextRollAnimationWithText:(NSString *)text;
-(void)setTextRollAnimationRepeatCount:(CGFloat)count;
-(void)setLeftIconWith:(NSString *)imageName;

-(instancetype)initWithFrame:(CGRect)frame;

@end

//
//  FlashView.h
//
//  Created by wujungao on 1/26/16.
//

#import <UIKit/UIKit.h>

@interface FlashView : UIView

-(void)startTextRollAnimationWithText:(NSString *)text;
-(void)setTextRollAnimationRepeatCount:(CGFloat)count;
-(void)setLeftIconWith:(NSString *)imageName;

-(instancetype)initWithFrame:(CGRect)frame;

@end
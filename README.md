#FlashView

FlashView继承UIView。它主要用于滚动显示一行文字。

#如何使用FlashView
1. 直接将FlashView头文件和M文件添加到项目中；
2. 使用-(instancetype)initWithFrame:(CGRect)frame方法初始化FlashView；
3. -(void)startTextRollAnimationWithText:(NSString *)text方法传入文字并开始滚动动画；
4. -(void)setTextRollAnimationRepeatCount:(CGFloat)count设置动画重复次数；
5. -(void)setLeftIconWith:(NSString *)imageName设置左侧通知图标；

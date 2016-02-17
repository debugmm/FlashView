//
//  FlashView.m
//  mastergolf
//
//  Created by wujungao on 1/26/16.
//  Copyright © 2016 Master. All rights reserved.
//

#import "FlashView.h"

#define imageDistanceW 10
#define imageViewW 20
#define imageViewH 20
#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
//
#define maxW ((SCREEN_W) * 10)
#define maxH (imageViewH)
//
#define placeHoldW (self.bounds.size.height)
#define placeHoldH (self.bounds.size.height)
#define nextLabelDistanceW (3*(imageDistanceW))
//
#define contentViewDistanceW (((imageViewW)+(imageDistanceW))+5)
#define contentViewW ((self.bounds.size.width)-(contentViewDistanceW))
#define contentViewH (placeHoldH)
//
#define textAnimationKey (@"textRollAnimation")
//

@interface FlashView()

@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIView *flashLabelView;
//
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *nextLabel;
//
@property(nonatomic,assign)CGSize textSize;
@property(nonatomic,assign)CGFloat repeatCount;

@end

@implementation FlashView

#pragma mark - designated initialization
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    
    if(self){
        
        self.backgroundColor=C52();
        self.repeatCount=0;
        [self.flashLabelView.layer removeAnimationForKey:textAnimationKey];
        //
        [self.flashLabelView addSubview:self.label];
        [self.contentView addSubview:self.flashLabelView];
        [self addSubview:self.imageView];
        [self addSubview:self.contentView];
    }
    return self;
}


#pragma mark - property
-(UIView *)contentView{
    
    if(_contentView==nil){
        
        _contentView=[[UIView alloc] initWithFrame:CGRectMake(contentViewDistanceW, 0, contentViewW, placeHoldH)];
        _contentView.backgroundColor=C52();
        _contentView.clipsToBounds=YES;
    }
    
    return _contentView;
}

-(UIView *)flashLabelView{
    
    if(_flashLabelView==nil){
        
        _flashLabelView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, contentViewW, placeHoldH)];
        _flashLabelView.backgroundColor=C52();
    }
    
    return _flashLabelView;
}

-(UIImageView *)imageView{
    
    if(_imageView==nil){
        
        _imageView=[[UIImageView alloc] initWithFrame:CGRectMake(imageDistanceW, 0.5 *((placeHoldH)-(imageViewH)), imageViewW, imageViewH)];
        _imageView.backgroundColor=C52();
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        _imageView.image=[UIImage imageNamed:@"iconNotification"];
    }
    
    return _imageView;
}

-(UILabel *)label{
    
    if(_label==nil){
        
        _label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, placeHoldW, placeHoldH)];
        _label.numberOfLines=1;
        _label.font=T2();
        _label.backgroundColor=C52();
        _label.textAlignment=NSTextAlignmentCenter;
        _label.textColor=C0();
    }
    
    return _label;
}

-(UILabel *)nextLabel{
    
    if(_nextLabel==nil){
        
        _nextLabel=[[UILabel alloc] initWithFrame:CGRectMake(placeHoldW+nextLabelDistanceW, 0, placeHoldW, placeHoldH)];
        _nextLabel.numberOfLines=1;
        _nextLabel.font=T2();
        _nextLabel.backgroundColor=C52();
        _nextLabel.textAlignment=NSTextAlignmentCenter;
        _nextLabel.textColor=C0();
        //
        [self.flashLabelView addSubview:_nextLabel];
    }
    
    return _nextLabel;
}

#pragma mark - pub method
-(void)setRepeatCount:(CGFloat)count{
    
    self.repeatCount=count;
}

-(void)startTextRollAnimationWithText:(NSString *)text{
    
    [self calculateText:text];
    //
    if((self.textSize.width)>contentViewW){
        //need roll
        [self configFlashLabelViewAndNextLabelFrame];
        self.nextLabel.text=text;
        
        [self textRollAnimation];
        
    }else{
        //just display
        self.label.frame=CGRectMake(0, 0, contentViewW, placeHoldH);
    }
}

#pragma mark - internal method
-(void)configFlashLabelViewAndNextLabelFrame{
    
    self.nextLabel.frame=CGRectMake(self.label.frame.size.width+nextLabelDistanceW, 0, self.label.frame.size.width, placeHoldH);
    self.flashLabelView.frame=CGRectMake(0, 0, 2*(self.label.frame.size.width)+nextLabelDistanceW, placeHoldH);
}

-(void)calculateText:(NSString *)text{
    
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(maxW, maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:T2()} context:nil].size;
    self.textSize=textSize;
    self.label.frame=CGRectMake(0, 0, textSize.width, placeHoldH);
    self.label.text=text;
}

-(void)textRollAnimation{
    
    CAKeyframeAnimation *textRollAnimation=[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    //
    textRollAnimation.values=@[@(0),@(0),@(-(self.textSize.width+nextLabelDistanceW))];
    textRollAnimation.keyTimes=@[@(0),@(0.03),@(1.0)];
    textRollAnimation.duration=((self.textSize.width+nextLabelDistanceW)/contentViewW)*10;
    textRollAnimation.repeatCount=(self.repeatCount<=0 ? INT32_MAX : self.repeatCount);
    textRollAnimation.removedOnCompletion=NO;
    textRollAnimation.autoreverses=NO;
    //
    [self.flashLabelView.layer addAnimation:textRollAnimation forKey:textAnimationKey];
}

@end

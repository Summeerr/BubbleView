//
//  Bubble.h
//  RunTimeDemo
//
//  Created by 胡祥 on 2019/5/5.
//  Copyright © 2019年 胡祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HETSleepBubble : UIButton
@property (nonatomic, assign) float mVx;// X轴速度
@property (nonatomic, assign) float mVy;// Y轴速度
-(void)move:(CGRect)rectF arr:(NSArray *)list;

@end

NS_ASSUME_NONNULL_END

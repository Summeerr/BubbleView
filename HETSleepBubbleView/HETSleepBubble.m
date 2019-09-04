//
//  Bubble.m
//  RunTimeDemo
//
//  Created by 胡祥 on 2019/5/5.
//  Copyright © 2019年 胡祥. All rights reserved.
//

#import "HETSleepBubble.h"
#import "UIView+Frame.h"
@interface HETSleepBubble()

@end

@implementation HETSleepBubble

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
-(void)move:(CGRect)rectF arr:(NSArray *)list{
    
    //向角度的方向移动，偏移圆心
    self.CS_centerX += self.mVx;
    self.CS_centerY += self.mVy;
    
    /** 边界检测 **/
    float f = self.CS_right - rectF.size.width;
    if(f > 0) { //碰右
        self.mVx = - fabsf(self.mVx);
        self.CS_centerX = rectF.size.width - self.CS_width*0.5 - f;
    }
    
    f = self.CS_left;
    if(f < 0) { //碰左
        self.mVx = fabs(self.mVx);
        self.CS_centerX = self.CS_width*0.5 - f;
    }
    
    f = self.CS_bottom - rectF.size.height;
    if(f > 0) { //碰下
        self.mVy = - fabs(self.mVy);
        self.CS_centerY = rectF.size.height - self.CS_width*0.5 - f;
    }
    
    f = self.CS_centerY - self.CS_width*0.5;
    if(f < 0) { //碰上
        self.mVy = fabs(self.mVy);
        self.CS_centerY = self.CS_width*0.5 - f;
    }
    
    // TODO 速度渐变
    // 碰撞检测
    for(HETSleepBubble *bubble in list) {
        if(bubble == self) {
            continue;
        }
        float dx = fabs(self.CS_centerX - bubble.CS_centerX);
        float dy = fabs(self.CS_centerY - bubble.CS_centerY);
        // 距离
        float dis = (float) sqrt(dx * dx + dy * dy);
        
        if(dis == 0) dis = 1;
        
        float d = self.CS_width*0.5 + bubble.CS_width*0.5 - dis;
        
        if(d >= 0) { // 距离小于半径和
            float py1 = (dy * dy) * bubble.mVy / dis / dis
            + (dy * dx) * bubble.mVx / dis / dis;
            float px1 = (dx * dx) * bubble.mVx / dis /dis
            + (dy * dx) * bubble.mVy / dis / dis;
            
            float py2 = (dy * dy) * self.mVy / dis / dis
            + (dy * dx) * self.mVx / dis / dis;
            float px2 = (dx * dx) * self.mVx / dis /dis
            + (dx * dy) * self.mVy / dis / dis;
            
            self.mVx += px1;
            self.mVx -= px2;
            self.mVy += py1;
            self.mVy -= py2;
            
            bubble.mVx -= px1;
            bubble.mVx += px2;
            bubble.mVy -= py1;
            bubble.mVy += py2;
            
            if(d > 0) {
                float dx2 = d * (bubble.CS_centerX -  self.CS_centerX) / dis;
                float dy2 = d * (bubble.CS_centerY - self.CS_centerY) / dis;
                bubble.CS_centerX += dx2;
                bubble.CS_centerY += dy2;
            }
        }
    }
    
    
    
}

@end

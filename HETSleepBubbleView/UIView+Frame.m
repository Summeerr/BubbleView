//
//  UIView+Frame.m
//  Coding_iOS
//
//  Created by pan Shiyu on 15/7/16.
//  Copyright (c) 2015年 Coding. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setCS_x:(CGFloat)CS_x{
    CGRect frame = self.frame;
    frame.origin.x = CS_x;
    self.frame = frame;
}
-(CGFloat)CS_x{
    return self.frame.origin.x;
}
-(void)setCS_y:(CGFloat)CS_y{
    CGRect frame = self.frame;
    frame.origin.y = CS_y;
    self.frame = frame;
}
- (CGFloat)CS_y
{
    return self.frame.origin.y;
}
-(void)setCS_centerX:(CGFloat)CS_centerX{
    CGPoint center = self.center;
    center.x = CS_centerX;
    self.center = center;
}
-(CGFloat)CS_centerX{
    return self.center.x;
}
-(void)setCS_centerY:(CGFloat)CS_centerY{
    CGPoint center = self.center;
    center.y = CS_centerY;
    self.center = center;
}
-(CGFloat)CS_centerY{
    return self.center.y;
}
-(void)setCS_width:(CGFloat)CS_width{
    CGRect frame = self.frame;
    frame.size.width = CS_width;
    self.frame = frame;
}
-(CGFloat)CS_width{
    return self.frame.size.width;
}
-(void)setCS_height:(CGFloat)CS_height{
    CGRect frame = self.frame;
    frame.size.height = CS_height;
    self.frame = frame;
}
-(CGFloat)CS_height{
    return self.frame.size.height;
}
-(void)setCS_size:(CGSize)CS_size{
    CGRect frame = self.frame;
    frame.size = CS_size;
    self.frame = frame;
}
-(CGSize)CS_size{
    return self.frame.size;
}
-(void)setCS_top:(CGFloat)CS_top{
    self.frame = CGRectMake(self.CS_left, CS_top, self.CS_width, self.CS_height);
}
-(CGFloat)CS_top{
    return self.frame.origin.y;
}
-(void)setCS_bottom:(CGFloat)CS_bottom{
    self.frame = CGRectMake(self.CS_left, CS_bottom - self.CS_height, self.CS_width, self.CS_height);
}
- (CGFloat)CS_bottom
{
    return self.frame.origin.y + self.frame.size.height;
}
-(void)setCS_left:(CGFloat)CS_left{
    self.frame = CGRectMake(CS_left, self.CS_top, self.CS_width, self.CS_height);
}
- (CGFloat)CS_left
{
    return self.frame.origin.x;
}
-(void)setCS_right:(CGFloat)CS_right{
   self.frame = CGRectMake(CS_right - self.CS_width, self.CS_top, self.CS_width, self.CS_height);
}
- (CGFloat)CS_right
{
    return self.frame.origin.x + self.frame.size.width;
}

@end


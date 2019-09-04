//
//  UIView+Frame.h
//  HuoDaoWang
//
//  Created by zhangjinlin on 15/8/22.
//  Copyright (c) 2015年 zhangjinlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat CS_x;
@property (nonatomic, assign) CGFloat CS_y;
@property (nonatomic, assign) CGFloat CS_centerX;
@property (nonatomic, assign) CGFloat CS_centerY;
@property (nonatomic, assign) CGFloat CS_width;
@property (nonatomic, assign) CGFloat CS_height;
@property (nonatomic, assign) CGSize CS_size;

@property (nonatomic, assign) CGFloat CS_top;
@property (nonatomic, assign) CGFloat CS_bottom;
@property (nonatomic, assign) CGFloat CS_left;
@property (nonatomic, assign) CGFloat CS_right;

@end

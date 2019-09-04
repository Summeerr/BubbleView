//
//  BubbleView.h
//  RunTimeDemo
//
//  Created by 胡祥 on 2019/5/5.
//  Copyright © 2019年 胡祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BubbleClick <NSObject>
/**
 * 选中球第几个
 */
-(void)bubbleClickStr:(NSString *)selectStr;

@end


@interface BubbleView : UIView

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NSArray *tagArr;//!< 传入二维数组,二维数组的首个数组表示有序数列,后面的数组表示无序。新增的标签一定是排在前面
@property (nonatomic, strong) NSArray *bubbleList;//!< 所有的bubble,外面自定义每个球的样式
@property (nonatomic, assign) float randomSpeed;//!< 每个小球的随机速度,该值为0-randomSpeed,数值越大跳动越快,一般小于1,最小为0,default:0
/**
 * 移除所有标签
 */
-(void)sleepTagsRefresh;

@end



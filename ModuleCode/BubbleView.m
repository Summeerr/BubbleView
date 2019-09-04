//
//  BubbleView.m
//  RunTimeDemo
//
//  Created by 胡祥 on 2019/5/5.
//  Copyright © 2019年 胡祥. All rights reserved.
//

#import "BubbleView.h"
#import "HETSleepBubble.h"
#import "UIView+Frame.h"

@interface BubbleView()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *scrollContentView;
@property (nonatomic, strong) NSMutableArray *randomBigBallArrM;
@property (nonatomic, strong) NSMutableArray *randomSmallBallArrM;
@property (nonatomic, strong) NSMutableArray *orderBigBallArrM;
@property (nonatomic, strong) NSMutableArray *orderSmallBallArrM;
@property (nonatomic, strong) NSMutableArray *randomXYM;
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation BubbleView
-(NSMutableArray *)randomXYM{
    if (!_randomXYM) {
        _randomXYM = [NSMutableArray array];
    }
    return _randomXYM;
}
-(NSMutableArray *)randomBigBallArrM{
    if (!_randomBigBallArrM) {
        _randomBigBallArrM = [NSMutableArray array];
    }
    return _randomBigBallArrM;
}
-(NSMutableArray *)randomSmallBallArrM{
    if (!_randomSmallBallArrM) {
        _randomSmallBallArrM = [NSMutableArray array];
    }
    return _randomSmallBallArrM;
}
-(NSMutableArray *)orderBigBallArrM{
    if (_orderBigBallArrM) {
        _orderBigBallArrM = [NSMutableArray array];
    }
    return _orderBigBallArrM;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initPaint];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sleepTagsRefresh) name:@"sleepTagsRefresh" object:nil];
        self.timer = [NSTimer timerWithTimeInterval:0.03 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}
/**
 * 移除所有标签
 */
-(void)sleepTagsRefresh{
    for (UIView *subView in self.scrollContentView.subviews) {
        [subView removeFromSuperview];
    }
    self.bubbleList = nil;
}
-(void)initPaint{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.CS_height)];
    [self addSubview:self.scrollView];
    
    self.scrollContentView = [[UIView alloc]initWithFrame:self.scrollView.bounds];
    [self.scrollView addSubview:self.scrollContentView];
    self.scrollView.showsVerticalScrollIndicator = self.scrollView.showsHorizontalScrollIndicator = NO;
}
-(void)setTagArr:(NSArray *)tagArr{
    NSArray *firstA = tagArr.firstObject;
    NSArray *lastA = tagArr.lastObject;
    self.scrollView.contentSize = CGSizeMake(80*ceil((firstA.count+lastA.count)/floor(self.CS_height/80)), self.scrollView.CS_height);
    if (self.scrollView.contentSize.width <= [UIScreen mainScreen].bounds.size.width) {
        self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.scrollView.CS_height);
    }
    self.scrollContentView.CS_width = self.scrollView.contentSize.width;
    [self randomXYWithTag:tagArr];//生成tagArr对应个数的random值
    for (int i = 0; i < firstA.count; i++) {//布局新增的小球
        NSString *str = firstA[i];
        HETSleepBubble *btn = [self bubbleWithDic:str];
        btn.CS_x = [[self dictionaryWithJsonString:((NSArray *)self.randomXYM.firstObject)[i]][@"x"] floatValue] * 80;//分段思想
        btn.CS_y = [[self dictionaryWithJsonString:((NSArray *)self.randomXYM.firstObject)[i]][@"y"] floatValue] * 80;//分段思想
    }
    for (NSInteger i = 0; i < lastA.count; i++){//布局随机小球位置
        NSString *str = lastA[i];
        HETSleepBubble *btn = [self bubbleWithDic:str];
        btn.CS_x = ([[self dictionaryWithJsonString:((NSArray *)self.randomXYM.lastObject)[i]][@"x"] floatValue] + ceil(((NSArray*)tagArr.firstObject).count/2.0)) * 80;
        btn.CS_y = [[self dictionaryWithJsonString:((NSArray *)self.randomXYM.lastObject)[i]][@"y"] floatValue] * 80;//分段思想
    }
    self.bubbleList = self.scrollContentView.subviews;
}
-(HETSleepBubble *)bubbleWithDic:(NSString *)str{
    HETSleepBubble *btn = [HETSleepBubble new];
    [self.scrollContentView addSubview:btn];
    btn.CS_size = CGSizeMake(80, 80);
    [btn setTitle:str forState:UIControlStateNormal];
    //    btn.tag = i;
    [self initBubbl: btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(bubbleClickStr:)]) {
        [self.delegate bubbleClickStr:btn.titleLabel.text];
    }
}
-(void)timeAction{
    for (int i = 0; i < self.scrollContentView.subviews.count; i++) {
        HETSleepBubble *bubble = self.scrollContentView.subviews[i];
        [bubble move:self.scrollContentView.bounds arr:self.scrollContentView.subviews];; // 移动
    }
}
- (void)setRandomSpeed:(float)randomSpeed{
    _randomSpeed = randomSpeed;
    // 设置速度
    for (HETSleepBubble *bubble in self.bubbleList) {
        float speedX = arc4random_uniform(randomSpeed*100)/100.0;
        float speedY = arc4random_uniform(randomSpeed*100)/100.0;
        bubble.mVx = speedX;
        bubble.mVy = speedY;
    }
}
-(void)initBubbl:(HETSleepBubble *)bubble{
    // 设置速度
    float speedX = arc4random_uniform(self.randomSpeed*100)/100.0;
    float speedY = arc4random_uniform(self.randomSpeed*100)/100.0;
    bubble.mVx = speedX;
    bubble.mVy = speedY;
}
/**
 * 随机生成距离，分块计算
 */
-(void)randomXYWithTag:(NSArray *)tags{
    [self.randomXYM removeAllObjects];
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < ((int)ceil(((NSArray *)tags.firstObject).count/((int)floor(self.CS_height/80)))); i++) {
        for (int j = 0; j < ((int)floor(self.CS_height/80)); j++) {
            [arrM addObject:[self dictionaryToJson:@{@"x":@(i),@"y":@(j)}]];
        }
    }
    [self.randomXYM addObject:arrM];
    NSMutableArray *arrM1 = [NSMutableArray array];
    for(int i=0; i<((NSArray *)tags.lastObject).count; i++)
    {
        int x = arc4random() % ((int)(self.scrollContentView.CS_width)/80);
        int y = arc4random() % ((int)(self.scrollContentView.CS_height)/80);
        for(int j=0; j<arrM1.count; j++)
        {
            NSString *s = arrM1[j];
            while([s isEqualToString:[self dictionaryToJson:@{@"x":@(x),@"y":@(y)}]])
            {
                x = arc4random() % ((int)(self.scrollContentView.CS_width)/80);
                y = arc4random() % ((int)(self.scrollContentView.CS_height)/80);
                j = -1;
            }
        }
        [arrM1 addObject:[self dictionaryToJson:@{@"x":@(x),@"y":@(y)}]];
    }
    [self.randomXYM addObject:arrM1];
}
#pragma mark 字典转化字符串
-(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end

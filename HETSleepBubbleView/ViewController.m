//
//  ViewController.m
//  TemplateApp
//
//  Created by HET on 2018/5/31.
//  Copyright © 2018年 HET. All rights reserved.
//

#import "ViewController.h"
#import "BubbleView.h"
// 设置View圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]
@interface ViewController ()<BubbleClick>
@property (nonatomic, strong) BubbleView *bubbleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BubbleView *bubbleView = [[BubbleView alloc]initWithFrame:CGRectMake(0,50, [UIScreen mainScreen].bounds.size.width, 300)];
    self.bubbleView = bubbleView;
    [self.view addSubview:bubbleView];
    bubbleView.delegate = self;
    bubbleView.tagArr = @[@[],@[@"a",@"b",@"c",@"1",@"2",@"3",@"小球",@"气泡",@"3",@"小球",@"气泡"]];
    bubbleView.randomSpeed = 1;
    for (UIButton *b in bubbleView.bubbleList) {
        [b setValue:[UIColor redColor] forKey:@"backgroundColor"];
        ViewRadius(b, b.bounds.size.width*0.5);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.bubbleView sleepTagsRefresh];
    self.bubbleView.tagArr = @[@[@"111",@"222",@"333",@"444",@"555",@"666"],@[@"3",@"小球",@"气泡",@"3",@"小球",@"气泡",@"3",@"小球",@"气泡"]];
    for (UIButton *b in self.bubbleView.bubbleList) {
        [b setValue:[UIColor greenColor] forKey:@"backgroundColor"];
        ViewRadius(b, b.bounds.size.width*0.5);
    }
}

-(void)bubbleClickStr:(NSString *)selectStr {
    NSLog(@"%@",selectStr);
}


@end

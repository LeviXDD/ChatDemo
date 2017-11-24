//
//  HWEmotionListView.m
//  黑马微博2期
//
//  Created by apple on 14-10-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWEmotionKeyboard.h"
#import "HWEmotionListView.h"
#import "HWEmotionPageView.h"

@interface HWEmotionListView() <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIButton *sendBtn;
@end

@implementation HWEmotionListView{
    NSMutableArray *pageViewArr;
    NSMutableArray *rangeArr;
    NSMutableArray * startArr;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 1.UIScollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        // 去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        // 去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        // 当只有1页时，自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        [pageControl setPageIndicatorTintColor:[UIColor hx_colorWithHexString:@"DEE1E2"]];
        [pageControl setCurrentPageIndicatorTintColor:[UIColor hx_colorWithHexString:@"8F8F8F"]];
        // 设置内部的圆点图片
//        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
//        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
        
//        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
//        sendBtn.layer.cornerRadius = 5.0f;
//        sendBtn.clipsToBounds = YES;
//        [sendBtn setBackgroundColor:[UIColor hx_colorWithHexRGBAString:@"007AFF"]];
//        [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:sendBtn];
//        self.sendBtn = sendBtn;
//        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-15);
////           make.top.equalTo(self.mas_top).with.offset(-40);
////            make.bottom.mas_equalTo(10);
//            make.width.mas_equalTo(66);
//            make.height.mas_equalTo(30);
//        }];
    }
    return self;
}

- (void)sendMessage{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_EMOTION_SENDMESSAGE object:nil];
}

// 根据emotions，创建对应个数的表情
- (void)setEmotions:(NSArray *)emotions
{
    NSLog(@"加载emoji 开始");
    _emotions = emotions;
    
    // 删除之前的控件
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = (emotions.count + HWEmotionPageSize - 1) / HWEmotionPageSize;
    
    // 1.设置页数
    self.pageControl.numberOfPages = count;
//    self.pageControl.numberOfPages = count > 1? count : 0;
    NSLog(@"加载emoji 一半");
    // 2.创建用来显示每一页表情的控件
    pageViewArr = [@[]mutableCopy];
    rangeArr = [@[]mutableCopy];
    startArr = [@[]mutableCopy];
    for (int i = 0; i<count; i++) {
        HWEmotionPageView *pageView = [[HWEmotionPageView alloc] init];
        // 计算这一页的表情范围
        NSRange range;
        range.location = i * HWEmotionPageSize;
        // left：剩余的表情个数（可以截取的）
        NSUInteger left = emotions.count - range.location;
        if (left >= HWEmotionPageSize) { // 这一页足够20个
            range.length = HWEmotionPageSize;
        } else {
            range.length = left;
        }
        // 设置这一页的表情
        [pageViewArr addObject:pageView];
        [rangeArr addObject:[NSNumber numberWithUnsignedInteger:range.length]];
        [startArr addObject:[NSNumber numberWithUnsignedInteger:range.location]];
        if (!i) {
            pageView.emotions = [emotions subarrayWithRange:range];
        }
        [self.scrollView addSubview:pageView];
    }
    NSLog(@"加载emoji 结束");
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.left = 0;
    self.pageControl.top = self.height - self.pageControl.height - 50;
    
    [self.sendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pageControl.mas_centerY);
    }];
    
    // 2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.top+20;
    self.scrollView.left = self.scrollView.top = 0;
    
    // 3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i<count; i++) {
        HWEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.height = self.scrollView.height;
        pageView.width = self.scrollView.width;
        pageView.left = pageView.width * i;
        pageView.top = 0;
    }
    
    // 4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double pageNo = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
     HWEmotionPageView *view = pageViewArr[self.pageControl.currentPage];
    if (!view.emotions.count) {
        NSRange range ;
        range.location = [startArr[self.pageControl.currentPage] integerValue];
        range.length   = [rangeArr[self.pageControl.currentPage] integerValue];
        view.emotions = [self.emotions subarrayWithRange:range];
    }
    
}

@end

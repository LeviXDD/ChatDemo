//
//  HTBaseTableView.h
//  HT
//
//  Created by 海涛 黎 on 17/5/30.
//  Copyright © 2017年 海涛 黎. All rights reserved.
//

#import "HTBaseTableView.h"
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"
#import "HTRefreshHeader.h"
#import "AFNetworkReachabilityManager.h"
@interface HTBaseTableView()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic,strong) UIView * noDataView;

@property(nonatomic, strong) HTRefreshHeader *refreshHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter * footer;
@end

@implementation HTBaseTableView
#pragma mark -- life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    
    if(self= [super initWithFrame:frame]) {
        
        
        self.showsVerticalScrollIndicator=YES;
        
        self.showsHorizontalScrollIndicator=NO;
        
        self.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    self.tableFooterView = [UIView new];
    return self;
}

-(HTRefreshHeader *)refreshHeader{
    if (!_refreshHeader) {
        _refreshHeader = [HTRefreshHeader headerWithRefreshingBlock:^{
            if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==AFNetworkReachabilityStatusUnknown || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==AFNetworkReachabilityStatusNotReachable) {
            }
            if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(tableViewDelegateRefresh:)]) {
                [self.baseDelegate tableViewDelegateRefresh:self];
            }
        }];
        _refreshHeader.ignoredScrollViewContentInsetTop = -20;

    }
    return _refreshHeader;
}

- (void)setCanRefresh:(BOOL)canRefresh {
    if(canRefresh) {
        self.mj_header = self.refreshHeader;
    } else {
        self.mj_header = nil;
    }
}

-(void)setCanShowNoDataView:(BOOL)canShowNoDataView{
    
    if (canShowNoDataView) {
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.tableFooterView = [UIView new];
    }
    
}
- (void)setCanLoadMoreData:(BOOL)canLoadMoreData {
    
    if(canLoadMoreData) {
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==AFNetworkReachabilityStatusUnknown || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==AFNetworkReachabilityStatusNotReachable) {
                //        [Utils showToast:@"当前无网络"];
                [self endFooterRefresh];
            }
            if(self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(tableViewDelegateLoadMoreData:)]) {
                [self.baseDelegate tableViewDelegateLoadMoreData:self];
            }
        }];
        [self.footer setTitle:EMPTY_IF_NIL(self.loadMoreDataDescription) forState:MJRefreshStateIdle];
        [self.footer setTitle:EMPTY_IF_NIL(self.refreshingDataDescription) forState:MJRefreshStateRefreshing];
        [self.footer setTitle:EMPTY_IF_NIL(self.noMoreDataDescription) forState:MJRefreshStateNoMoreData];
//        [self.footer.stateLabel setTextColor:commonGrayDarkerColor];
        //        [footer setTitle:@"没有更多了"forState:MJRefreshStateNoMoreData];
        //        footer.stateLabel.font= [UIFont systemFontOfSize:12];
        //        footer.stateLabel.textColor= [UIColor grayColor];
        self.mj_footer= self.footer;
    }
}

- (void)setShowLogo:(BOOL)showLogo {
    
    //    ((MJDIYHeader*)self.mj_header).logo.hidden= !showLogo;
    
}

-(void)setNoMoreDataDescription:(NSString *)noMoreDataDescription{
    _noMoreDataDescription = noMoreDataDescription;
     [self.footer setTitle:noMoreDataDescription forState:MJRefreshStateNoMoreData];
}

-(void)setRefreshingDataDescription:(NSString *)refreshingDataDescription{
    _refreshingDataDescription = refreshingDataDescription;
    [self.footer setTitle:refreshingDataDescription forState:MJRefreshStateRefreshing];
}

-(void)setLoadMoreDataDescription:(NSString *)loadMoreDataDescription{
    _loadMoreDataDescription = loadMoreDataDescription;
    [self.footer setTitle:loadMoreDataDescription forState:MJRefreshStateIdle];
}

-(void)setEndMoreData:(NSString *)string{
    [self.footer setTitle:string forState:MJRefreshStateNoMoreData];
    [self.footer.stateLabel setTextColor:[UIColor hx_colorWithHexString:@"#A7A7A7"]];
}

- (void)endRefreshingWithNoMoreData {

    //显示没有更多内容
    [self.mj_footer endRefreshingWithNoMoreData];
}


- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
    
}

- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
    
}

- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}

- (void)beginRefresh {
        [self.mj_header beginRefreshing];
    
}

-(BOOL)headerIsRefresh{
    
    return [self.mj_header isRefreshing];
    
}
-(BOOL)footerIsRefresh{
    
    return [self.mj_footer isRefreshing];
    
}

#pragma mark -- DZNEmptyData delegate
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(descriptionForEmptyDataSet:)]) {
        NSString *string = [self.baseDelegate descriptionForEmptyDataSet:scrollView];
        return [[NSAttributedString alloc]initWithString:string];
    }else{
            NSAttributedString * string =[[NSAttributedString alloc]initWithString:@"暂时没有数据，精彩等你发现!"];
            return string;
    }
}

-(NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(buttonTitleForEmptyDataSet:forState:)]) {
        NSString *string = [self.baseDelegate buttonTitleForEmptyDataSet:self forState:state];
        if (STRING_ISNIL(string)) {
            return nil;
        } else {
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
            [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangSC_Regular size:16] range:NSMakeRange(0, string.length)];
            [text addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, string.length)];
            return text;
        }
    }else{
        return nil;
    }
    
//    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(buttonTitleForEmptyDataSet:forState:)]) {
//        NSString *string = [self.baseDelegate buttonTitleForEmptyDataSet:self forState:state:];
//        return [[NSAttributedString alloc]initWithString:string];
//    }else{
//        NSAttributedString * string =[[NSAttributedString alloc]initWithString:@"暂时没有数据，精彩等你发现!"];
//        return string;
//    }
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"点击重试"];
//    [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:kPingFangSC_Regular size:16] range:NSMakeRange(0, 4)];
//    [text addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, 4)];
//    return text;
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(emptyDataSetDidTapView:)]) {
        [self.baseDelegate emptyDataSetDidTapView:self];
    }
}

-(CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -0.1*self.height;//(self.height/2.-(self.height*0.4));
}

-(void)setBaseDelegate:(id<HTBaseTableViewDelegate>)baseDelegate{
    _baseDelegate = baseDelegate;
}
@end

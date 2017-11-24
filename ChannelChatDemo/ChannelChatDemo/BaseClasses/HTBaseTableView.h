//
//  HTBaseTableView.h
//  HT
//
//  Created by 海涛 黎 on 17/5/30.
//  Copyright © 2017年 海涛 黎. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTBaseTableView;

@protocol HTBaseTableViewDelegate<NSObject>
@optional
- (void)tableViewDelegateRefresh:(HTBaseTableView*_Nullable)tableView;

- (void)tableViewDelegateLoadMoreData:(HTBaseTableView*_Nullable)tableView;

@optional
-(NSString*_Nullable)descriptionForEmptyDataSet:(UIScrollView*_Nullable)scrollView;
-(NSString*_Nullable)buttonTitleForEmptyDataSet:(HTBaseTableView*_Nonnull)tableView forState:(UIControlState)state;
-(void)emptyDataSetDidTapView:(HTBaseTableView*_Nullable)tableView;

//- (UIView *)QCustomViewForEmptyDataSet:(UIScrollView *)scrollView;
//
//- (UIImage *)QimageForEmptyDataSet:(UIScrollView *)scrollView;
//- (CGFloat)QspaceHeightForEmptyDataSet:(UIScrollView *)scrollView;
//- (BOOL)QemptyDataSetShouldAllowTouch:(UIScrollView *)scrollView;
//
//- (UIImage *)QbuttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
//- (CGFloat)QverticalOffsetForEmptyDataSet:(UIScrollView *)scrollView;
//
//- (NSAttributedString *)QdescriptionForEmptyDataSet:(UIScrollView *)scrollView;
//- (void)qEmptyDataSetDidTapButton;


@end

@interface HTBaseTableView : UITableView

@property(nonatomic,strong)NSArray * _Nullable dataSourceArr;

@property(nonatomic,assign)BOOL canRefresh;

@property(nonatomic,assign)BOOL canLoadMoreData;

@property(nonatomic,assign)BOOL showLogo;

@property (nonatomic, weak, nullable) id <HTBaseTableViewDelegate> baseDelegate;

@property(nonatomic,assign)BOOL canShowNoDataView;

@property(nonatomic, strong) NSString * _Nullable noMoreDataDescription;
@property(nonatomic, strong) NSString * _Nullable loadMoreDataDescription;
@property(nonatomic, strong) NSString * _Nullable refreshingDataDescription;

//- (void)endWithNoContent:(NSString*)title;

//下拉属性显示没有更多数据
- (void)endRefreshingWithNoMoreData;

- (void)resetNoMoreData;
//下拉刷新完毕
- (void)endHeaderRefresh;
//上拉加载更多完毕
- (void)endFooterRefresh;
//开始刷新
- (void)beginRefresh;

//- (void)removeCustomNocontentView;

-(BOOL)headerIsRefresh;

-(BOOL)footerIsRefresh;
@end

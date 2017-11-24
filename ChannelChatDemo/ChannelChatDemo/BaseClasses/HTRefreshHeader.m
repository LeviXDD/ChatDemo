//
//  HTRefreshHeader.m
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/27.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "HTRefreshHeader.h"
@interface HTRefreshHeader()
@property(nonatomic, strong) UIActivityIndicatorView *activityView;
@end
@implementation HTRefreshHeader
-(void)prepare{
    [super prepare];
    [self addSubview:self.activityView];
}

-(void)placeSubviews{
    [super placeSubviews];
    self.height = 40;
    
    CGFloat selfCenterX = SCREEN_WIDTH/2.;
    CGFloat selfCenterY = self.centerY;
    self.activityView.frame = CGRectMake(selfCenterX-10, selfCenterY-10, 20, 20);
}

-(UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityView startAnimating];
    }
    return _activityView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

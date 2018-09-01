//
//  HTChatTableViewCell.m
//  ChannelChatDemo
//
//  Created by 海涛 黎 on 2017/11/24.
//  Copyright © 2017年 Levi. All rights reserved.
//

#import "HTChatTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface HTChatTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@end

@implementation HTChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = 3.;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1511512783&di=b3e1813e713115edd6603c251ea1353b&src=http://dzb.jinbaonet.com/images/2011-10/14/A18/res03_attpic_brief.jpg"]];
}
@end

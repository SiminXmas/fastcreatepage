//
//  XMTableViewCell.m
//  fastcreatepage
//
//  Created by xuemin on 2017/3/30.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import "XMTableViewCell.h"

@implementation XMTableViewCell

@synthesize dataObject;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)showDataWithData:(id)data indexPatch:(NSIndexPath *)indexPatch {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSInteger type = [data[@"type"] integerValue];
        if (type == 2) {
            self.textLabel.text = data[@"subject"];
        }
        else {
            self.textLabel.text = data[@"title"];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView cellHeightWithIndexPatch:(NSIndexPath *)indexPatch {
    return [tableView fd_heightForCellWithIdentifier:XMTableViewCellIdentifier
                                          cacheByKey:XMTableViewCellIdentifier
                                       configuration:^(XMTableViewCell * cell) {
        [cell showDataWithData:cell.dataObject indexPatch:indexPatch];
    }];
}
@end

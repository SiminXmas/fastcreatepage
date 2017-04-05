//
//  XMFCPItemModel.m
//  fastcreatepage
//
//  Created by xuemin on 2017/3/29.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import "XMFCPItem.h"

@interface XMFCPItem ()
//@property (nonatomic, weak) UITableViewCell<XMFCPItemShowProtocol> * cell;
@end

@implementation XMFCPItem


- (CGFloat)tableView:(UITableView *)tableView
                cell:(UITableViewCell<XMFCPItemShowProtocol> *)cell
heightWithIndexPatch:(NSIndexPath *)indexPatch {
    if ([cell conformsToProtocol:@protocol(XMFCPItemShowProtocol)]) {
        return [cell tableView:tableView cellHeightWithIndexPatch:indexPatch];
    }
    else {
        return 0;
    }
}
@end

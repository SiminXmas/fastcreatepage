//
//  XMFCPItem.h
//  fastcreatepage
//
//  Created by xuemin on 2017/3/29.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "XMFCPItemShowProtocol.h"

@interface XMFCPItem : NSObject
@property (nonatomic, copy) NSString *viewIndentifier; //视图标识符
@property (nonatomic, strong) id dataObject; //每个item 对应的数据实体


- (CGFloat)tableView:(UITableView *)tableView
                cell:(UITableViewCell<XMFCPItemShowProtocol> *)cell
heightWithIndexPatch:(NSIndexPath *)indexPatch;
@end

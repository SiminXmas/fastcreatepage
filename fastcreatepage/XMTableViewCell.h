//
//  XMTableViewCell.h
//  fastcreatepage
//
//  Created by xuemin on 2017/3/30.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMFCPItemShowProtocol.h"


static NSString *const XMTableViewCellIdentifier = @"XMTableViewCell";
/**
 我是一个测试的Cell
 */
@interface XMTableViewCell : UITableViewCell <XMFCPItemShowProtocol>


@end

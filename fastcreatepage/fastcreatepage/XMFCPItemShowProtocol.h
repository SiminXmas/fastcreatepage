//
//  XMFCPItemProtocol.h
//  fastcreatepage
//
//  Created by xuemin on 2017/3/29.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <UIKit/UIKit.h>

/**
 每个Item 必须遵守的Protocol
 */
@protocol XMFCPItemShowProtocol <NSObject>

@property (nonatomic, weak) id dataObject; //每个item 对应的数据实体



/**
 Cell 必须实现的装载数据的方法

 @param data 任意数据类型
 @param indexPatch 当前Item的索引路径
 */
- (void)showDataWithData:(id)data
              indexPatch:(NSIndexPath *)indexPatch;


/**
 Cell 必须实现的高度计算

 @param indexPatch 当前Cell的路径
 @return 高度
 */
- (CGFloat)tableView:(UITableView *)tableView cellHeightWithIndexPatch:(NSIndexPath *)indexPatch;
@end

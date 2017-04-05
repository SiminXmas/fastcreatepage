//
//  XMFCPSection.h
//  fastcreatepage
//
//  Created by xuemin on 2017/3/30.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMFCPItem.h"

@interface XMFCPSection : NSObject

@property (nonatomic, strong) UIView *sectionHeaderView;
@property (nonatomic, assign) CGFloat sectionHeaderHeight; //默认0.01；

@property (nonatomic, strong) UIView *sectionFooterView;
@property (nonatomic, assign) CGFloat sectionFooterHeight; //默认0.01;

@property (nonatomic, strong) NSMutableArray<XMFCPItem *> *items;

@end

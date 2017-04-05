//
//  XMFCPSection.m
//  fastcreatepage
//
//  Created by xuemin on 2017/3/30.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import "XMFCPSection.h"

@implementation XMFCPSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupConfigData];
    }
    return self;
}

- (void)setupConfigData {
    self.sectionHeaderHeight = 10;
}
@end

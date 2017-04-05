//
//  XMSimulationRequest.h
//  fastcreatepage
//
//  Created by xuemin on 2017/3/29.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 我是一个假的异步请求数据
 */
@interface XMSimulationRequest : NSObject


- (void)request:(void(^)(id responseObject))complete failure:(void(^)(NSError *error))failure;
@end

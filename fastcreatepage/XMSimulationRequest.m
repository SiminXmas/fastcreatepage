//
//  XMSimulationRequest.m
//  fastcreatepage
//
//  Created by xuemin on 2017/3/29.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import "XMSimulationRequest.h"

@implementation XMSimulationRequest

- (void)request:(void(^)(id responseObject))complete failure:(void (^)(NSError *))failure {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
//        NSInteger ret = arc4random() % 2;
        NSInteger ret = 0;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (ret == 0) {
                if (complete) {
                    NSDictionary *responseObject = @{
                                                     @"ret": @0,
                                                     @"data": @[
                                                                @{
                                                                     @"title":@"这是一个可怕的title",
                                                                     @"type" : @1
                                                                     },
                                                             
                                                                @{
                                                                     @"subject":@"这是一个可怕的subject",
                                                                     @"type" : @2
                                                                     }
                                                               ],
                                                     @"text" : @"成功"
                                                     };
                    complete(responseObject);
                }
            }
            else {
                if (failure) {
                    NSError *error = [NSError errorWithDomain:@"com.lixuemin" code:ret userInfo:nil];
                    failure(error);
                }
            }
        });
    });
}
@end

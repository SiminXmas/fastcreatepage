//
//  XMFCPTable.h
//  fastcreatepage
//
//  Created by xuemin on 2017/3/29.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>

#import "XMFCPSection.h"


#pragma mark - 下拉刷新
/**
 下拉刷新执行

 @param task 网络请求
 @param sections 请求成功后返回的东西
 */
typedef void(^XMFCPTableRefreshHeaderSuccessBlock)
(
NSURLSessionDataTask *task,
NSArray<XMFCPSection *> * sections
);
/**
 
 下拉刷新执行，处理网络成功但是服务器返回的达不到我们想要的效果
 
 @param task 网络请求
 @param sections 请求成功后返回的东西
 */
typedef void(^XMFCPTableRefreshHeaderErrorBlock)
(
NSURLSessionDataTask *task,
NSArray<XMFCPSection *> * sections
);

/**
 
 下拉刷新执行，处理网络出现故障
 
 @param task 网络请求
 @param error 网络错误
 */
typedef void(^XMFCPTableRefreshHeaderFailureBlock)
(
NSURLSessionDataTask *task,
NSError *error
);



/**
 刷新，外部类设置该方法将请求的处理通过Block返回过来

 @param successBlock 成功执行的
 @param errorBlock 成功请求，但是逻辑不符合正常的
 @param failureBlock 请求故障
 */
typedef void(^XMFCPTableRefreshHeaderBlock)
(
XMFCPTableRefreshHeaderSuccessBlock successBlock,
XMFCPTableRefreshHeaderErrorBlock errorBlock,
XMFCPTableRefreshHeaderFailureBlock failureBlock
);



#pragma mark - 上拉
/**
 下拉刷新执行
 
 @param task 网络请求
 @param sections 请求成功后返回的东西
 */
typedef void(^XMFCPTableLoadMoreFooterSuccessBlock)
(
NSURLSessionDataTask *task,
NSArray<XMFCPSection *> * sections
);
/**
 
 下拉刷新执行，处理网络成功但是服务器返回的达不到我们想要的效果
 
 @param task 网络请求
 @param sections 请求成功后返回的东西
 */
typedef void(^XMFCPTableLoadMoreFooterErrorBlock)
(
NSURLSessionDataTask *task,
NSArray<XMFCPSection *> * sections
);

/**
 
 下拉刷新执行，处理网络出现故障
 
 @param task 网络请求
 @param error 网络错误
 */
typedef void(^XMFCPTableLoadMoreFooterFailureBlock)
(
NSURLSessionDataTask *task,
NSError *error
);



/**
 刷新，外部类设置该方法将请求的处理通过Block返回过来
 
 @param successBlock 成功执行的
 @param errorBlock 成功请求，但是逻辑不符合正常的
 @param failureBlock 请求故障
 */
typedef void(^XMFCPTableLoadMoreFooterBlock)
(
XMFCPTableRefreshHeaderSuccessBlock successBlock,
XMFCPTableRefreshHeaderErrorBlock errorBlock,
XMFCPTableRefreshHeaderFailureBlock failureBlock
);




#pragma mark - XMFCPTable
/**
 Table数据整合
 */
@interface XMFCPTable : NSObject

@property (nonatomic, assign) BOOL isPaging; //是否采用分页

@property (nonatomic, assign) BOOL isAddRefreshHeader; //是否添加刷新头部
@property (nonatomic, assign) BOOL isAddRefreshFooter; //是否添加加载更多脚步


@property (nonatomic, assign) NSString *startItemIdentifie; //TableView index.row = 0的数据id
@property (nonatomic, assign) NSString *endItemIdentifie; //TableView index.row = 最后的数据id

@property (nonatomic, strong) UIView *tableHeaderView; //默认nil, 页眉
@property (nonatomic, strong) UIView *tableFooterView; //默认空白的UIView，页脚


@property (nonatomic, strong) NSMutableArray<XMFCPSection *> * sections; //分段, table的数据源

@property (nonatomic) XMFCPTableRefreshHeaderBlock refreshHeaderBlock;
- (void)setRefreshHeaderBlock:(XMFCPTableRefreshHeaderBlock)refreshHeaderBlock;

@property (nonatomic) XMFCPTableLoadMoreFooterBlock loadMoreFooterBlock;
- (void)setLoadMoreFooterBlock:(XMFCPTableLoadMoreFooterBlock)loadMoreFooterBlock;



/**
 注册Cell

 @param cellClass 将要注册的Cell 类
 @param identifier Cell的标识
 */
- (void)registerTableViewCellClass:(Class)cellClass
   forTableViewWithIdentifier:(NSString *)identifier;


/**
 注册Cell

 @param cellNibName Nib 名字
 @param identifier Cell的标识
 */
- (void)registerTableViewCellNibName:(NSString *)cellNibName
        forTableViewWithIdentifier:(NSString *)identifier;

/**
 获得配置好的 UITableView

 @return UITableView
 */
- (UITableView *)fcp_tableView;

- (void)reloadData;


@end

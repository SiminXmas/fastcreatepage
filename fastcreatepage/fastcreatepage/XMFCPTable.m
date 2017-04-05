//
//  XMFCPTable.m
//  fastcreatepage
//
//  Created by xuemin on 2017/3/29.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import "XMFCPTable.h"
#import "XMFCPItemShowProtocol.h"

#define WEAK_OBJECT(Object) __weak typeof(Object) weakObject = Object

#define WeakObj(o) try{}@finally{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

@interface XMFCPTable ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *fcp_tableView;


@property (nonatomic) XMFCPTableRefreshHeaderSuccessBlock successBlock;
@property (nonatomic) XMFCPTableRefreshHeaderErrorBlock errorBlock;
@property (nonatomic) XMFCPTableRefreshHeaderFailureBlock failureBlock;

@end

@implementation XMFCPTable

#pragma mark - 初始设定

- (instancetype)init
{
    self = [super init];
    if (self) {
        //调用一次初始化
        [self fcp_tableView];
    }
    return self;
}

- (XMFCPTableRefreshHeaderSuccessBlock)successBlock {
    if (_successBlock == nil) {
        WEAK_OBJECT(self);
        
        _successBlock = ^(NSURLSessionDataTask *task, NSArray<XMFCPSection *> * sections) {
            //移除全部数据
            [weakObject.sections removeAllObjects];
            
            //加载数据
            [weakObject.sections addObjectsFromArray:sections ?: @[]];

            [weakObject reloadData];
            
            [weakObject.fcp_tableView.mj_header endRefreshing];
            [weakObject.fcp_tableView.mj_footer endRefreshing];
        };
    }
    
    return _successBlock;
}

- (XMFCPTableRefreshHeaderErrorBlock)errorBlock {
    if (_errorBlock == nil) {
        WEAK_OBJECT(self);
        _errorBlock = ^(NSURLSessionDataTask *task, NSArray<XMFCPSection *> * sections) {
            //提示用户 或者 其他操作
            [weakObject reloadData];
            
            [weakObject.fcp_tableView.mj_header endRefreshing];
            [weakObject.fcp_tableView.mj_footer endRefreshing];
        };
    }
    
    return _errorBlock;
}


- (XMFCPTableRefreshHeaderFailureBlock)failureBlock {
    if (_failureBlock == nil) {
        
        @WeakObj(self);
        _failureBlock = ^(NSURLSessionDataTask *task, NSError *error) {
            @StrongObj(self);
            //当没有数据的时候直接显示网络指示器
            
            //当有数据的时候提示网络错误
            
            [self.fcp_tableView.mj_header endRefreshing];
            [self.fcp_tableView.mj_footer endRefreshing];
        };
    }
    
    return _failureBlock;
}

#pragma mark - 属性变化

- (void)setIsAddRefreshHeader:(BOOL)isAddRefreshHeader {
    [self willChangeValueForKey:@"isAddRefreshHeader"];
    _isAddRefreshHeader = isAddRefreshHeader;
    [self didChangeValueForKey:@"isAddRefreshHeader"];
    
    if (_isAddRefreshHeader == YES) {
        if (_fcp_tableView && _fcp_tableView.mj_header == nil) {
            
            __weak typeof(self) weakSelf = self;
            
            _fcp_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                if (weakSelf.refreshHeaderBlock) {
                    weakSelf.refreshHeaderBlock(weakSelf.successBlock,
                                                weakSelf.errorBlock,
                                                weakSelf.failureBlock);
                }
            }];
        }
    }
    else {
        [_fcp_tableView.mj_header removeFromSuperview];
        _fcp_tableView.mj_header = nil;
    }
}

- (void)setIsAddRefreshFooter:(BOOL)isAddRefreshFooter {
    [self willChangeValueForKey:@"isAddRefreshFooter"];
    _isAddRefreshFooter = isAddRefreshFooter;
    [self didChangeValueForKey:@"isAddRefreshFooter"];
    
    if (_isAddRefreshFooter == YES) {
        if (_fcp_tableView && _fcp_tableView.mj_footer == nil) {
            
            __weak typeof(self) weakSelf = self;
            
            _fcp_tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
                if (weakSelf.loadMoreFooterBlock) {
                    weakSelf.loadMoreFooterBlock(weakSelf.successBlock,
                                                weakSelf.errorBlock,
                                                weakSelf.failureBlock);
                }
            }];
        }
    }
    else {
        [_fcp_tableView.mj_footer removeFromSuperview];
        _fcp_tableView.mj_footer = nil;
    }
}



#pragma mark - TableView

- (NSMutableArray<XMFCPSection *> *)sections {
    if (_sections == nil) {
        _sections = [NSMutableArray array];
    }
    
    return _sections;
}

- (UITableView *)fcp_tableView {
    if (_fcp_tableView == nil) {
        _fcp_tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                      style:UITableViewStylePlain];
        _fcp_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _fcp_tableView.scrollsToTop = YES;
        _fcp_tableView.delegate = self;
        _fcp_tableView.dataSource = self;
    }
    
    return _fcp_tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    NSArray *items = self.sections[section].items;
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = self.sections[indexPath.section].items;
    XMFCPItem *item = items[indexPath.item];
    
    if (item.viewIndentifier) {
        UITableViewCell<XMFCPItemShowProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:item.viewIndentifier];
        [cell showDataWithData:item.dataObject indexPatch:indexPath];
        return cell;
    }
    return [UITableViewCell new];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = self.sections[indexPath.section].items;
    XMFCPItem *item = items[indexPath.item];
    
    if (item.viewIndentifier) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.viewIndentifier];
        if ([cell conformsToProtocol:@protocol(XMFCPItemShowProtocol)]) {
            return [item tableView:tableView
                              cell:(UITableViewCell<XMFCPItemShowProtocol> *)cell
              heightWithIndexPatch:indexPath];
        }
    }
    return 0.f;
}

/**
 注册Cell
 
 @param cellClass 将要注册的Cell 类
 @param identifier Cell的标识
 */
- (void)registerTableViewCellClass:(Class)cellClass
        forTableViewWithIdentifier:(NSString *)identifier {
    [self.fcp_tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}


/**
 注册Cell
 
 @param cellNibName Nib 名字
 @param identifier Cell的标识
 */
- (void)registerTableViewCellNibName:(NSString *)cellNibName
          forTableViewWithIdentifier:(NSString *)identifier {
    UINib *nib = [UINib nibWithNibName:cellNibName bundle:[NSBundle mainBundle]];
    [self.fcp_tableView registerNib:nib forCellReuseIdentifier:identifier];
}

- (void)reloadData {
    [self.fcp_tableView.mj_header endRefreshing];
    [self.fcp_tableView.mj_footer endRefreshing];
    //隐藏整面的加载指示
    
    [self.fcp_tableView reloadData];
}



@end

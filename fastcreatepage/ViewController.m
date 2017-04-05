//
//  ViewController.m
//  fastcreatepage
//
//  Created by xuemin on 2017/3/29.
//  Copyright © 2017年 lixuemin. All rights reserved.
//

#import "ViewController.h"
#import "XMFCPTable.h"
#import "XMSimulationRequest.h"
#import "XMTableViewCell.h"

@interface ViewController ()
@property (nonatomic, strong) XMSimulationRequest *request;
@property (nonatomic, strong) XMFCPTable *fcp_table;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //装载视图
    [self.view addSubview:[self.fcp_table fcp_tableView]];
    CGRect rect = CGRectMake(0,
                             0,
                             [UIScreen mainScreen].bounds.size.width,
                             [UIScreen mainScreen].bounds.size.height);
    
    [[self.fcp_table fcp_tableView] setFrame:rect];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (XMFCPTable *)fcp_table {
    if (_fcp_table == nil) {
        
        __weak typeof(self) weakObject = self;
        
        _fcp_table = [[XMFCPTable alloc] init];
        _fcp_table.isAddRefreshHeader = YES;
        
        //注册Cell
        [_fcp_table registerTableViewCellClass:[XMTableViewCell class]
                    forTableViewWithIdentifier:XMTableViewCellIdentifier];
        
        
        
        //设置头部刷新
        [_fcp_table setRefreshHeaderBlock:
         ^(
            XMFCPTableRefreshHeaderSuccessBlock successBlock,
            XMFCPTableRefreshHeaderErrorBlock errorBlock,
            XMFCPTableRefreshHeaderFailureBlock failureBlock
            )
        {
            
            //请求数据
            [weakObject.request request:^(id responseObject) {
                if ([responseObject[@"ret"] integerValue] == 0) {

                    NSMutableArray<XMFCPItem *> *items = [NSMutableArray array];
                    
                    NSArray *data = responseObject[@"data"];
                    for (NSDictionary *dict in data) {
                        
                        XMFCPItem *item = [[XMFCPItem alloc] init];
                        item.dataObject = dict;
                        item.viewIndentifier = XMTableViewCellIdentifier;
                        [items addObject:item];
                    }
                    
                    NSMutableArray<XMFCPSection *> *sections = [NSMutableArray array];
                    XMFCPSection *section = [[XMFCPSection alloc] init];
                    
                    section.items = items;
                    
                    [sections addObject:section];
                    
                    successBlock(nil, sections);
                }
                else {
                    errorBlock(nil, responseObject);
                }
                
            } failure:^(NSError *error) {
                failureBlock(nil, error);
            }];
        }];
    }
    
    return _fcp_table;
}

- (XMSimulationRequest *)request {
    if (_request == nil) {
        _request = [[XMSimulationRequest alloc] init];
    }
    
    return _request;
}
@end

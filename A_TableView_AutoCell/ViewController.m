//
//  ViewController.m
//  A_TableView_AutoCell
//
//  Created by Zin_戦 on 17/1/9.
//  Copyright © 2017年 Zin_戦. All rights reserved.
//

#import "ViewController.h"
#import "ModelEntity.h"
#import "AutoCell.h"
#import <Masonry.h>
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView      *tableView;
@property(nonatomic, strong) NSMutableArray   *feedEntities;
@property (nonatomic, assign) BOOL cellHeightCacheEnabled;

@end

@implementation ViewController

- (void)buildTestDataThen:(void (^)(void))then
{
    // Simulate an async request
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `FDFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[ModelEntity alloc] initWithDictionary:obj]];
        }];
        self.feedEntities = entities;
        
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellHeightCacheEnabled = YES;
    [self buildTestDataThen:^{
        [self.tableView reloadData];
    }];
    [self tableView];
    [self.tableView registerClass:[AutoCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = 123;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark lazy loading...
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma tableView--delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedEntities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AutoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    cell.model = self.feedEntities[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

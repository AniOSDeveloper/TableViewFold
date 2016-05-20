//
//  SubViewController.m
//  TableViewFold
//
//  Created by 陈舒澳 on 16/5/20.
//  Copyright © 2016年 speeda. All rights reserved.
//

#import "SubViewController.h"
#import "TableViewFold-Swift.h"
#import <objc/runtime.h>
static char * buttonKey = "buttonKey";
@interface subGroupModel : NSObject
@property (nonatomic,assign) BOOL  isOpen;
@property (nonatomic,strong) NSString * groupName;
@property (nonatomic,assign) int  groupCount;
@property (nonatomic,strong) NSArray * groupArray;
@end
@implementation subGroupModel
@end

@interface SubViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"fuzongjian");
    [self initData];
    [self initTableView];
    
    // Do any additional setup after loading the view.
}
- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"PersonCustomCell" bundle:nil] forCellReuseIdentifier:@"PersonCustomCell"];
    [self.view addSubview:_tableView];
}

- (void)initData{
    NSMutableArray * firstArray = [NSMutableArray array];
    NSMutableArray * secondArray = [NSMutableArray array];
    _dataSource = [NSMutableArray array];
    for (int i = 1; i < 15; i ++) {
        NSString * str = [NSString stringWithFormat:@"火影%02d",i];
        if ( i < 6) {
            [firstArray addObject:str];
        }else{
            [secondArray addObject:str];
        }
    }
    
    for ( int i = 0; i < 2; i ++) {
        subGroupModel * model = [[subGroupModel alloc] init];
        model.isOpen = NO;
        if (i == 0) {
            model.groupName = @"小学同学";
            model.groupArray = [NSArray arrayWithArray:firstArray];
            model.groupCount = firstArray.count;
        }else{
            model.groupName = @"大学同学";
            model.groupArray = [NSArray arrayWithArray:secondArray];
            model.groupCount = secondArray.count;
        }
        [_dataSource addObject:model];
    }
    [NSString stringWithFormat:@"%@",_dataSource];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    subGroupModel * model = [_dataSource objectAtIndex:section];
    if (model.isOpen) {
        return model.groupCount;
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCustomCell"];
    if (!cell) {
        cell = [[PersonCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonCustomCell"];
    }
    subGroupModel * model = [_dataSource objectAtIndex: indexPath.section];
    NSString * str = [model.groupArray objectAtIndex:indexPath.row];
    cell.iconImageView.image = [UIImage imageNamed:str];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    sectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
    subGroupModel * model = [_dataSource objectAtIndex:section];
    
    UIButton * sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sectionButton.frame = sectionView.frame;
    [sectionButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [sectionButton setTitle:model.groupName forState:UIControlStateNormal];
    [sectionButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [sectionButton addTarget:self action:@selector(sectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    sectionButton.tag = section;
    [sectionView addSubview:sectionButton];
    
    UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, sectionButton.frame.size.height -1, sectionButton.frame.size.width, 1)];
    lineImageView.image = [UIImage imageNamed:@"line_real"];
    [sectionView addSubview:lineImageView];
    
    if (model.isOpen) {
        UIImageView * smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (44 - 16)/2, 14, 16)];
        smallImageView.image = [UIImage imageNamed:@"ico_list"];
        [sectionView addSubview:smallImageView];
        
        CGAffineTransform currentTransform = smallImageView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2);
        smallImageView.transform = newTransform;
        objc_setAssociatedObject(sectionButton, &buttonKey, smallImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }else{
        UIImageView * smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (44 - 16)/2, 14, 16)];
        smallImageView.image = [UIImage imageNamed:@"ico_list"];
        [sectionView addSubview:smallImageView];
        objc_setAssociatedObject(sectionButton, &buttonKey, smallImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return sectionView;
}
- (void)sectionButtonClicked:(UIButton *)sender{
    subGroupModel * model = [_dataSource objectAtIndex:sender.tag];
    UIImageView * smallImageView = objc_getAssociatedObject(sender, &buttonKey);
    if (model.isOpen) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            CGAffineTransform currentTransform = smallImageView.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, -M_PI/2);
            smallImageView.transform = newTransform;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            CGAffineTransform currentTransform = smallImageView.transform;
            CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, M_PI/2);
            smallImageView.transform = newTransform;
        } completion:^(BOOL finished) {
            
        }];
    }
    model.isOpen = !model.isOpen;
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

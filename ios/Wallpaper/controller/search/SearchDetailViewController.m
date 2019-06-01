//
//  SearchDetailViewController.m
//  WallWrapper ( https://github.com/kysonzhu/wallpaper.git )
//
//  Created by zhujinhui on 14-12-25.
//  Copyright (c) 2014年 zhujinhui( http://kyson.cn ). All rights reserved.
//

#import "SearchDetailViewController.h"
#import "SearchHistoryLayout.h"
#import "WrapperServiceMediator.h"
#import "UIScrollView+MJRefresh.h"
#import "WPRPaperDetailViewController.h"
#import "Group.h"

#define TAG_BTN_NAV_LEFT    8910


static NSString *GridViewCellReuseIdentifier = @"GridViewCellReuseIdentifier";


@interface SearchDetailViewController ()<SearchHistoryLayoutDelegate>{
    UICollectionView *mCollectionView;
    
    UIButton *leftNavigationBarButton;

}

@end

@implementation SearchDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.searchText;
    
    /**
     *  navigation bar left bar button
     */
    UIBarButtonItem *btnItem1 = [[UIBarButtonItem alloc]init];
    leftNavigationBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image1 = [UIImage imageNamed:@"icon_navi_back"];
    [leftNavigationBarButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [leftNavigationBarButton setFrame:CGRectMake(0, 0, 20, 21)];
    [leftNavigationBarButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    leftNavigationBarButton.tag = TAG_BTN_NAV_LEFT;
    [btnItem1 setCustomView:leftNavigationBarButton];
    self.navigationItem.leftBarButtonItem = btnItem1;
    
    SearchHistoryLayout *layout = [[SearchHistoryLayout alloc]initWithDelegate:self];
    
    mCollectionView = [[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    mCollectionView.backgroundColor = [UIColor whiteColor];
    mCollectionView.delegate = layout;
    mCollectionView.dataSource = layout;
    
    UINib *xibFile = [UINib nibWithNibName:@"GridViewCell" bundle:nil];
    [mCollectionView registerNib:xibFile forCellWithReuseIdentifier:GridViewCellReuseIdentifier];
    
    //load more data of recommend collection view
    __block int startRecommended = 0;
    __weak typeof(self) weakSelf = self;
    mCollectionView.mj_footer =  [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        startRecommended = startRecommended + 30;
        NSString *startString = [NSString stringWithFormat:@"%i",startRecommended];
        WrapperServiceMediator *serviceMediator = [[WrapperServiceMediator alloc]initWithName:SERVICENAME_SEARCHGETSEARCHRESULTLIST params:@{@"start":startString,@"word":self.searchText}];
        [weakSelf doNetworkService:serviceMediator];
    }];
    [self.view addSubview:mCollectionView];
    //Do request
    WrapperServiceMediator *serviceMediator = [[WrapperServiceMediator alloc]initWithName:SERVICENAME_SEARCHGETSEARCHRESULTLIST params:@{@"start":@"0",@"word":self.searchText}];
    [self doNetworkService:serviceMediator];
    [KVNProgress show];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)refreshData:(NSString *)serviceName response:(MGNetwokResponse *)response{
    [KVNProgress dismiss];
    if (response.errorCode == 0) {
        if ([serviceName isEqualToString:SERVICENAME_SEARCHGETSEARCHRESULTLIST]) {
            
            NSDictionary *resultDict = response.rawResponseDictionary;
            NSArray *Aryresponse1 = resultDict[@"result"][@"groupList"];
            Group *group = [[Group alloc] init];
            Aryresponse1 = [group loadArrayPropertyWithDataSource:Aryresponse1 requireModel:@"Group"];
            NSMutableArray *Aryresponse = [[NSMutableArray alloc] init];
            for (Group *item in Aryresponse1)
            {
                NSURL *coverUrl = [NSURL URLWithString:item.coverImgUrl];
                if ([coverUrl.scheme isEqualToString:@"http"] || [coverUrl.scheme isEqualToString:@"https"]) {
                    [Aryresponse addObject:item];
                }
            }
            SearchHistoryLayout *layout1 = (SearchHistoryLayout *)mCollectionView.collectionViewLayout;
            NSMutableArray *temAry = [[NSMutableArray alloc]initWithArray:layout1.groupList];
            [temAry addObjectsFromArray:Aryresponse];
            layout1.groupList = temAry;
            [mCollectionView reloadData];
            [mCollectionView .mj_footer endRefreshing];
        }
    }else{
        [KVNProgress showErrorWithStatus:response.errorMessage];
    }
    
}


-(void)searchHistoryLayout:(SearchHistoryLayout *)layout itemDidClicked:(NSIndexPath *)indexPath{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    SearchHistoryLayout *layout1 = (SearchHistoryLayout *)mCollectionView.collectionViewLayout;
    NSArray *groupList = layout1.groupList;
    Group *group = groupList[section *2 +row ];
    WPRPaperDetailViewController *detailViewController = [[WPRPaperDetailViewController alloc]init];
    detailViewController.fromcontroller = FromControllerRecommended;
    detailViewController.group = group;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonClicked:(UIButton *)button{
    switch (button.tag) {
        case TAG_BTN_NAV_LEFT:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end

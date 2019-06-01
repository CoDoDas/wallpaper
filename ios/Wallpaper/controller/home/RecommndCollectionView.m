//
//  RecommndCollectionView.m
//  WallWrapper ( https://github.com/kysonzhu/wallpaper.git )
//
//  Created by zhujinhui on 14-12-22.
//  Copyright (c) 2014年 zhujinhui( http://kyson.cn ). All rights reserved.
//

#import "RecommndCollectionView.h"
#import "WPRPaperDetailViewController.h"
#import "GalleryView.h"
#import "WPBaseViewController.h"

static NSString *GridViewCellReuseIdentifier = @"GridViewCellReuseIdentifier";

@implementation RecommndCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        UINib *xibFile = [UINib nibWithNibName:@"GridViewCell" bundle:nil];
        [self registerNib:xibFile forCellWithReuseIdentifier:GridViewCellReuseIdentifier];
        [self registerClass:[GalleryView class] forCellWithReuseIdentifier:@"kgalleryIdentifier"];
    }
    return self;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WPRPaperDetailViewController *wrapperDetailViewController = [[WPRPaperDetailViewController alloc]init];
    [self.controller.navigationController pushViewController:wrapperDetailViewController animated:YES];
}


@end

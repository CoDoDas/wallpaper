//
//  LatestCollectionViewLayout.m
//  WallWrapper ( https://github.com/kysonzhu/wallpaper.git )
//
//  Created by zhujinhui on 14-12-23.
//  Copyright (c) 2014年 zhujinhui( http://kyson.cn ). All rights reserved.
//

#import "LatestCollectionViewLayout.h"
#import "GridViewCell2.h"
#import "Group.h"
#import "WPRBaby.h"
#import <UIImageView+WebCache.h>

static NSString *GridViewCellReuseIdentifier2 = @"GridViewCellReuseIdentifier2";

@interface LatestCollectionViewLayout (){
    int yesToLoad;
}

@end


@implementation LatestCollectionViewLayout


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    int mod = _groupList.count%2;
    
    int sectionCount = (int)_groupList.count/2;
    if (mod > 0 ) {
        sectionCount++;
        if (section == (sectionCount - 1) ) {
            return mod;
        }
    }
    
    return 2;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    int mod = _groupList.count%2;
    int sectionCount = (int)_groupList.count/2;
    if (mod > 0 ) {
        sectionCount++;
    }
    return sectionCount;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds )/2 - 0.5f;
    return CGSizeMake(width, width / 3.f * 4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(320, 0.5f);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(320, 0.5f);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    Group *group = _groupList[section *2 +row ];
    
    GridViewCell2   *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GridViewCellReuseIdentifier2 forIndexPath:indexPath];
    AutoLoadImageView *imageView = (AutoLoadImageView *)cell.coverImageView;
    imageView.layer.cornerRadius = 2.f;
    imageView.clipsToBounds = YES;
    NSString *imageURLString = group.coverImgUrl;
    if ([group isKindOfClass:[WPRBaby class]]) {
        imageURLString = ((WPRBaby *) group).coverImageUrl;
    }
    NSString *smallURLString = [imageURLString stringByReplacingOccurrencesOfString:@"large" withString:@"bmiddle"];
    NSURL *smallURL = [NSURL URLWithString:smallURLString];
    UIImage *tempImage = [UIImage imageNamed:@"AppIcon"];

    [imageView sd_setImageWithURL:smallURL placeholderImage:tempImage options:SDWebImageLowPriority completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        ;
    }];
    
    //group number
    NSString *picNumString = [NSString stringWithFormat:@"(%i张)",[group.picNum intValue]];
    NSMutableAttributedString *attributePicNumString = [[NSMutableAttributedString alloc]initWithString:picNumString];
    NSDictionary *attriDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:0xc8c8c8],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName, nil];
    NSRange range;
    range.length = [attributePicNumString length];
    range.location = 0;
    [attributePicNumString setAttributes:attriDictionary range:range];
    //group name
    NSString *gName = [NSString stringWithFormat:@"%@",group.gName];
    NSMutableAttributedString *attributeGroupNameString = [[NSMutableAttributedString alloc]initWithString:gName];
    NSDictionary *attriDictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil];
    NSRange range2;
    range2.length = [attributeGroupNameString length];
    range2.location = 0;
    [attributeGroupNameString setAttributes:attriDictionary2 range:range2];
    NSMutableAttributedString *detailString = [[NSMutableAttributedString alloc]initWithAttributedString:attributePicNumString];
    [detailString insertAttributedString:attributeGroupNameString atIndex:0];
    cell.themeNameLabel.attributedText = detailString;
    cell.detailLabel.text = [group.editDate substringToIndex:10];
    return cell;
    
}


-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    yesToLoad ++;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    yesToLoad = 0;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}


@end

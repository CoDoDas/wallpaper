//
//  RecommndCollectionViewLayout.m
//  WallWrapper ( https://github.com/kysonzhu/wallpaper.git )
//
//  Created by zhujinhui on 14-12-22.
//  Copyright (c) 2014年 zhujinhui( http://kyson.cn ). All rights reserved.
//

#import "RecommndCollectionViewLayout.h"
#import "GalleryView.h"
#import "GridViewCell.h"
#import "AutoLoadImageView.h"
#import "UserCenter.h"
#import <CoreText/CoreText.h>
#import <UIImageView+WebCache.h>
#import "WPRBaby.h"

static NSString *GridViewCellReuseIdentifier = @"GridViewCellReuseIdentifier";


@implementation RecommndCollectionViewLayout


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
    WPRBaby *baby = _groupList[section *2 +row ];
    
    GridViewCell   *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GridViewCellReuseIdentifier forIndexPath:indexPath];
    AutoLoadImageView *imageView = (AutoLoadImageView *)cell.coverImageView;
    imageView.layer.cornerRadius = 2.f;
    imageView.clipsToBounds = YES;

    NSString *imageURLString = baby.coverImageUrl;
    NSString *smallURLString = [imageURLString stringByReplacingOccurrencesOfString:@"large" withString:@"bmiddle"];
    NSURL *smallURL = [NSURL URLWithString:smallURLString];
    UIImage *tempImage = [UIImage imageNamed:@"AppIcon"];
    [imageView sd_setImageWithURL:smallURL placeholderImage:tempImage options:SDWebImageLowPriority completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        ;
    }];
    
    //group number
//    NSString *picNumString = [NSString stringWithFormat:@"(%i张)",[group.picNum intValue]];
    NSMutableAttributedString *attributePicNumString = [[NSMutableAttributedString alloc]initWithString:@""];
    NSDictionary *attriDictionary = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHex:0xc8c8c8],NSForegroundColorAttributeName,[UIFont systemFontOfSize:10],NSFontAttributeName, nil];
    NSRange range;
    range.length = [attributePicNumString length];
    range.location = 0;
    [attributePicNumString setAttributes:attriDictionary range:range];
        return cell;
}

@end

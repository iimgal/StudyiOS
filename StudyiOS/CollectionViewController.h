//
//  CollectionViewController.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-13.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : BaseViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *items;

@end

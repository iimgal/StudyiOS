//
//  FlowViewCell.h
//  StudyiOS
//
//  Created by ZhangYiCheng on 12-12-6.
//  Copyright (c) 2012年 ZhangYiCheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FlowViewCellDelegate;


@interface FlowViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIImageView *flowImageView;
@property (strong, nonatomic) IBOutlet UILabel *flowTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *flowFromLabel;
@property (strong, nonatomic) IBOutlet UIButton *flowFancyButton;
@property (strong, nonatomic) IBOutlet UIButton *flowAddButton;
@property (strong, nonatomic) IBOutlet UIButton *flowCommentButton;
@property (strong, nonatomic) NSString *demoUUID;
@property (assign, nonatomic) id <FlowViewCellDelegate> flowViewCellDelegate;

+ (CGFloat)heightForCell:(NSDictionary *)dic;

- (void)setCell:(NSDictionary *)dic;

- (IBAction)fancied:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)comment:(id)sender;

@end

@protocol FlowViewCellDelegate <NSObject>

- (void)flowViewCell:(FlowViewCell *)cell startDemo:(NSString *)demoUUID;

@end

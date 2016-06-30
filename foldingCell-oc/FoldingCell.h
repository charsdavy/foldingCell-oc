//
//  FoldingCell.h
//  foldingCell-oc
//
//  Created by chars on 16/6/28.
//  Copyright © 2016年 chars. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 Folding animation types
 
 - FCAnimationOpen:  Open direction
 - FCAnimationClose: Close direction
 */
typedef NS_ENUM (NSInteger,  FCAnimationType) {
    FCAnimationOpen,
    FCAnimationClose
};

typedef void (^animationCompletion)(NSError *error);
typedef void (^foldTapHandler)();

@interface RotatedView : UIView

@property (nonatomic) RotatedView *backView;

- (void)addBackViewHeight:(CGFloat)height color:(UIColor *)color;

-(void)foldingAnimation:(NSString *)timing from:(CGFloat)from to:(CGFloat)to delay:(NSTimeInterval)delay  duration:(NSTimeInterval)durtion hidden:(BOOL)hidden;

@end

@interface FoldingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet RotatedView *foregroundView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foregroundTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UIImageView *foldTestImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (BOOL)isAnimating;
- (CGFloat)returnSumTime;
- (void)fold_imageTap:(foldTapHandler)handler;

/** Open or close cell */
- (void)selectedAnimation:(BOOL)selected animation:(BOOL)animated completion:(animationCompletion)completion;

@end

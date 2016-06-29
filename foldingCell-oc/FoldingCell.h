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

@interface FoldingCell : UITableViewCell

/** Open or close cell */
- (void)selectedAnimation:(BOOL)selected animation:(BOOL)animated completion:(animationCompletion)completion;

@end

@interface RotatedView : UIView

- (void)addBackView:(CGFloat)height color:(UIColor *)color;

-(void)foldingAnimation:(NSString *)timing from:(CGFloat)from to:(CGFloat)to delay:(NSTimeInterval)delay  duration:(NSTimeInterval)durtion hidden:(BOOL)hidden;

@end

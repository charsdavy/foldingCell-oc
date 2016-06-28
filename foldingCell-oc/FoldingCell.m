//
//  FoldingCell.m
//  foldingCell-oc
//
//  Created by chars on 16/6/28.
//  Copyright © 2016年 chars. All rights reserved.
//

#import "FoldingCell.h"

@interface FoldingCell ()

@property (nonatomic) UIView *containerView;
@property (nonatomic) NSLayoutConstraint *containerViewTop;

@end

@implementation FoldingCell

- (void)closeAnimation:(animationCompletion)completion
{
    
}

- (void)openAnimation:(animationCompletion)completion
{
    
}

/**
 Open or close cell
 
 - parameter selected: Specify true if you want to open cell or false if you close cell.
 - parameter animated: Specify true if you want to animate the change in visibility or false if you want immediately.
 - parameter completion: A block object to be executed when the animation sequence ends.
 */
- (void)selectedAnimation:(BOOL)selected animation:(BOOL)animated completion:(animationCompletion)completion
{
    if (selected) {
        if (animated) {
            self.containerView.alpha = 0;
            [self openAnimation:completion];
        } else {
            self.containerView.alpha = 1;
        }
    } else {
        if (animated) {
            [self closeAnimation:completion];
        } else {
            self.containerView.alpha = 0;
        }
    }
}

@end

@implementation RotatedView

- (void)rotatedX:(CGFloat)angle
{
    CATransform3D allTransofrom = CATransform3DIdentity;
    CATransform3D rotateTransform = CATransform3DMakeRotation(angle, 1, 0, 0);
    allTransofrom = CATransform3DConcat(allTransofrom, rotateTransform);
    allTransofrom = CATransform3DConcat(allTransofrom, [self transform3d]);
    self.layer.transform = allTransofrom;
}

- (CATransform3D)transform3d
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 2.5 / -2000;
    return transform;
}

@end

@implementation RotatedView (Folding)



@end

@implementation UIView (Snapshot)



@end

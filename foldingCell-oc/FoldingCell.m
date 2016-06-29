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

@interface RotatedView ()

@property (nonatomic) RotatedView *backView;
@property (nonatomic, assign) BOOL hiddenAfterAnimation;

@end

@implementation RotatedView

- (void)awakeFromNib
{
    _hiddenAfterAnimation = NO;
}

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

- (void)addBackView:(CGFloat)height color:(UIColor *)color
{
    RotatedView *view = [[RotatedView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = color;
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    view.layer.transform = [self transform3d];
    view.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self addSubview:view];
    self.backView = view;
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:height]];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:self.bounds.size.height - height + height / 2];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0];
    
    [self addConstraints:@[top, leading, trailing]];
}

-(void)foldingAnimation:(NSString *)timing from:(CGFloat)from to:(CGFloat)to delay:(NSTimeInterval)delay  duration:(NSTimeInterval)durtion hidden:(BOOL)hidden
{
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    
    rotateAnimation.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:from];
    rotateAnimation.toValue = [NSNumber numberWithFloat:to];
    rotateAnimation.duration = durtion;
    rotateAnimation.delegate = self;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = FALSE;
    rotateAnimation.beginTime = CACurrentMediaTime() + delay;
    
    _hiddenAfterAnimation = hidden;
    
    [self.layer addAnimation:rotateAnimation forKey:@"rotation.x"];
}

#pragma mark - override

- (void)animationDidStart:(CAAnimation *)anim
{
    self.layer.shouldRasterize = YES;
    self.alpha = 1;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_hiddenAfterAnimation) {
        self.alpha = 0;
    }
    [self.layer removeAllAnimations];
    self.layer.shouldRasterize = NO;
}

@end

//
//  UIButton+Rotate.m
//  rotate
//
//  Created by Edgar G @hunk on 06/01/12.
//  hunk.com.mx
//  based on this article: Rotate an Image or Button with Animation – Part 2  http://bit.ly/zlfREJ
//

#import "UIButton+Rotate.h"
#import "QuartzCore/QuartzCore.h"
#import "QuartzCore/CAAnimation.h"

@implementation UIButton (ButtonRotate)

- (void)spinButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction{
    
    CABasicAnimation* rotationAnimation;
    
    // Rotate about the z axis
    rotationAnimation = 
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    // Rotate 360 degress, in direction specified
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * direction];
    
    // Perform the rotation over this many seconds
    rotationAnimation.duration = inDuration;
    
    // Set the pacing of the animation
    rotationAnimation.timingFunction = 
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // Add animation to the layer and make it so
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimationUIButton"];
    
}

@end

//
//  UIButton+Rotate.h
//  rotate
//
//  Created by Edgar G @hunk on 06/01/12.
//  hunk.com.mx
//  based on this article: Rotate an Image or Button with Animation – Part 2  http://bit.ly/zlfREJ
//

#import <Foundation/Foundation.h>

@interface UIButton (ButtonRotate)
- (void)spinButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction;

- (void)spinInfinityButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction;
- (void)stopSpinInfinityButton;
@end

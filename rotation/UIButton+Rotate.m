//
//  UIButton+Rotate.m
//  rotate
//
//  Created by Edgar G @hunk on 06/01/12.
//  hunk.com.mx
//  based on this article: Rotate an Image or Button with Animation – Part 2  http://bit.ly/zlfREJ
//

static char initialtimeKeyButton;
static char timeLapKeyButton;
static char directionKeyButton;

#import "UIButton+Rotate.h"
#import <objc/runtime.h>
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

- (void)spinInfinityButtonWithTime:(CFTimeInterval)inDuration direction:(int)direction{

    CABasicAnimation* rotationAnimation;
    
    rotationAnimation = 
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * direction];
    rotationAnimation.duration = inDuration;
    rotationAnimation.repeatCount=INFINITY;
    rotationAnimation.timingFunction = 
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
	
	//set associations
	CFTimeInterval aniPause =  CACurrentMediaTime();
	NSString *initialTime = [NSString stringWithFormat:@"%f",aniPause];
	objc_setAssociatedObject (self,&initialtimeKeyButton,initialTime,OBJC_ASSOCIATION_RETAIN);
	
	NSString *timeLap = [NSString stringWithFormat:@"%f",inDuration];
	objc_setAssociatedObject (self,&timeLapKeyButton,timeLap,OBJC_ASSOCIATION_RETAIN);
	
	NSNumber *spinDirection = [NSNumber numberWithInt:direction];
	objc_setAssociatedObject (self,&directionKeyButton,spinDirection,OBJC_ASSOCIATION_RETAIN);
    
}

- (void)stopSpinInfinityButton{

	//get associations
	float initialTime = [(NSString*)objc_getAssociatedObject(self, &initialtimeKeyButton) floatValue];
	float timeLap = [(NSString*)objc_getAssociatedObject(self, &timeLapKeyButton) floatValue];
	NSNumber *directionSpin = (NSNumber*)objc_getAssociatedObject(self, &directionKeyButton);
	//remove all associations
	objc_setAssociatedObject(self,&initialtimeKeyButton,nil,OBJC_ASSOCIATION_RETAIN);
	objc_setAssociatedObject(self,&timeLapKeyButton,nil,OBJC_ASSOCIATION_RETAIN);
	objc_setAssociatedObject(self,&directionKeyButton,nil,OBJC_ASSOCIATION_RETAIN);
	
	//remove the current rotation
	CALayer *pLayer = [self.layer presentationLayer];
    [self.layer removeAnimationForKey:@"rotationAnimation"];
    
	//calculating time remaining
    CFTimeInterval aniPause =  CACurrentMediaTime();
    float diffTime = aniPause - initialTime;
    int totalLaps = (int)(diffTime/timeLap);
    float restTime = timeLap - (diffTime - (timeLap * totalLaps));
    
	CABasicAnimation* rotationAnimation;
    rotationAnimation = 
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.fromValue = [pLayer valueForKeyPath:@"transform.rotation.z"];
    NSNumber *currentPositionZ = [pLayer valueForKeyPath:@"transform.rotation.z"];

	if ([directionSpin intValue] == -1) {		
		if ([currentPositionZ floatValue] >= 0) 
			rotationAnimation.toValue = 0;
        else
			rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * [directionSpin intValue] ];
	}else {
		if ([currentPositionZ floatValue] <= 0) 
			rotationAnimation.toValue = 0;
        else
			rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 * [directionSpin intValue]];
	}
    rotationAnimation.duration = restTime;
    rotationAnimation.timingFunction = 
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
	
}

@end

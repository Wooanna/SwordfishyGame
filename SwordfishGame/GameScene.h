#import <SpriteKit/SpriteKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GameScene
: SKScene <UIGestureRecognizerDelegate, SKPhysicsContactDelegate> {
    
    UISwipeGestureRecognizer *swipeLeftGesture;
        
    UISwipeGestureRecognizer *swipeRightGesture;
    
    UIRotationGestureRecognizer *rotationGesture;
    
    UILongPressGestureRecognizer *longPresGesture;
    
    UIPinchGestureRecognizer* pinchGesture;
    
    SKLabelNode *scoreLabel;
    
    int score;
    
    SKScene* parentScene;
}

@property(strong, nonatomic, readonly) SKScene *returnScene;

- (void)setReturnScene:(SKScene *)returnScene;
@end

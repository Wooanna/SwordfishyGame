#import <SpriteKit/SpriteKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface GameScene
: SKScene <UIGestureRecognizerDelegate, SKPhysicsContactDelegate> {
    
    UISwipeGestureRecognizer *swipeLeftGesture;
        
    UISwipeGestureRecognizer *swipeRightGesture;
    
    UIRotationGestureRecognizer *rotationGesture;
    
    UILongPressGestureRecognizer *longPresGesture;
    
    SKLabelNode *scoreLabel;
    
    int score;
}

@end

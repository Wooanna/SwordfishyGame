//
//  PausedScene.m
//  SwordfishGame
//
//  Created by admin on 11/5/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "PausedScene.h"
#import "BubbleMaker.h"

@implementation PausedScene {
  SKSpriteNode *_backLayer;
  SKLabelNode *_gamePaused;
  SKLabelNode *_catchABubble;
  
    BubbleMaker *_bubbleMaker;
  
}
- (id)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {
      
      
      
      _bubbleMaker = [[BubbleMaker alloc]initWithParentScene:self];
      [_bubbleMaker generateBubbles];
    _backLayer = [SKSpriteNode spriteNodeWithImageNamed:@"menu_back.png"];
    _backLayer.position =
        CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _backLayer.zPosition = 30;
    _gamePaused = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _gamePaused.text = @"GAME PAUSED";
    _gamePaused.fontSize = 40;
    _gamePaused.fontColor = [UIColor blueColor];
    _gamePaused.position =
        CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _gamePaused.zPosition = 40;

    _catchABubble = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _catchABubble.text = @"Long press to resume your game";
    _catchABubble.fontSize = 40;
    _catchABubble.fontColor = [UIColor blueColor];
    _catchABubble.position =
        CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 - 80);
    _catchABubble.zPosition = 40;
        [self addChild:_backLayer];
    [self addChild:_gamePaused];
    [self addChild:_catchABubble];
  }
  return self;
}

-(void)didMoveToView:(SKView *)view{
    longPressGesture = [[UILongPressGestureRecognizer alloc]
                        initWithTarget:self
                        action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:longPressGesture];

}

- (void)update:(NSTimeInterval)currentTime {
  if (arc4random_uniform(100) > 5) {
    [_bubbleMaker generateBubbles];
  }

  for (SKSpriteNode *bubble in self.children) {

    if (bubble.position.y == self.size.height) {

      [bubble removeFromParent];
    }
  }
}

- (void)setReturnScene:(SKScene *)returnScene {
  _returnScene = returnScene;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)recognizer{
    __weak typeof(self) weakMe = self;
    
    [weakMe.view presentScene:_returnScene];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

//  UITouch *touch = [touches anyObject];
//  CGPoint location = [touch locationInNode:self.scene];
//  if (CGRectContainsPoint(self.frame, location)) {
//   
//  }
}

@end

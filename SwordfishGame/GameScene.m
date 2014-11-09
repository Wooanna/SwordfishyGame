#import "GameScene.h"
#import "QuestionScene.h"
#import "PausedScene.h"
#import "AtlasImagesExtractor.h"
#import "FishMaker.h"
#import "GameOverScene.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation GameScene {

  SKSpriteNode *_backLayer;
  SKTexture *_backTexture;
  SKSpriteNode *_sharky;
  PausedScene *_pausedScene;
  QuestionScene *qScene;
  AtlasImagesExtractor *extractor;
  FishMaker *fishMaker;
  SKLabelNode *_pinchOutToPouse;
  SKAction *_fadeOut;
  SKAction *_fadeIn;
  SKAction *_fadeInfadeOut;
}

static const uint32_t fishyCategory = 0x1 << 0;
static const uint32_t fishCategory = 0x1 << 2;
static const uint32_t questionCategory = 0x1 << 3;

// initialize and setup everything about out player our player
- (void)InitializeSharky {

  NSMutableArray *sharkyTextures = [NSMutableArray array];
  sharkyTextures = [extractor ExtractImagesFromAtlasNamed:@"sharky"];
  SKAction *move =
      [SKAction animateWithTextures:sharkyTextures timePerFrame:0.3];
  SKAction *keepMovingForever = [SKAction repeatActionForever:move];

  _sharky = [SKSpriteNode spriteNodeWithImageNamed:@"sharky1.png"];
  _sharky.xScale = 0.5;
  _sharky.yScale = 0.5;
  _sharky.anchorPoint = CGPointMake(0, 0.5);
  _sharky.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:2];
  _sharky.physicsBody.mass = 0.1;
  _sharky.physicsBody.linearDamping = 3;
  _sharky.position = CGPointMake(self.size.width / 2, self.size.height / 2);
  [_sharky.physicsBody setCategoryBitMask:fishyCategory];
  _sharky.name = @"sharky";
  [_sharky.physicsBody setContactTestBitMask:fishCategory | questionCategory];

  _sharky.physicsBody.friction = 0;
  [_sharky runAction:keepMovingForever];
  [self addChild:_sharky];
}

- (instancetype)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {

    self.physicsWorld.gravity = CGVectorMake(0, -5);
    self.physicsWorld.contactDelegate = self;
    self.backgroundColor = [SKColor greenColor];
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    extractor = [[AtlasImagesExtractor alloc] init];
    fishMaker = [[FishMaker alloc] initWithParentScene:self];
    _pausedScene = [PausedScene sceneWithSize:self.size];

    [self performSelector:@selector(setScene) withObject:nil afterDelay:0.01];

    _backTexture = [SKTexture textureWithImageNamed:@"game_back.png"];
    _backLayer = [SKSpriteNode spriteNodeWithTexture:_backTexture];
    _backLayer.position =
        CGPointMake(self.size.width / 2, self.size.height / 2);
    _backLayer.zPosition = -10;

    _fadeOut = [SKAction fadeAlphaTo:0.0 duration:2];
    _fadeIn = [SKAction fadeAlphaTo:1 duration:2];
    _fadeInfadeOut = [SKAction sequence:@[ _fadeIn, _fadeOut ]];
    _pinchOutToPouse = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    _pinchOutToPouse.text = @"Pinch out to pause the game";
    _pinchOutToPouse.position = CGPointMake(
    self.size.width / 2, self.size.height - scoreLabel.frame.size.height -
                                 _pinchOutToPouse.frame.size.height - 40);
    _pinchOutToPouse.fontSize = 40;
    _pinchOutToPouse.zPosition = 20;
    _pinchOutToPouse.alpha = 0.1;
    [_pinchOutToPouse runAction:_fadeInfadeOut];

    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text = [NSString stringWithFormat:@"SCORE: %d", score];
    scoreLabel.position = CGPointMake(
        self.size.width / 2, self.size.height - scoreLabel.frame.size.height);
    scoreLabel.fontSize = 40;
    scoreLabel.zPosition = 20;
    [self addChild:scoreLabel];
    [self addChild:_backLayer];
    [self addChild:_pinchOutToPouse];

    [self InitializeSharky];
  }
  return self;
}

- (void)didMoveToView:(SKView *)view {

  // init all gestures
  swipeLeftGesture = [[UISwipeGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(handleSwipeLeft:)];
  [swipeLeftGesture setDirection:UISwipeGestureRecognizerDirectionLeft];

  swipeRightGesture = [[UISwipeGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(handleSwipeRight:)];
  [swipeRightGesture setDirection:UISwipeGestureRecognizerDirectionRight];

  pinchGesture =
      [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handlePinch:)];

  longPresGesture = [[UILongPressGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(handleLongPress:)];

  [self.view addGestureRecognizer:pinchGesture];
  [self.view addGestureRecognizer:swipeLeftGesture];
  [self.view addGestureRecognizer:swipeRightGesture];
  [self.view addGestureRecognizer:longPresGesture];
}

- (void)update:(NSTimeInterval)currentTime {
  // random generating of objects
  // that pop-out from the left side of the scene
  if (arc4random() % 100 < 10) {
    [fishMaker generateFish];
  }
  // remove objects that are out of the scene's range
  for (SKSpriteNode *node in self.children) {
    if ((node.position.x > self.frame.size.width - 80 || node.position.y < 0) &&
        node != _sharky) {
      [node removeFromParent];
    }
  }

  // updatescore
  scoreLabel.text = [NSString stringWithFormat:@"SCORE: %d", score];
}

- (void)setReturnScene:(SKScene *)returnScene {
  _returnScene = returnScene;
}

// GESTURES
- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer {

  [_sharky.physicsBody applyImpulse:CGVectorMake(-70, 0)];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer {

  [_sharky.physicsBody applyImpulse:CGVectorMake(170, 0)];
}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {

    SKTransition *transition = [SKTransition fadeWithDuration:0.5];
    
    [self performSelector:@selector(pauseGame) withObject:nil afterDelay:1];
    
    [self.view presentScene:_pausedScene transition:transition];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
  }

- (void)setScene {
  [_pausedScene setReturnScene:self];
}
- (void)pauseGame {
  self.scene.view.paused = YES;
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
  SKPhysicsBody *firstBody, *secondBody;
  if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {

    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
  }

  if (contact.bodyB.categoryBitMask == fishCategory) {
    score += 10;
    [self runAction:[SKAction playSoundFileNamed:@"bite.wav"
                               waitForCompletion:NO]];
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
      AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);

    [secondBody.node removeFromParent];
  }
  if (contact.bodyB.categoryBitMask == questionCategory) {

      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
      AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);

    SKTexture *texture = [SKTexture textureWithImageNamed:@"papirus.png"];
    CGSize sceneSize =
        CGSizeMake(self.size.width - 200, self.size.height - 100);
    qScene = [QuestionScene spriteNodeWithTexture:texture size:sceneSize];
    qScene.zPosition = 50;
    qScene.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [secondBody.node removeFromParent];
    [qScene initQuestionNode];
    [self addChild:qScene];
    self.scene.view.paused = YES;
        }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [_sharky.physicsBody applyImpulse:CGVectorMake(0, 100)];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInNode:qScene];

  if (CGRectContainsPoint([qScene getAnswerOneFrame], location)) {
    [self validateAnswerWithRightAnswer:[qScene getRightAnswer]
                        andChosenAnswer:@1];

  } else if (CGRectContainsPoint([qScene getAnswerTwoFrame], location)) {
    [self validateAnswerWithRightAnswer:[qScene getRightAnswer]
                        andChosenAnswer:@2];

  } else if (CGRectContainsPoint([qScene getAnswerTreeFrame], location)) {
    [self validateAnswerWithRightAnswer:[qScene getRightAnswer]
                        andChosenAnswer:@3];
  }
}

- (void)validateAnswerWithRightAnswer:(NSNumber *)rightAnswer
                      andChosenAnswer:(NSNumber *)chosenAnswer {

  if (rightAnswer == chosenAnswer) {

    [qScene removeFromParent];
    self.scene.view.paused = NO;
    [self runAction:[SKAction playSoundFileNamed:@"correct.wav"
                               waitForCompletion:YES]];

  } else {

    GameOverScene *gameOverScene =
        [[GameOverScene alloc] initWithSize:self.size andScore:score];
    [self.view presentScene:gameOverScene];
  }
}

@end

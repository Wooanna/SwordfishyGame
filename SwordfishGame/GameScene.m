#import "GameScene.h"

#import "PausedScene.h"

@implementation GameScene {

  SKSpriteNode *_backLayer;
  SKTexture *_backTexture;
  SKSpriteNode *_sharky;
  
}

static const uint32_t fishyCategory = 0x1 << 0;
static const uint32_t shipCategory = 0x1 << 1;
static const uint32_t fishCategory = 0x1 << 2;
static const uint32_t questionCategory = 0x1 << 3;
static const uint32_t frameCategory = 0x1 << 4;

- (NSMutableArray *)ExtractImagesFromAtlas:(SKTextureAtlas *)atlas {
  NSArray *fishyImageNames = [atlas textureNames];

  NSArray *sortedNames = [fishyImageNames
      sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

  NSMutableArray *textures = [NSMutableArray array];

  for (NSString *filename in sortedNames) {
    SKTexture *texture = [atlas textureNamed:filename];
    [textures addObject:texture];
  }
  return textures;
}
    // initialize and setup everything about out player our player
- (void)InitializeSharky {
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"sharky"];
  NSMutableArray *sharkyTextures;
  sharkyTextures = [self ExtractImagesFromAtlas:atlas];

  SKAction *move =
      [SKAction animateWithTextures:sharkyTextures timePerFrame:0.3];
  SKAction *keepMovingForever = [SKAction repeatActionForever:move];

  _sharky = [SKSpriteNode spriteNodeWithImageNamed:@"sharky1.png"];
  _sharky.xScale = 0.5;
  _sharky.yScale = 0.5;
  _sharky.physicsBody =
      [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 20)
                                      center:CGPointMake(0, -80)];
  _sharky.physicsBody.mass = 0.1;
  _sharky.physicsBody.linearDamping = 3;
  _sharky.position = CGPointMake(self.size.width / 2, self.size.height / 2);
  _sharky.physicsBody.categoryBitMask = fishyCategory;
  _sharky.physicsBody.contactTestBitMask = fishCategory;
  _sharky.physicsBody.friction = 0;
  [_sharky runAction:keepMovingForever];
  [self addChild:_sharky];
}

- (instancetype)initWithSize:(CGSize)size {
  if (self = [super initWithSize:size]) {

    self.physicsWorld.gravity = CGVectorMake(0, -5);
    self.physicsWorld.contactDelegate = self;
    self.backgroundColor = [SKColor greenColor];
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:60];
    self.physicsBody.categoryBitMask = frameCategory;

    _backTexture = [SKTexture textureWithImageNamed:@"game_back.png"];
    _backLayer = [SKSpriteNode spriteNodeWithTexture:_backTexture];
    _backLayer.position =
        CGPointMake(self.size.width / 2, self.size.height / 2);
    _backLayer.zPosition = -10;

      
      scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
      scoreLabel.text = [NSString stringWithFormat:@"SCORE: %d", score];
      scoreLabel.position = CGPointMake(self.size.width/2,self.size.height - scoreLabel.frame.size.height);
      scoreLabel.fontSize = 40;
      scoreLabel.zPosition = 20;
      [self addChild:scoreLabel];
      [self addChild:_backLayer];

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

  rotationGesture = [[UIRotationGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(handleRotation:)];

  longPresGesture = [[UILongPressGestureRecognizer alloc]
      initWithTarget:self
              action:@selector(handleLongPress:)];

  [self.view addGestureRecognizer:rotationGesture];
  [self.view addGestureRecognizer:swipeLeftGesture];
  [self.view addGestureRecognizer:swipeRightGesture];
  [self.view addGestureRecognizer:longPresGesture];
}

- (void)update:(NSTimeInterval)currentTime {
    //random generating of objects
    //that pop-out from the left side of the scene
  if (arc4random() % 100 < 1) {
    [self generateFish];
  }
    //remove objects that are out of the scene's range
  for (SKSpriteNode *node in self.children) {
    if ((node.position.x > self.frame.size.width - 80 || node.position.y < 0) &&
        node != _sharky) {
      [node removeFromParent];
    }
  }
    
    //updatescore
    scoreLabel.text = [NSString stringWithFormat:@"SCORE: %d", score];
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer {

  [_sharky.physicsBody applyImpulse:CGVectorMake(-70, 0)];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer {

  [_sharky.physicsBody applyImpulse:CGVectorMake(170, 0)];
}

- (void)handleRotation:(UIRotationGestureRecognizer *)recognizer {
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
  SKTransition *transition = [SKTransition fadeWithDuration:.5];
  PausedScene *pausedScene = [PausedScene sceneWithSize:self.size];
  [self.view presentScene:pausedScene transition:transition];
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
  SKPhysicsBody *firstBody, *secondBody;
  if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {

    firstBody = contact.bodyA;
    secondBody = contact.bodyB;
  }

  if (contact.bodyA.categoryBitMask == fishyCategory) {
      score += 10;
    [secondBody.node removeFromParent];
  }
}

//method that generate and setup the current object
//poping out from the left side of the scene
- (void)generateFish {

  int bodyRadius = arc4random_uniform(20) + 5;
  CGFloat fishPosition =
      arc4random_uniform(self.frame.size.height - bodyRadius * 2);
  SKAction *moveBubble = [SKAction moveByX:self.frame.size.width
                                         y:0
                                  duration:arc4random_uniform(5)];

  SKTextureAtlas *fishesAtlas = [SKTextureAtlas atlasNamed:@"fishes"];
  NSMutableArray *fishesTextures = [self ExtractImagesFromAtlas:fishesAtlas];

  SKSpriteNode *fish =
      [SKSpriteNode spriteNodeWithTexture:fishesTextures[arc4random_uniform(
                                              fishesTextures.count - 1)]];
  fish.xScale = 0.2;
  fish.yScale = 0.2;
  fish.physicsBody.categoryBitMask = fishCategory;
  fish.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:fish.size.width / 2];

  fish.physicsBody.affectedByGravity = NO;
  fish.position = CGPointMake(0, fishPosition);
  [fish runAction:moveBubble];
  [self addChild:fish];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [_sharky.physicsBody applyImpulse:CGVectorMake(0, 100)];
  UITouch *touch = [touches anyObject];
  // CGPoint location = [touch locationInNode:self.scene];
}

@end

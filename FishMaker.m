
#import "FishMaker.h"
#import "AtlasImagesExtractor.h"

@implementation FishMaker {
  AtlasImagesExtractor *extractor;
}

static const uint32_t fishCategory = 0x1 << 2;
static const uint32_t questionCategory = 0x1 << 3;

- (id)initWithParentScene:(SKScene *)scene {
  if (self = [super init]) {
    _parentScene = scene;
    extractor = [[AtlasImagesExtractor alloc] init];
  }
  return self;
}

- (void)generateFish {

  int bodyRadius = arc4random_uniform(20) + 5;
  CGFloat fishPosition =
      arc4random_uniform(_parentScene.frame.size.height - bodyRadius * 2);
  SKAction *moveBubble = [SKAction moveByX:_parentScene.frame.size.width
                                         y:0
                                  duration:arc4random_uniform(5)];
  NSMutableArray *fishesTextures =
      [extractor ExtractImagesFromAtlasNamed:@"fishes"];
  SKSpriteNode *fish;
  SKSpriteNode *questionFish;
  int texture = arc4random_uniform((uint32_t)fishesTextures.count);
  NSLog(@"%d", texture);
  if (texture == 2) {
    questionFish = [SKSpriteNode spriteNodeWithTexture:fishesTextures[2]];
    questionFish.physicsBody =
        [SKPhysicsBody bodyWithCircleOfRadius:questionFish.size.width / 2];

    questionFish.physicsBody.affectedByGravity = NO;
    questionFish.position = CGPointMake(0, fishPosition);
    questionFish.physicsBody.categoryBitMask = questionCategory;
    [questionFish runAction:moveBubble];
    [_parentScene addChild:questionFish];
  } else {
    fish = [SKSpriteNode spriteNodeWithTexture:fishesTextures[texture]];
    fish.xScale = 0.2;
    fish.yScale = 0.2;
    fish.physicsBody =
        [SKPhysicsBody bodyWithCircleOfRadius:fish.size.width / 2];
    fish.physicsBody.affectedByGravity = NO;
    fish.position = CGPointMake(0, fishPosition);
    fish.physicsBody.categoryBitMask = fishCategory;
    [fish runAction:moveBubble];
    [_parentScene addChild:fish];
  }
}

@end

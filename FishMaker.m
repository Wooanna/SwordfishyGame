
#import "FishMaker.h"
#import "AtlasImagesExtractor.h"

@implementation FishMaker {
  
    SKSpriteNode* _fish;
    SKSpriteNode* _questionFish;
    AtlasImagesExtractor* _extractor;
    NSMutableArray* _fishesTextures;

}

static const uint32_t fishCategory = 0x1 << 2;
static const uint32_t questionCategory = 0x1 << 3;

- (id)initWithParentScene:(SKScene *)scene {
  if (self = [super init]) {
    _parentScene = scene;
    _extractor = [AtlasImagesExtractor new];
    _fishesTextures = [_extractor ExtractImagesFromAtlasNamed:@"fishes"];
  }
  return self;
}

- (void)generateFish {

  int bodyRadius = arc4random_uniform(20) + 5;
  CGFloat fishPosition = arc4random_uniform(_parentScene.frame.size.height - bodyRadius * 2);
  SKAction *moveFish = [SKAction moveByX:_parentScene.frame.size.width y:0 duration:arc4random_uniform(5)];
  int textureIndex = arc4random_uniform((int)_fishesTextures.count);
    
  if (textureIndex == 2) {
      //we have a bad fish
    _questionFish = [SKSpriteNode spriteNodeWithTexture:_fishesTextures[2]];
    _questionFish.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_questionFish.size.width / 2];
    _questionFish.physicsBody.affectedByGravity = NO;
    _questionFish.position = CGPointMake(0, fishPosition);
    _questionFish.physicsBody.categoryBitMask = questionCategory;
    [_questionFish runAction:moveFish];
    [_parentScene addChild:_questionFish];
  } else {
      //we have any other kind of fish
    _fish = [SKSpriteNode spriteNodeWithTexture:_fishesTextures[textureIndex]];
    _fish.xScale = 0.2;
    _fish.yScale = 0.2;
    _fish.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_fish.size.width / 2];
    _fish.physicsBody.affectedByGravity = NO;
    _fish.position = CGPointMake(0, fishPosition);
    _fish.physicsBody.categoryBitMask = fishCategory;
    [_fish runAction:moveFish];
    [_parentScene addChild:_fish];
  }
}

@end

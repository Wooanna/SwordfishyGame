#import "MenuScene.h"
#import "GameScene.h"
#import "BubbleMaker.h"
#import "ScoresView.h"
#import "GameOverScene.h"
#import "QuestionScene.h"
#import "NetworkConnectionChecker.h"

@implementation MenuScene {
  SKLabelNode *_swordWord;
  SKLabelNode *_fishWord;
  SKLabelNode *_playBtn;
  SKLabelNode *_rulesBtn;
  SKLabelNode *_scoresBtn;
  SKLabelNode *_customizePlayerBtn;
  SKSpriteNode *_backgroundLayer;
  SKTexture *_backgroundTexture;
  SKAction *_moveSwordWord;
  SKAction *_moveFishWordPartOne;
  SKAction *_moveFishWordPartTwo;
  SKAction *_moveFishWordPartTree;
  SKAction *_delay;
  SKAction *_delayAndMoveFishWord;
  NSArray *buttons;
  BubbleMaker *_bubbleMaker;
    GameScene *_gameScene;
    ScoresView *_scoresView;
  NetworkConnectionChecker *_connectionChecker;
}

-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        self.backgroundColor = [UIColor blackColor];
        
        
    }
    return self;
}
void showButtons(NSArray *buttons) {

  NSArray *delays =
      [NSArray arrayWithObjects:[SKAction waitForDuration:2.5],
                                [SKAction waitForDuration:3.0],
                                [SKAction waitForDuration:3.5],
                                [SKAction waitForDuration:4.0], nil];
  SKAction *fadeIn = [SKAction fadeInWithDuration:1];

  for (int i = 0; i < delays.count; i++) {
    SKAction *showBtn = [SKAction sequence:@[ delays[i], fadeIn ]];
    [buttons[i] runAction:showBtn];
  }
}

- (void)didMoveToView:(SKView *)view {
  /* Setup your scene here */

  _connectionChecker = [[NetworkConnectionChecker alloc] init];

  self.backgroundColor = [SKColor blueColor];
  _backgroundTexture = [SKTexture textureWithImageNamed:@"menu_back.png"];
  _backgroundLayer = [SKSpriteNode spriteNodeWithTexture:_backgroundTexture];
  _backgroundLayer.position =
      CGPointMake(self.size.width / 2, self.size.height / 2);

  _bubbleMaker = [[BubbleMaker alloc] initWithParentScene:self];

  _swordWord = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _swordWord.text = @"Sword";
  _swordWord.fontSize = 40;
  _swordWord.position =
      CGPointMake(-self.frame.size.width, self.frame.size.width / 2);

  _fishWord = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _fishWord.text = @"Fish";
  _fishWord.color = [SKColor blackColor];
  _fishWord.fontSize = 70;
  _fishWord.position =
      CGPointMake(self.frame.size.width * 2, self.frame.size.width / 2);

  _playBtn = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _playBtn.text = @"Play";
  _playBtn.fontSize = 40;
  _playBtn.position =
      CGPointMake(self.frame.size.width / 2, self.size.height / 2);
  _playBtn.alpha = 0.0;
  _scoresBtn = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _scoresBtn.text = @"Scores";
  _scoresBtn.fontSize = 40;
  _scoresBtn.position =
      CGPointMake(self.frame.size.width / 2, self.size.height / 2 - 80);
  _scoresBtn.alpha = 0.0;

  _rulesBtn = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _rulesBtn.text = @"Rules";
  _rulesBtn.fontSize = 40;
  _rulesBtn.position =
      CGPointMake(self.frame.size.width / 2, self.size.height / 2 - 2 * 80);
  _rulesBtn.alpha = 0.0;
  _customizePlayerBtn = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
  _customizePlayerBtn.text = @"Customize Player";
  _customizePlayerBtn.fontSize = 35;
  _customizePlayerBtn.position =
      CGPointMake(self.frame.size.width / 2, self.size.height / 2 - 3 * 80);
  _customizePlayerBtn.alpha = 0.0;

  buttons = [NSArray arrayWithObjects:_playBtn, _scoresBtn, _rulesBtn,
                                      _customizePlayerBtn, nil];

  _delay = [SKAction waitForDuration:1.2];

  _moveSwordWord =
      [SKAction moveByX:self.frame.size.width + 420 y:0 duration:1];

  _moveFishWordPartOne =
      [SKAction moveByX:-(self.frame.size.width + (self.frame.size.width / 2.3))
                      y:0
               duration:0.4];

  _moveFishWordPartTwo =
      [SKAction moveByX:self.frame.size.width / 12 y:0 duration:0.4];

  _moveFishWordPartTree =
      [SKAction moveByX:-self.frame.size.width / 12 y:0 duration:0.4];

  _delayAndMoveFishWord = [SKAction sequence:@[
    _delay,
    _moveFishWordPartOne,
    _moveFishWordPartTwo,
    _moveFishWordPartTree
  ]];

  [_swordWord runAction:_moveSwordWord];
  [_fishWord runAction:_delayAndMoveFishWord];

  [self addChild:_backgroundLayer];
  [self addChild:_swordWord];
  [self addChild:_fishWord];
  [self addChild:_playBtn];
  [self addChild:_scoresBtn];
  [self addChild:_rulesBtn];
  [self addChild:_customizePlayerBtn];
  showButtons(buttons);
}

- (void)setGameScene {
    [_gameScene setReturnScene:self];
   }

-(void)setScoresScene{
    [_scoresView setReturnScene:self];

}

- (void)update:(NSTimeInterval)currentTime {
  [_bubbleMaker generateBubbles];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  /* Called when a touch begins */
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInNode:self.scene];
  SKTransition *transition = [SKTransition fadeWithDuration:1.];
  if (CGRectContainsPoint(_playBtn.frame, location)) {
      
     
    _gameScene = [GameScene sceneWithSize:self.size];
      [self performSelector:@selector(setGameScene) withObject:nil afterDelay:0.01];

    [self.view presentScene:_gameScene transition:transition];
      
  } else if (CGRectContainsPoint(_scoresBtn.frame, location)) {
    if ([_connectionChecker connection]) {

      SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        
        [self performSelector:@selector(setScoresScene) withObject:nil afterDelay:0.01];

      _scoresView = [ScoresView sceneWithSize:self.size];

      [self.view presentScene:_scoresView transition:transition];
    } else {
      UIAlertView *alert =
          [[UIAlertView alloc] initWithTitle:@"No network connection"
                                     message:@"Please check your network "
                                     @"connection and try again later"
                                    delegate:nil
                           cancelButtonTitle:@"OK"
                           otherButtonTitles:nil];
      [alert show];
    }
  } else if (CGRectContainsPoint(_customizePlayerBtn.frame, location)) {
  } else if (CGRectContainsPoint(_rulesBtn.frame, location)) {
  }
}

@end

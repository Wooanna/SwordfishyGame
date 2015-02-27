#import "MenuScene.h"
#import "GameScene.h"
#import "BubbleMaker.h"
#import "ScoresView.h"
#import "GameOverScene.h"
#import "QuestionScene.h"
#import "OptionsScene.h"
#import "NetworkConnectionChecker.h"

@implementation MenuScene {
  SKLabelNode *_swordWord;
  SKLabelNode *_fishWord;
  SKLabelNode *_playBtn;
  SKLabelNode *_optionsBtn;
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
  NSArray *_buttons;
  BubbleMaker *_bubbleMaker;
  GameScene *_gameScene;
  ScoresView *_scoresView;
  OptionsScene *_optionsScene;
  
  NetworkConnectionChecker *_connectionChecker;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        _connectionChecker = [[NetworkConnectionChecker alloc] init];
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

    _bubbleMaker = [[BubbleMaker alloc] initWithParentScene:self];
    _backgroundTexture = [SKTexture textureWithImageNamed:@"menu_back.png"];
    _backgroundLayer = [SKSpriteNode spriteNodeWithTexture:_backgroundTexture];
    _backgroundLayer.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    
    _swordWord = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
    _fishWord = [SKLabelNode labelNodeWithFontNamed:@"Papyrus"];
    _playBtn = [SKLabelNode new];
    _scoresBtn = [SKLabelNode new];
    _optionsBtn = [SKLabelNode new];
    _customizePlayerBtn = [SKLabelNode new];
    
    [self addChild:_backgroundLayer];
    [self addChild:_swordWord];
    [self addChild:_fishWord];
    [self addChild:_playBtn];
    [self addChild:_scoresBtn];
    [self addChild:_optionsBtn];
    [self addChild:_customizePlayerBtn];
    
    _buttons = [NSArray arrayWithObjects:_playBtn, _scoresBtn, _optionsBtn, _customizePlayerBtn, nil];

    for (int i = 0; i < _buttons.count; i++) {
        ((SKLabelNode*)_buttons[i]).fontName = @"Papyrus";
        ((SKLabelNode*)_buttons[i]).position = CGPointMake(self.frame.size.width / 2, self.size.height / 2 - i * 80);
        ((SKLabelNode*)_buttons[i]).fontSize = 40;
        ((SKLabelNode*)_buttons[i]).alpha = 0;
        ((SKLabelNode*)_buttons[i]).zPosition = 51;
    }
    
  _swordWord.text = @"Sword";
  _swordWord.fontSize = 40;
  _swordWord.position = CGPointMake(-self.frame.size.width, self.frame.size.width / 2);

  _fishWord.text = @"Fish";
  _fishWord.fontSize = 70;
  _fishWord.position = CGPointMake(self.frame.size.width * 2, self.frame.size.width / 2);

  _playBtn.text = @"Play";
  _scoresBtn.text = @"Scores";
  _optionsBtn.text = @"Options";
  _customizePlayerBtn.text = @"Customize Player";

  
  _delay = [SKAction waitForDuration:1.2];

  _moveSwordWord = [SKAction moveByX:self.frame.size.width + 420 y:0 duration:1];

  _moveFishWordPartOne = [SKAction moveByX:-(self.frame.size.width + (self.frame.size.width / 2.3)) y:0 duration:0.4];

  _moveFishWordPartTwo = [SKAction moveByX:self.frame.size.width / 12 y:0 duration:0.4];

  _moveFishWordPartTree = [SKAction moveByX:-self.frame.size.width / 12 y:0 duration:0.4];

  _delayAndMoveFishWord = [SKAction sequence:@[_delay, _moveFishWordPartOne, _moveFishWordPartTwo, _moveFishWordPartTree]];

  [_swordWord runAction:_moveSwordWord];
  [_fishWord runAction:_delayAndMoveFishWord];

   showButtons(_buttons);
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
  } else if (CGRectContainsPoint(_optionsBtn.frame, location)) {
      
      _optionsScene = [OptionsScene sceneWithSize:self.size];
      [self.view presentScene:_optionsScene transition:transition];
      
  }
}

@end

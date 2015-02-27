//
//  OptionsScene.m
//  SwordfishGame
//
//  Created by Yoanna Mareva on 2/27/15.
//  Copyright (c) 2015 admin. All rights reserved.
//

#import "OptionsScene.h"

@implementation OptionsScene{
    SKLabelNode* _optionsLabel;
    SKLabelNode* _soundLabel;
    SKLabelNode* _vibrateLabel;
    NSMutableArray* _labels;
    SKTexture *_yesTexture;
    SKTexture *_noTexture;
    SKSpriteNode *_allowSound;
    SKSpriteNode *_allowVibrate;
    SKLabelNode* _onOrOffSound;
    SKLabelNode* _onOrOffVibrate;
    BOOL soundEnabled;
    BOOL vibrateEnabled;
}

-(instancetype)init{
    self = [super init];
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}

-(instancetype)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    
    if(self){
        self.anchorPoint = CGPointMake(0.5, 0.5);
        _optionsLabel = [SKLabelNode new];
        _soundLabel = [SKLabelNode new];
        _vibrateLabel = [SKLabelNode new];
        _onOrOffSound = [SKLabelNode new];
        _onOrOffVibrate = [SKLabelNode new];
        _optionsLabel.text = @"OPTIONS: ";
        _vibrateLabel.text = @"VIBRATE ";
        _soundLabel.text = @"SOUND ";
        _yesTexture = [SKTexture textureWithImageNamed:@"sharky1@2x.png"];
        _noTexture = [SKTexture textureWithImageNamed:@"sharky2@2x.png"];
        _allowSound = [SKSpriteNode spriteNodeWithTexture:_yesTexture];
        _allowVibrate = [SKSpriteNode spriteNodeWithTexture:_yesTexture];
        _allowSound.position = CGPointMake(self.view.frame.size.width/2 + 200, 70);
        _allowVibrate.position = CGPointMake(self.view.frame.size.width/2 + 200, -10);
        _allowVibrate.size = CGSizeMake(70, 70);
        _allowSound.size = CGSizeMake(70, 70);
        _labels = [NSMutableArray arrayWithObjects:_vibrateLabel, _soundLabel, _optionsLabel, nil];
        
        
        for (int i = 0; i < _labels.count; i++) {
            ((SKLabelNode*)_labels[i]).fontName = @"Papyrus";
            ((SKLabelNode*)_labels[i]).fontSize = 70;
            ((SKLabelNode*)_labels[i]).position = CGPointMake(self.view.frame.size.width/2, (i * 80) - 20);
            ((SKLabelNode*)_labels[i]).fontColor = [UIColor whiteColor];
            [self addChild:((SKLabelNode*)_labels[i])];

        }
        
        _onOrOffSound.fontName = @"Papyrus";
        _onOrOffSound.fontSize = 70;
        _onOrOffSound.text = @"ON";
        _onOrOffSound.position = CGPointMake(self.view.frame.size.width/2 + 320, 60);
        _onOrOffSound.fontColor = [UIColor whiteColor];
        
        _onOrOffVibrate.fontName = @"Papyrus";
        _onOrOffVibrate.fontSize = 70;
        _onOrOffVibrate.text = @"OFF";
        _onOrOffVibrate.position = CGPointMake(self.view.frame.size.width/2 + 320, -20);
        _onOrOffVibrate.fontColor = [UIColor whiteColor];

        [self addChild:_onOrOffSound];
        [self addChild:_onOrOffVibrate];
        [self addChild:_allowVibrate];
        [self addChild:_allowSound];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    [super didMoveToView:view];
    }

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.scene];
    
    if (CGRectContainsPoint(_allowSound.frame, location)) {
        if(soundEnabled){
            soundEnabled = NO;
            _allowSound.texture = _noTexture;
            _onOrOffSound.text = @"OFF";
        }
        else{
            soundEnabled = YES;
            _allowSound.texture = _yesTexture;
            _onOrOffSound.text = @"ON";
        }
    }
    else if(CGRectContainsPoint(_allowVibrate.frame, location)) {
        if(vibrateEnabled){
            vibrateEnabled = NO;
            _allowVibrate.texture = _noTexture;
            _onOrOffVibrate.text = @"OFF";
        }
        else{
            vibrateEnabled = YES;
            _allowVibrate.texture = _yesTexture;
            _onOrOffVibrate.text = @"ON";
        }

    }

}
@end

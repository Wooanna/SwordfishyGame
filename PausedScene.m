//
//  PausedScene.m
//  SwordfishGame
//
//  Created by admin on 11/5/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "PausedScene.h"

@implementation PausedScene{
    SKSpriteNode* _backLayer;
    SKLabelNode* _gamePaused;
}
-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
               _backLayer = [SKSpriteNode spriteNodeWithImageNamed:@"menu_back.png"];
        _backLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _backLayer.zPosition = 30;
        
        
        _gamePaused = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _gamePaused.text = @"GAME PAUSED Chatch a bubble to resume your game";
        _gamePaused.fontSize = 40;
        _gamePaused.fontColor = [UIColor blueColor];
        _gamePaused.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _gamePaused.zPosition = 40;
        [self addChild:_backLayer];
        [self addChild:_gamePaused];
    }
    return self;
}


@end

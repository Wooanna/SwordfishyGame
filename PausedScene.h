//
//  PausedScene.h
//  SwordfishGame
//
//  Created by admin on 11/5/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PausedScene : SKScene

@property (strong, nonatomic, readonly) SKScene* returnScene;

-(void)setReturnScene:(SKScene *)returnScene;

@end

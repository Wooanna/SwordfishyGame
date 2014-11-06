//
//  SharedMainScene.h
//  SwordfishGame
//
//  Created by admin on 11/6/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SharedMainScene : SKScene

@property (weak, nonatomic, readonly) SKScene* returnScene;

-(void)setReturnScene:(SKScene *)otherScene;

@end

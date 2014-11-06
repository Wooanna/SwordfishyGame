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
}
-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
        self.backgroundColor = [UIColor yellowColor];
        _backLayer = [SKSpriteNode nodeWithFileNamed:@"menu_back.png"];
        [self addChild:_backLayer];
    }
    return self;
}
@end

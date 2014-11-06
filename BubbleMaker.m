//
//  BubbleMaker.m
//  SwordfishGame
//
//  Created by admin on 11/6/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "BubbleMaker.h"
#import <SpriteKit/SpriteKit.h>
@interface BubbleMaker()
@end


@implementation BubbleMaker{
SKSpriteNode *_bubble;
}
-(id)initWithParentScene:(SKScene *)scene{
    if(self = [super init]){
     _parentScene = scene;
    
    }
    
    return self;
   

    
}

- (void)generateBubbles {
    
    CGFloat numbers[] = {20, -20, -30, 30, 40, -40, -50, -60, 60, 50};
    CGFloat numbersForScaleBubbles[] = {0.05, 0.1, 0.15};
    int numbersCount = 10;
    int scalesCount = 3;
    CGFloat scale = numbersForScaleBubbles[arc4random_uniform(scalesCount)];
    int duration = arc4random_uniform(3);
    SKAction *moveBubbleUp =
    [SKAction moveToY:_parentScene.frame.size.height duration:duration];
    SKAction *moveToSides = [SKAction
                             repeatActionForever:
                             [SKAction moveByX:numbers[arc4random_uniform(numbersCount)]
                                             y:0
                                      duration:0.001 * numbers[arc4random_uniform(numbersCount)]]];
    SKAction *move = [SKAction group:@[ moveBubbleUp, moveToSides ]];
    
    _bubble = [SKSpriteNode spriteNodeWithImageNamed:@"bubble.png"];
    _bubble.xScale = scale;
    _bubble.yScale = scale;
    _bubble.position =
    CGPointMake(arc4random_uniform(_parentScene.frame.size.width), -50);
    _bubble.zPosition = 50;
    [_bubble runAction:move];
    
    [_parentScene addChild:_bubble];
}
@end

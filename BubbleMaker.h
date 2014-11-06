//
//  BubbleMaker.h
//  SwordfishGame
//
//  Created by admin on 11/6/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BubbleMaker : NSObject

@property (strong, nonatomic, readonly) SKScene* parentScene;

-initWithParentScene:(SKScene*)scene;

-(void)generateBubbles;
@end

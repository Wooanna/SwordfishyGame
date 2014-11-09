//
//  ScoresView.h
//  SwordfishGame
//
//  Created by admin on 11/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScoresView : SKScene <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic, readonly) SKScene *returnScene;

- (void)setReturnScene:(SKScene *)returnScene;

#pragma mark -
#pragma mark UITableView setup
- (void)didMoveToView:(SKView *)view;
@end

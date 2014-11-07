//
//  ScoresView.h
//  SwordfishGame
//
//  Created by admin on 11/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScoresView : SKScene <UITableViewDelegate, UITableViewDataSource>

#pragma mark -
#pragma mark UITableView setup

- (void)didMoveToView:(SKView *)view; 
@end

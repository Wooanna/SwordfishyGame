//
//  bestScores.m
//  SwordfishGame
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "BestScore.h"

@implementation BestScore {
  NSString *_playerName;
  NSNumber *_playerResult;
}

@dynamic playerName;
@dynamic playerResult;

+ (NSString *)parseClassName {
  return @"Scores";
}

+ (void)load {
  [self registerSubclass];
}

- (void)setPlayerName:(NSString *)playerName {
  self[@"playerName"] = playerName;
  _playerName = playerName;
}

- (void)setPlayerResult:(NSNumber *)playerResult {
  self[@"playerResult"] = playerResult;
  _playerResult = playerResult;
}

@end

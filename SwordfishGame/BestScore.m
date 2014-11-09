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
  NSString *_locationName;
  NSString *_countryName;
  NSString *_subLocality;
}

@dynamic playerName;
@dynamic playerResult;
@dynamic locationName;
@dynamic countryName;
@dynamic subLocality;

+ (NSString *)parseClassName {
  return @"Score";
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

- (void)setLocationName:(NSString *)locationName {
  self[@"locationName"] = locationName;
  _locationName = locationName;
}

- (void)setCountryName:(NSString *)countryName {
  self[@"countryName"] = countryName;
  _countryName = countryName;
}

- (void)setSubLocality:(NSString *)subLocality {
  self[@"subLocality"] = subLocality;
  _subLocality = subLocality;
}
@end

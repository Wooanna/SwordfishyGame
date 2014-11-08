//
//  bestScores.h
//  SwordfishGame
//
//  Created by Admin on 11/5/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Parse/Parse.h>

@interface BestScore : PFObject <PFSubclassing>

@property(nonatomic, strong) NSString *playerName;
@property NSNumber *playerResult;

@end

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
@property(nonatomic, strong) NSString *locationName;
@property(nonatomic, strong) NSString *countryName;
@property(nonatomic, strong) NSString *subLocality;

@end

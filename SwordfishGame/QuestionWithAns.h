//
//  Question.h
//  SwordfishGame
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Parse/Parse.h>

@interface QuestionWithAns : PFObject <PFSubclassing>

@property(nonatomic, strong) NSString *question;
@property NSNumber *rightAnswer;
@property(nonatomic, strong) NSString *answerOne;
@property(nonatomic, strong) NSString *answerTwo;
@property(nonatomic, strong) NSString *answerThree;

@end

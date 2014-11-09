//
//  Question.m
//  SwordfishGame
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "QuestionWithAns.h"

@implementation QuestionWithAns {
  NSString *_question;
  NSNumber *_rightAnswer;
  NSString *_answerOne;
  NSString *_answerTwo;
  NSString *_answerThree;
}

@dynamic question;
@dynamic rightAnswer;
@dynamic answerOne;
@dynamic answerTwo;
@dynamic answerThree;

+ (NSString *)parseClassName {
  return @"QuestionsWithAns";
}

+ (void)load {
  [self registerSubclass];
}

- (void)setQuestion:(NSString *)question {
  self[@"question"] = question;
  _question = question;
}

- (void)setRightAnswer:(NSNumber *)rightAnswer {
  self[@"rightAnswer"] = rightAnswer;
  _rightAnswer = rightAnswer;
}

- (void)setAnswerOne:(NSString *)answerOne {
  self[@"answerOne"] = answerOne;
  _answerOne = answerOne;
}

- (void)setAnswerTwo:(NSString *)answerTwo {
  self[@"answerTwo"] = answerTwo;
  _answerTwo = answerTwo;
}

- (void)setAnswerThree:(NSString *)answerThree {
  self[@"answerThree"] = answerThree;
  _answerThree = answerThree;
}

@end

//
//  QuestionWithAnswer.m
//  SwordfishGame
//
//  Created by Admin on 11/6/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "QuestionWithAnswer.h"


@implementation QuestionWithAnswer

@dynamic question;
@dynamic answerOne;
@dynamic answerTwo;
@dynamic answerThree;
@dynamic rightAnswer;

- (instancetype)initWithQuestion:(NSString *)fullQuestion
                      qAnswerOne:(NSString *)ansOne
                     qAnswersTwo:(NSString *)ansTwo
                   qAnswersThree:(NSString *)ansThree
                    qRightAnswer:(NSNumber *)rightAns

{
    self = [super init];
    if (self) {
        
        self.question = fullQuestion;
        self.answerOne = ansOne;
        self.answerTwo = ansTwo;
        self.answerThree = ansThree;
        self.rightAnswer = rightAns;
    }
    return self;
}

@end

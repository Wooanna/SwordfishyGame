//
//  QuestionWithAnswer.h
//  SwordfishGame
//
//  Created by Admin on 11/6/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface QuestionWithAnswer : NSManagedObject

@property(nonatomic, retain) NSString *question;
@property(nonatomic, retain) NSString *answerOne;
@property(nonatomic, retain) NSString *answerTwo;
@property(nonatomic, retain) NSString *answerThree;
@property(nonatomic, retain) NSNumber *rightAnswer;

- (instancetype)initWithQuestion:(NSString *)fullQuestion
                      qAnswerOne:(NSString *)ansOne
                     qAnswersTwo:(NSString *)ansTwo
                   qAnswersThree:(NSString *)ansThree
                    qRightAnswer:(NSNumber *)rightAns;

@end

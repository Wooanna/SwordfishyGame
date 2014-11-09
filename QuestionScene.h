//
//  QuestionScene.h
//  SwordfishGame
//
//  Created by admin on 11/7/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface QuestionScene : SKSpriteNode

@property (strong, nonatomic,  readonly)SKLabelNode* question;


@property (strong, nonatomic,  readonly)SKLabelNode* answerOne;
@property (strong, nonatomic,  readonly)SKLabelNode* answerTwo;
@property (strong, nonatomic,  readonly)SKLabelNode* answerTree;
@property (strong, nonatomic, readonly)NSNumber* rightAnswer;

-(void)initQuestionNode;
-(CGRect) getAnswerOneFrame;
-(CGRect) getAnswerTwoFrame;
-(CGRect) getAnswerTreeFrame;
-(NSNumber*) getRightAnswer;
@end

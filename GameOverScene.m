#import "GameOverScene.H"
#import "BestScore.h"

@implementation GameOverScene{
    UITextField* textField;
    SKLabelNode* labelDone;
}


-(void)didMoveToView:(SKView *)view{
    textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    textField.center = self.view.center;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:17.0];
    textField.placeholder = @"Enter your name here";
    textField.backgroundColor = [UIColor whiteColor];
    textField.autocorrectionType = UITextAutocorrectionTypeYes;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    labelDone = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    labelDone.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 100);
    labelDone.text = @"DONE";
    labelDone.fontSize = 40;
    [self.view addSubview:textField];
    [self addChild:labelDone];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch* touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self.scene];
    
    if(CGRectContainsPoint(labelDone.frame, location)){
        NSString* name = [textField text];
        NSNumber* score = @200;
        
        // Add object to Parse.com **********************************************
        BestScore *bestScore = [BestScore object];
        [bestScore setPlayerName:name];
        [bestScore setPlayerResult:score];
        
        [bestScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Result saved");
            } else {
                NSLog(@"%@", error);
            }
        }];
    
    }
    
}
@end

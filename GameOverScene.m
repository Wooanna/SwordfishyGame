#import "GameOverScene.H"
#import "BestScore.h"
#import "TALocationProvider.h"


@implementation GameOverScene{
    UITextField* textField;
    SKLabelNode* labelDone;
    SKSpriteNode* gameOver;
    SKSpriteNode* waterLayer;
    TALocationProvider *locationProvider;
}

-(instancetype)initWithSize:(CGSize)size{
    if(self = [super initWithSize:size]){
    self.backgroundColor = [UIColor blackColor];
    gameOver = [SKSpriteNode spriteNodeWithImageNamed:@"gameover.png"];
    gameOver.position = CGPointMake(self.frame.size.width/2, self.frame.size.height - 150);
    gameOver.zPosition = 600;
    
    waterLayer = [SKSpriteNode spriteNodeWithImageNamed:@"water_layer_over.png"];
    waterLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    waterLayer.alpha = 0.5;
    
    
    //TODO: init gameover
    //Your score is: 5894
    //To save your score:
    
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
    labelDone.zPosition = 500;
        
        // add location
        locationProvider = [[TALocationProvider alloc] init];

    [self addChild:waterLayer];
    
    [self addChild:labelDone];
    [self addChild:gameOver];
    [self.view addSubview:textField];
    }
    return self;
}

- (void)locationUpdated:(CLLocation *)geoLocation {
    NSString *geoLocationMessage =
    [NSString stringWithFormat:@"Your position is (%lf, %lf)",
     geoLocation.coordinate.latitude,
     geoLocation.coordinate.longitude];
    
    [[[UIAlertView alloc] initWithTitle:@"Location updated with target-action"
                                message:geoLocationMessage
                               delegate:nil
                      cancelButtonTitle:@"Ok"
                      otherButtonTitles:nil, nil] show];
    
}






- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInNode:self.scene];

  if (CGRectContainsPoint(labelDone.frame, location)) {
    NSString *name = [textField text];
    NSNumber *score = @200;

    // Add object to Parse.com **********************************************
    BestScore *bestScore = [BestScore object];
    [bestScore setPlayerName:name];
    [bestScore setPlayerResult:score];

    [locationProvider getLocationWithTarget:self
                                  andAction:@selector(locationUpdated:)];
    [locationProvider getLocationWithBlock:^(CLLocation *geoLocation) {
        NSString *geoLocationMessage =
            [NSString stringWithFormat:@"Your position is (%lf, %lf)",
                                       geoLocation.coordinate.latitude,
                                       geoLocation.coordinate.longitude];

        [[[UIAlertView alloc] initWithTitle:@"Location updated"
                                    message:geoLocationMessage
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];

        CLGeocoder *coder = [[CLGeocoder alloc] init];
        [coder reverseGeocodeLocation:geoLocation
                    completionHandler:^(NSArray *placemarks, NSError *error) {
                        CLPlacemark *mark = [placemarks lastObject];
                        NSLog(@"%@ - %@ - %@", mark.name, mark.subLocality,
                              mark.country);

                        [bestScore setLocationName:mark.name];

                        if (mark.subLocality) {
                          [bestScore setSubLocality:mark.subLocality];
                        } else {
                          [bestScore setSubLocality:@""];
                        }

                        if (mark.country) {
                          [bestScore setCountryName:mark.country];
                        } else {
                          [bestScore setCountryName:@""];
                        }

                        [bestScore saveInBackgroundWithBlock:^(BOOL succeeded,
                                                               NSError *error) {
                            if (succeeded) {
                              NSLog(@"Result saved");
                            } else {
                              NSLog(@"%@", error);
                            }
                        }];

                    }];
    }];
  }
}
@end

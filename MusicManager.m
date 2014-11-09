
#import "MusicManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation MusicManager : NSObject {
  AVAudioPlayer *audioPlayer1;
}
- (void)playAudio:(NSString *)song
    withExtencion:(NSString *)extencion
      andDelegate:(SKScene *)delegate {

  NSString *music =
      [[NSBundle mainBundle] pathForResource:song ofType:extencion];
  audioPlayer1 =
      [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:music]
                                             error:NULL]; // TODO: error
  audioPlayer1.delegate = delegate;
  audioPlayer1.numberOfLoops = -1;
  [audioPlayer1 play];
}
@end

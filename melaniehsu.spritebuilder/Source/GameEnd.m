//
//  GameEnd.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameEnd.h"
#import "Gameplay.h"

@implementation GameEnd {
    CCLabelTTF *_messageLabel;
    CCLabelTTF *_scoreLabel;
    Gameplay *_game;
    OALSimpleAudio *audio;

}

- (void)home {
    CCScene *home = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:home];
    
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"musicBG.wav" loop:TRUE];
}

- (void)newGame {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"musicBG.wav" loop:TRUE];
}

- (void)setMessage:(NSString *)message score:(double)score {
    _messageLabel.string = message;
    _scoreLabel.string = [NSString stringWithFormat:@"Sleepy Head slept %.2f hours", score];
}

@end

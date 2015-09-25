//
//  Directions.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Directions.h"
#import "Gameplay.h"

@implementation Directions {
    CCLabelTTF *_messageLabel;
    CCLabelTTF *_scoreLabel;
    Gameplay *_game;
}

- (void)newGame {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)setMessage:(NSString *)message score:(double)score {
    _messageLabel.string = message;
    _scoreLabel.string = [NSString stringWithFormat:@"Sleepy Head slept %.2f hours", score];
}

@end

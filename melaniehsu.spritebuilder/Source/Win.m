//
//  Win.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Win.h"
#import "Gameplay.h"
#import "GameData.h"

@implementation Win {
    CCLabelTTF *_messageLabel;
    CCLabelTTF *_qualityLabel;
    Gameplay *_game;
    CCSprite *_one;
    CCSprite *_two;
    CCSprite *_three;
    BOOL increased;
    OALSimpleAudio *audio;
    CCButton *nextLevel;
    BOOL done;

}


//win a level = unlock the next one
- (void)didLoadFromCCB {
    
    if ([GameData sharedInstance].level == 1) {
        [MGWU logEvent:@"passed level 1" withParams:nil];
    }
    else if ([GameData sharedInstance].level == 2) {
        [MGWU logEvent:@"passed level 2" withParams:nil];
    }
    else if ([GameData sharedInstance].level == 3) {
        [MGWU logEvent:@"passed level 3" withParams:nil];
    }
    else if ([GameData sharedInstance].level == 4) {
        [MGWU logEvent:@"passed level 4" withParams:nil];

    }
    else if ([GameData sharedInstance].level == 5) {
        [MGWU logEvent:@"passed level 5" withParams:nil];
    }
    else if ([GameData sharedInstance].level == 6) {
        [MGWU logEvent:@"passed level 6" withParams:nil];
    }
    else if ([GameData sharedInstance].level == 7) {
        [MGWU logEvent:@"passed level 7" withParams:nil];
    }
    else if ([GameData sharedInstance].level == 8) {
        [MGWU logEvent:@"passed level 8" withParams:nil];
    }
    
    //there is no next level on the last level!
    if ([GameData sharedInstance].level == 8) {
        nextLevel.enabled = FALSE;
    }
    else {
        nextLevel.enabled = TRUE;
    }

    
    NSLog(@"Going to pass in %d", [GameData sharedInstance].level +1);
    
    [[GameData sharedInstance] unlock:[GameData sharedInstance].level +1];
    //increased = FALSE;
    
    if ([GameData sharedInstance].level == 10) {
        nextLevel.enabled = FALSE; 
    }
    
//TODO: get stars to show up
  
    [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"winmelody.wav" loop:TRUE];

}

- (void)home {
    CCScene *home = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:home];
    /*if (!increased) {
        [GameData sharedInstance].level += 1;
    }
    increased = FALSE;*/
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    
    [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"musicBG.wav" loop:TRUE];
}

- (void)restart {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
    [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    
    // play background sound
[audio playBg:@"musicBG.wav" loop:TRUE];
}

- (void)newGame {
    
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    
    [GameData sharedInstance].level += 1;
    //self.level = [self.gameplayLayer incrementLevel];
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    //mainScene.anchorPoint = ccp(0, 0);
    //mainScene.position = ccp(0, 0);
    [[CCDirector sharedDirector] replaceScene:mainScene];
    //mainScene.level = self.level;
    [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"musicBG.wav" loop:TRUE];
}

- (void)setMessage:(NSString *)message score:(double)score {
    _messageLabel.string = message;
    _qualityLabel.string = [NSString stringWithFormat:@"Sleepy Head slept %.2f hours", score];
}

//how many stars to display on the win popup
- (void)starDisplay {
    
    NSInteger stars = [[GameData sharedInstance] getStars];
    NSLog(@"GOT %d", stars);
    if (stars == 3) {
        _one.visible = TRUE;
        _two.visible = TRUE;
        _three.visible = TRUE;
        _qualityLabel.string = [NSString stringWithFormat:@"Sleep quality: Excellent"];
    }
    else if (stars == 2) {
        _one.visible = TRUE;
        _two.visible = TRUE;
        _three.visible = FALSE;
        _qualityLabel.string = [NSString stringWithFormat:@"Sleep quality: Decent"];
    }
    else if (stars == 1) {
        _one.visible = TRUE;
        _two.visible = FALSE;
        _three.visible = FALSE;
        _qualityLabel.string = [NSString stringWithFormat:@"Sleep quality: Mediocre"];
    }
    else {
        _one.visible = FALSE;
        _two.visible = FALSE;
        _three.visible = FALSE;
        _qualityLabel.string = [NSString stringWithFormat:@"Sleep quality: Nightmare"];
    }
}

@end

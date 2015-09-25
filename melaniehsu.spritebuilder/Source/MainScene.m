//
//  MainScene.m
//  melanie-hsu
//
//  Created by Melanie Hsu on 7/8/14.
//  Copyright (c) 2014 Melanie Hsu. All rights reserved.
//

#import "MainScene.h"
#import "Select.h"
#import "GameData.h"
#import "Gameplay.h" 
#import "Tutorial.h"


@implementation MainScene {
    CCLabelTTF *_health;
    CCLabelTTF *_starCount;
    CCNode *_starOne;
    CCNode *_starTwo;
    CCNode *_starThree;
    CCNode *_starFour;
    CCParticleSystem *explosion;
    CCParticleSystem *kaboom;
    CCParticleSystem *blast;
    CCParticleSystem *bam;
    OALSimpleAudio *audio;
    CCSprite *_brightMoon;
    CCSprite *_skies;
}

-(void) didLoadFromCCB {
    //[self runNotif];
    [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"musicBG.wav" loop:TRUE];
    //[self moonFall];
   // [_skies runAction:[CCActionMoveBy actionWithDuration:60.f position:ccp(0, 1900)]];
}

//like my page on Facebook
- (void) like {
    [MGWU likeAppWithPageId:@"679644778772939"];
}

- (void)runNotif {
    int random = arc4random_uniform(16);
    switch (random) {
        case 1:
            [MGWU showMessage:@"Don't sleep with your pets! You might catch something nasty...like a bowling ball!" withImage:nil];
            break;
        case 2:
            [MGWU showMessage:@"It only takes one bowling ball to ruin a good night's sleep." withImage:nil];
            break;
        case 3:
            [MGWU showMessage:@"Sloppy the skydiving turtle is a speed demon - flick him away ASAP!" withImage:nil];
            break;
        case 4:
            [MGWU showMessage:@"Poppy chose to tame crocodiles cause she felt dragons were too cliche." withImage:nil];
            break;
        case 5:
            [MGWU showMessage:@"The purple levels come with a huge spike in difficulty." withImage:nil];
            break;
        case 6:
            [MGWU showMessage:@"Can you survive Floppy's reckless rampage? Flick your way to sunrise!" withImage:nil];
            break;
        case 7:
            [MGWU showMessage:@"Sleepy Head sleeps for only six hours a night - most people should aim for more." withImage:nil];
            break;
        case 8:
            [MGWU showMessage:@"Stack multiplier bonuses to raise your high score!" withImage:nil];
            break;
        case 9:
            [MGWU showMessage:@"Rocket scientists Cherry and Berry show up at the least opportune moments." withImage:nil];
            break;
        case 10:
            [MGWU showMessage:@"Minty the parachuting turtle has a rather soft carapace." withImage:nil];
            break;
        case 11:
            [MGWU showMessage:@"Sleepy head isn't the only character with hit points..*hint* *hint*" withImage:nil];
            break;
        case 12:
            [MGWU showMessage:@"Poppy's crocodile may not breathe fire, but she can sure smoke things up." withImage:nil];
            break;
        case 13:
            [MGWU showMessage:@"Loud snoring can be a sign of sleep apnea, a potentially life-threatening sleep disorder." withImage:nil];
            break;
        case 14:
            [MGWU showMessage:@"Sleepy Head's sleep quality determines the number of stars you receive." withImage:nil];
            break;
        case 15:
            [MGWU showMessage:@"I wonder what Floppy loaded those socks with..." withImage:nil];
            break;
        case 16:
            [MGWU showMessage:@"Sleepy Head snores less each time he is hit." withImage:nil];
            break;
    }
}

- (void)moonFall {
    [_brightMoon runAction:[CCActionMoveBy actionWithDuration:45.f position:ccp(0, -500)]];
    //_moon.position = ccp(165.0, 0);
}

-(void)update:(CCTime)delta {
    
    _starCount.string = [NSString stringWithFormat:@"%d",[[GameData sharedInstance] stars]];
    
    if (!(_starOne.position.x < 0 || _starOne.position.x > [CCDirector sharedDirector].viewSize.width || _starOne.position.y > [CCDirector sharedDirector].viewSize.height)) {
            explosion = (CCParticleSystem *)[CCBReader load:@"ShootingStar"];
            explosion.autoRemoveOnFinish = TRUE;
            [self addChild:explosion];
            explosion.position = _starOne.position;
    }
    if (!(_starTwo.position.x < 0 || _starTwo.position.x > [CCDirector sharedDirector].viewSize.width || _starTwo.position.y > [CCDirector sharedDirector].viewSize.height)) {
            kaboom = (CCParticleSystem *)[CCBReader load:@"ShootingStar"];
            kaboom.autoRemoveOnFinish = TRUE;
            [self addChild:kaboom];
            kaboom.position = _starTwo.position;
    }
    if (!(_starThree.position.x < 0 || _starThree.position.x > [CCDirector sharedDirector].viewSize.width || _starThree.position.y > [CCDirector sharedDirector].viewSize.height)) {
            blast = (CCParticleSystem *)[CCBReader load:@"ShootingStar"];
            blast.autoRemoveOnFinish = TRUE;
            [self addChild:blast];
            blast.position = _starThree.position;
    }
    if (!(_starFour.position.x < 0 || _starFour.position.x > [CCDirector sharedDirector].viewSize.width || _starFour.position.y > [CCDirector sharedDirector].viewSize.height)) {
            bam = (CCParticleSystem *)[CCBReader load:@"ShootingStar"];
            bam.autoRemoveOnFinish = TRUE;
            [self addChild:bam];
            bam.position = _starFour.position;
    }
}

//"sleep" is the play button in the game
- (void)sleep {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
   /* //if first time playing, load the tutorial, else load select
    if (![[GameData sharedInstance] didTutorial]) {
        Tutorial *gameScene = (Tutorial*)[CCBReader loadAsScene:@"Tutorial"];
        NSLog(@"playing tutorial");
        [[CCDirector sharedDirector] replaceScene:gameScene];
    }*/
        Select *gameplayScene = (Select*)[CCBReader loadAsScene:@"Select"];
        [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

//"diary" is the level selector function
- (void)diary {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    CCScene *levelScene = [CCBReader loadAsScene:@"Diary"];
    [[CCDirector sharedDirector] replaceScene:levelScene];
}

//"reset" allows user to start from level one (playtesting purposes only)
-(void)reset {
   /* [[GameData sharedInstance] setLevel:1];
    [[GameData sharedInstance] resetStars];
    [[GameData sharedInstance] resetLocks];*/
    
    [[GameData sharedInstance] resetTutorial];
    //[[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Level Number"]; //set this to level one to get the user to be able to play one again
}

-(void)open {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    CCScene *opening = [CCBReader loadAsScene:@"Opening"];
    [[CCDirector sharedDirector] replaceScene:opening];
}

-(void)highScore {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    CCScene *levelScene = [CCBReader loadAsScene:@"HighScores"];
    [[CCDirector sharedDirector] replaceScene:levelScene];
}

- (void)moreGames {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    [MGWU displayCrossPromo];
}

/*
- (void) about {
    [MGWU displayAboutPage];
}*/

@end

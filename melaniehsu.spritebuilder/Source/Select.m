//
//  Select.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Select.h"
#import "GameData.h"

@implementation Select {
    CCButton *levelonebutton;
    CCButton *leveltwobutton;
    CCButton *levelthreebutton;
    CCButton *levelfourbutton;
    CCButton *levelfivebutton;
    CCButton *levelsixbutton;
    CCButton *levelsevenbutton;
    CCButton *leveleightbutton;
    CCSprite *_oneone;
    CCSprite *_onetwo;
    CCSprite *_onethree;
    CCSprite *_twoone;
    CCSprite *_twotwo;
    CCSprite *_twothree;
    CCSprite *_threeone;
    CCSprite *_threetwo;
    CCSprite *_threethree;
    CCSprite *_fourone;
    CCSprite *_fourtwo;
    CCSprite *_fourthree;
    CCSprite *_fiveone;
    CCSprite *_fivetwo;
    CCSprite *_fivethree;
    CCSprite *_sixone;
    CCSprite *_sixtwo;
    CCSprite *_sixthree;
    CCSprite *_sevenone;
    CCSprite *_seventwo;
    CCSprite *_seventhree;
    CCSprite *_evil;
    CCSprite *_eightone;
    CCSprite *_eighttwo;
    CCSprite *_eightthree;
    
}
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"Hello");
    }
    return self;
}

- (void)uchi {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    CCScene *leave = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:leave];
}

//didloadfromccb
- (void)didLoadFromCCB {
    if (![[GameData sharedInstance]locked: 2]) {
        //leveltwobutton.visible = FALSE;
        leveltwobutton.enabled = NO;
    }
    if (![[GameData sharedInstance]locked: 3]) {
        //levelthreebutton.visible = FALSE;
        levelthreebutton.enabled = NO;
    }
    if (![[GameData sharedInstance]locked: 4]) {
        //levelfourbutton.visible = FALSE;
        levelfourbutton.enabled = NO;
    }
    if (![[GameData sharedInstance]locked: 5]) {
        //levelfivebutton.visible = FALSE;
        levelfivebutton.enabled = NO;
    }
    if (![[GameData sharedInstance]locked: 6]) {
        //levelfivebutton.visible = FALSE;
        levelsixbutton.enabled = NO;
    }
    if (![[GameData sharedInstance]locked: 7]) {
        //levelfivebutton.visible = FALSE;
        levelsevenbutton.enabled = NO;
    }
    if (![[GameData sharedInstance]locked: 8]) {
        //levelfivebutton.visible = FALSE;
        leveleightbutton.enabled = NO;
    }
    
    //update stars for each level
    NSLog(@"stars shown for level 1 %d)", [[GameData sharedInstance]starsFor:1]);
    if ([[GameData sharedInstance]starsFor:1] == 3) {
        _oneone.visible = TRUE;
        _onetwo.visible = TRUE;
        _onethree.visible = TRUE;
    }
    else if ([[GameData sharedInstance]starsFor:1] == 2) {
        _oneone.visible = TRUE;
        _onetwo.visible = TRUE;
        _onethree.visible = FALSE;
    }
    else if ([[GameData sharedInstance]starsFor:1] == 1) {
        _oneone.visible = TRUE;
        _onetwo.visible = FALSE;
        _onethree.visible = FALSE;
    }
    else {
        _oneone.visible = FALSE;
        _onetwo.visible = FALSE;
        _onethree.visible = FALSE;
    }
    
    if ([[GameData sharedInstance]starsFor:2] == 3) {
        _twoone.visible = TRUE;
        _twotwo.visible = TRUE;
        _twothree.visible = TRUE;
    }
    else if ([[GameData sharedInstance]starsFor:2] == 2) {
        _twoone.visible = TRUE;
        _twotwo.visible = TRUE;
        _twothree.visible = FALSE;
    }
    else if ([[GameData sharedInstance]starsFor:2] == 1) {
        _twoone.visible = TRUE;
        _twotwo.visible = FALSE;
        _twothree.visible = FALSE;
    }
    else {
        _twoone.visible = FALSE;
        _twotwo.visible = FALSE;
        _twothree.visible = FALSE;
    }

    if ([[GameData sharedInstance]starsFor:3] == 3) {
        _threeone.visible = TRUE;
        _threetwo.visible = TRUE;
        _threethree.visible = TRUE;
    }
    else if ([[GameData sharedInstance]starsFor:3] == 2) {
        _threeone.visible = TRUE;
        _threetwo.visible = TRUE;
        _threethree.visible = FALSE;
    }
    else if ([[GameData sharedInstance]starsFor:3] == 1) {
        _threeone.visible = TRUE;
        _threetwo.visible = FALSE;
        _threethree.visible = FALSE;
    }
    else {
        _threeone.visible = FALSE;
        _threetwo.visible = FALSE;
        _threethree.visible = FALSE;
    }
    
    if ([[GameData sharedInstance]starsFor:4] == 3) {
        _fourone.visible = TRUE;
        _fourtwo.visible = TRUE;
        _fourthree.visible = TRUE;
    }
    else if ([[GameData sharedInstance]starsFor:4] == 2) {
        _fourone.visible = TRUE;
        _fourtwo.visible = TRUE;
        _fourthree.visible = FALSE;
    }
    else if ([[GameData sharedInstance]starsFor:4] == 1) {
        _fourone.visible = TRUE;
        _fourtwo.visible = FALSE;
        _fourthree.visible = FALSE;
    }
    else {
        _fourone.visible = FALSE;
        _fourtwo.visible = FALSE;
        _fourthree.visible = FALSE;
    }
    
    if ([[GameData sharedInstance]starsFor:5] == 3) {
        _fiveone.visible = TRUE;
        _fivetwo.visible = TRUE;
        _fivethree.visible = TRUE;
    }
    else if ([[GameData sharedInstance]starsFor:5] == 2) {
        _fiveone.visible = TRUE;
        _fivetwo.visible = TRUE;
        _fivethree.visible = FALSE;
    }
    else if ([[GameData sharedInstance]starsFor:5] == 1) {
        _fiveone.visible = TRUE;
        _fivetwo.visible = FALSE;
        _fivethree.visible = FALSE;
    }
    else {
        _fiveone.visible = FALSE;
        _fivetwo.visible = FALSE;
        _fivethree.visible = FALSE;
    }
    
    if ([[GameData sharedInstance]starsFor:6] == 3) {
        _sixone.visible = TRUE;
        _sixtwo.visible = TRUE;
        _sixthree.visible = TRUE;
    }
    else if ([[GameData sharedInstance]starsFor:6] == 2) {
        _sixone.visible = TRUE;
        _sixtwo.visible = TRUE;
        _sixthree.visible = FALSE;
    }
    else if ([[GameData sharedInstance]starsFor:6] == 1) {
        _sixone.visible = TRUE;
        _sixtwo.visible = FALSE;
        _sixthree.visible = FALSE;
    }
    else {
        _sixone.visible = FALSE;
        _sixtwo.visible = FALSE;
        _sixthree.visible = FALSE;
    }
    if ([[GameData sharedInstance]starsFor:7] == 3) {
        _sevenone.visible = TRUE;
        _seventwo.visible = TRUE;
        _seventhree.visible = TRUE;
    }
    else if ([[GameData sharedInstance]starsFor:7] == 2) {
        _sevenone.visible = TRUE;
        _seventwo.visible = TRUE;
        _seventhree.visible = FALSE;
    }
    else if ([[GameData sharedInstance]starsFor:7] == 1) {
        _sevenone.visible = TRUE;
        _seventwo.visible = FALSE;
        _seventhree.visible = FALSE;
    }
    else {
        _seventhree.visible = FALSE;
        _seventwo.visible = FALSE;
        _sevenone.visible = FALSE;
    }
    if ([[GameData sharedInstance]starsFor:8] == 3) {
        _eightone.visible = TRUE;
        _eighttwo.visible = TRUE;
        _eightthree.visible = TRUE;
    }
    else if ([[GameData sharedInstance]starsFor:8] == 2) {
        _eightone.visible = TRUE;
        _eighttwo.visible = TRUE;
        _eightthree.visible = FALSE;
    }
    else if ([[GameData sharedInstance]starsFor:8] == 1) {
        _eightone.visible = TRUE;
        _eighttwo.visible = FALSE;
        _eightthree.visible = FALSE;
    }
    else {
        _eightone.visible = FALSE;
        _eighttwo.visible = FALSE;
        _eightthree.visible = FALSE;
    }
}

- (void) update:(CCTime)delta {
    if(_evil.position.x > -250 && _evil.position.x < [CCDirector sharedDirector].viewSize.width-20) {
        
        CCParticleSystem *flame = (CCParticleSystem *)[CCBReader load:@"smoke"];
        flame.autoRemoveOnFinish = TRUE;
        flame.position = ccp((_evil.position.x + 70), _evil.position.y);
        [self addChild:flame];
    }
}

- (void)enable:(NSInteger)level {
    if (level == 2) {
        leveltwobutton.enabled = YES;
    }
    else if (level == 3) {
        levelthreebutton.enabled = YES;
    }
    else if (level == 4) {
        levelfourbutton.enabled = YES;
    }
    else if (level == 5) {
        levelfivebutton.enabled = YES; 
    }
    else if (level == 6) {
        levelsixbutton.enabled = YES;
    }
    else if (level == 7) {
        levelsevenbutton.enabled = YES;
    }
    else if (level == 8) {
        leveleightbutton.enabled = YES;
    }
}

- (void)levelone {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    Gameplay *gameplayScene = (Gameplay*)[CCBReader loadAsScene:@"Gameplay"];
    [[GameData sharedInstance] setLevel:1];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)leveltwo {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    Gameplay *gameplayScene = (Gameplay*)[CCBReader loadAsScene:@"Gameplay"];
    [[GameData sharedInstance] setLevel:2];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)levelthree {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    Gameplay *gameplayScene = (Gameplay*)[CCBReader loadAsScene:@"Gameplay"];
    [[GameData sharedInstance] setLevel:3];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)levelfour {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    Gameplay *gameplayScene = (Gameplay*)[CCBReader loadAsScene:@"Gameplay"];
    [[GameData sharedInstance] setLevel:4];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)levelfive {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    Gameplay *gameplayScene = (Gameplay*)[CCBReader loadAsScene:@"Gameplay"];
    [[GameData sharedInstance] setLevel:5];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)levelsix {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    Gameplay *gameplayScene = (Gameplay*)[CCBReader loadAsScene:@"Gameplay"];
    [[GameData sharedInstance] setLevel:6];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)levelseven {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    Gameplay *gameplayScene = (Gameplay*)[CCBReader loadAsScene:@"Gameplay"];
    [[GameData sharedInstance] setLevel:7];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

- (void)leveleight {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    Gameplay *gameplayScene = (Gameplay*)[CCBReader loadAsScene:@"Gameplay"];
    [[GameData sharedInstance] setLevel:8];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end

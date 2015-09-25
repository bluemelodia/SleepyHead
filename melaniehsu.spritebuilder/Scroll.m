//
//  Scroll.m
//  melaniehsu
//
//  Created by Melanie Hsu on 8/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Scroll.h"

@implementation Scroll

-(void)skip {
    /*if (playing) {
     [self.source stop];
     self.source = nil;
     playing = FALSE;
     }*/
    //self.source = [[OALSimpleAudio sharedInstance] playEffect:@"musicBG.wav" loop:YES];
    //playing = TRUE;
    //[audio stopBg];
    //audio = [OALSimpleAudio sharedInstance];
    // play background sound
    //[audio playBg:@"musicBG.wav" loop:TRUE];
    
    CCScene *home = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:home];
    //OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    //[audio playBg:@"musicboxBG" loop:TRUE];
}

@end

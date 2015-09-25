//
//  Opening.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Opening.h"

@implementation Opening {
    OALSimpleAudio *audio;
    CCScrollView *_scroll;
    BOOL playing;
    int i;
    int j;
    BOOL cancelScroll;
}

- (void) didLoadFromCCB {
    /*if (playing) {
        [self.source stop];
        self.source = nil;
        playing = FALSE;
    }*/
    // access audio object
    self.userInteractionEnabled = TRUE;
   /* [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"musicBG.wav" loop:TRUE];*/
    //self.source = [[OALSimpleAudio sharedInstance] playEffect:@"pianoBG.wav" loop:YES];
    //[[OALSimpleAudio sharedInstance] playBg:<#(NSString *)#> loop:];
    //[[OALSimpleAudio sharedInstance] ]
    i = 2;
    j= 1;
    cancelScroll = FALSE;
    
}

-(void) update:(CCTime)delta {
    if (i<1200 && !cancelScroll) {
    i+=j;
    [_scroll setScrollPosition:ccp(0, i/2) animated:NO];
    }
//    if (i> 200) {
//        j=-1;
//    }
//    if (i==0) {
//        j=0;
//    }

}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    cancelScroll = TRUE;
}


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

    CCScene *home = [CCBReader loadAsScene:@"Select"];
    [[CCDirector sharedDirector] replaceScene:home];
    //OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    //[audio playBg:@"musicboxBG" loop:TRUE];
    
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
}

@end

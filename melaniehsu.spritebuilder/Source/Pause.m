//
//  Pause.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/25/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Pause.h"
#import "Gameplay.h"
#import "GameData.h"

@implementation Pause {
    CCLabelTTF *_stars;
}

- (void)didLoadFromCCB {
    _stars.string = [NSString stringWithFormat:@"%d",[[GameData sharedInstance] stars]];
}

- (void)leave {
    CCScene *home = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:home];
}

- (void)repeat {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)resume {
}

@end

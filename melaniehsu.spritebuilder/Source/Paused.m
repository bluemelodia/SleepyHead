//
//  Paused.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Paused.h"
#import "Gameplay.h"
#import "GameData.h"

@implementation Paused {
    CCLabelTTF *_stars;
}

- (void)didLoadFromCCB {
    _stars.string = [NSString stringWithFormat:@"%d",[[GameData sharedInstance] stars]];
}

- (void)restart {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)resume {
    
}

@end

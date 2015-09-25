//
//  MainScene.m
//  melanie-hsu
//
//  Created by Melanie Hsu on 7/8/14.
//  Copyright (c) 2014 Melanie Hsu. All rights reserved.
//

#import "MainScene.h"

@implementation MainScene
- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}
    
@end

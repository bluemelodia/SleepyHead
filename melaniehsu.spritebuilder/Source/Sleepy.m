//
//  Sleepy.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/10/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Sleepy.h"

@implementation Sleepy
- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"sleepy";
}

- (void)gotHit {
    NSLog(@"OWWW!");
}

@end

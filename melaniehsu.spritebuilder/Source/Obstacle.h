//
//  Obstacle.h
//  melaniehsu
//
//  Created by Melanie Hsu on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
@class Gameplay;

@interface Obstacle : CCSprite

@property (nonatomic, weak) Gameplay* gameplayLayer;
@property (nonatomic, assign) NSInteger density;
@property (nonatomic, assign) NSInteger health;
@property (nonatomic, assign) BOOL collided;
@property (nonatomic, assign) BOOL removed;
@property (nonatomic, assign) BOOL smashed;
@property (nonatomic, assign) float timeSinceCollision;
+(Obstacle*)initObstacleForLevel:(NSInteger)rand;
+ (Obstacle*)initObstacleForRocket:(NSInteger)rand;

@end

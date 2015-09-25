//
//  Obstacle.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Obstacle.h"
#import "Gameplay.h"
#import "Heavy.h"
#import "Medium.h"
#import "Light.h"
#import "Parachute.h" 
#import "GameData.h"
#import "Ness.h"

@implementation Obstacle {
    //CCNode *_mouseJointNode; //the flicking mech node
    //CCPhysicsJoint *_mouseJoint;
}

//- (void)didLoadFromCCB {
//    self.userInteractionEnabled = YES;
//}

+ (Obstacle*)initObstacleForLevel:(NSInteger)rand { //initObstacleForLevel (take int, based on that int, set how the rand gen works
    int random = arc4random_uniform(rand);
    Obstacle *newObstacle;
    newObstacle.collided = false;
    newObstacle.timeSinceCollision = 0;
    newObstacle.removed = false;
    newObstacle.smashed = false;
    switch (random) {
        case 0:
            newObstacle = (Obstacle*)[CCBReader load:@"Light"];
            break;
        case 1:
            newObstacle = (Obstacle*)[CCBReader load:@"Medium"];
            break;
        case 2:
            newObstacle = (Obstacle*)[CCBReader load:@"Heavy"];
            break;
        case 3:
            newObstacle = (Obstacle*)[CCBReader load:@"Parachute"];
            break;
        case 4:
            newObstacle = (Obstacle*)[CCBReader load:@"Diver"];
            newObstacle.health = 3;
            break;
        case 5:
            newObstacle = (Obstacle*)[CCBReader load:@"Ness"];
            newObstacle.health = 4;
            break;
        }
    
    
    return newObstacle;
}

+ (Obstacle*)initObstacleForRocket:(NSInteger)rand {
    int random = arc4random_uniform(rand);
    Obstacle *newObstacle;
    newObstacle.collided = false;
    newObstacle.timeSinceCollision = 0;
    newObstacle.removed = false;
    newObstacle.smashed = false;
    switch (random) {
        case 0:
            newObstacle = (Obstacle*)[CCBReader load:@"Light"];
            break;
        case 1:
            newObstacle = (Obstacle*)[CCBReader load:@"Medium"];
            break;
        case 2:
            newObstacle = (Obstacle*)[CCBReader load:@"Heavy"];
            break;
        case 3:
            newObstacle = (Obstacle*)[CCBReader load:@"Parachute"];
            break;
        case 4:
            newObstacle = (Obstacle*)[CCBReader load:@"Diver"];
            newObstacle.health = 5;
            break;
        case 5:
            newObstacle = (Obstacle*)[CCBReader load:@"Ness"];
            newObstacle.health = 4;
            break;
    }
    return newObstacle;

}


//- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//    [self.gameplayLayer touchMoved:(UITouch *)touch withEvent:(UIEvent *)event];    
//}
//
//- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
//    [self.gameplayLayer touchMoved:(UITouch *)touch withEvent:(UIEvent *)event];
//}
//
//- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
//    [self.gameplayLayer touchEnded:(UITouch *)touch withEvent:(UIEvent *)event];
//}

@end

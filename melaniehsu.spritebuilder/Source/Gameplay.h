//
//  Gameplay.h
//  melaniehsu
//
//  Created by Melanie Hsu on 7/8/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Turtle.h"
#import "Obstacle.h"

@interface Gameplay : CCScene <CCPhysicsCollisionDelegate>

@property (nonatomic, strong) CCPhysicsNode *physics; //reference node that simulates physics
@property (nonatomic, assign) NSInteger score; //the sleepy head's health
@property (nonatomic, assign) double hours; //the round's time
@property (nonatomic, assign) NSInteger level; //what level we are on
@property (nonatomic, assign) BOOL started;
@property (nonatomic, assign) NSInteger streakNumber;


//@property (nonatomic, strong) CCNode *_mouseJointNode; //the flicking mech node
//@property (nonatomic, strong) CCPhysicsJoint *_mouseJoint;//- (void)initialize;

//-(void)startedTouchOn:(Obstacle*)obstacle;
//-(void)movedTouchBy:(CGPoint)positionDifference;
- (void)readySetGo;
-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event;
- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event;
- (NSInteger)incrementLevel;

@end

//
//  Tutorial.h
//  melaniehsu
//
//  Created by Melanie Hsu on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Turtle.h"
#import "Obstacle.h"

@interface Tutorial : CCScene <CCPhysicsCollisionDelegate>

@property (nonatomic, strong) CCPhysicsNode *physics; //reference node that simulates physics
@property (nonatomic, assign) NSInteger score; //the sleepy head's health
@property (nonatomic, assign) double hours; //the round's time
@property (nonatomic, assign) NSInteger level; //what level we are on

@end

//
//  Tutorial.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/28/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tutorial.h"
#import "Gameplay.h"
#import "Turtle.h"
#import "Obstacle.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "GameEnd.h"
#import "CCAnimationManager.h"
#import "Win.h"
#import "CCPhysicsTouchNode.h"
#import "Directions.h"
//#import "Pause.h"
#import "GameData.h"


float ohSnap; //snap the joint after a certain amount of time!

//float flicked; //limit flicking to every 1/2 to 3/4 second so the user can't "chain"

@implementation Tutorial {
    //CCNode *_mouseJointNode; //the flicking mech node
    //CCPhysicsJoint *_mouseJoint;//- (void)initialize;
    CCNode *_turtle; //stores instance of turtle
    CGRect boundingBox; //bounding box of the object
    CCNode *_object; //spawned object
    CCPhysicsNode *_physicsNode;
    
    CCNode *_popup;
    CCLabelTTF *_paused;
    CCButton *_home;
    CCButton *_repeat;
    CCButton *_resume;
    CCLabelTTF *_stars;
    CCSprite *_startag;
    CCButton *_stop;
    
    Boolean left; //is turtle left (if false, turtle is right)
    //Boolean joint;
    float time; //time
    float timeSinceSpawn;
    float timeSinceDeploy;
    float spawnSpeed; //how fast to spawn objects from the plane
    float deploySpeed; //how fast to spawn objects from the rocket
    NSMutableArray *array;
    CCSprite *_plane;
    CCSprite *_rocket;
    CCSprite *_bubble;
    CCNode *_sleepyHit;
    CCLabelTTF *_health;
    CCLabelTTF *_night;
    CCLabelTTF *_clock;
    CCLabelTTF *_streak;
    CCLabelTTF *_points; //round points
    CCLabelTTF *_highScore;
    CCNode *_edge;
    bool called; //the game over/win method should only be called once
    CCPhysicsTouchNode *_touchNode;
    bool start; //freeze gameplay to play the beginning
    bool stopped;
    bool won;
    NSInteger streak; //determine multiplier bonus by how many missed
    NSInteger pts;
}

#pragma mark - Level Start
- (void)didLoadFromCCB {
    //passes in the levelStart method as an object
    //[self performSelector:@selector(levelStart) withObject:nil afterDelay:2.0f];
    
    //tell this scene to accept touches
    //self.userInteractionEnabled = TRUE;
    
    //    _turtle = [CCBReader load:@"Turtle"];
    _plane.physicsBody.collisionMask = @[];
    _rocket.physicsBody.collisionMask = @[];
    _turtle.physicsBody.collisionMask = @[];
    _bubble.physicsBody.collisionMask = @[];
    _bubble.zOrder = 0;
    _health.zOrder = 1;
    //_sleepyHit = [CCBReader load:@"sleepyHit"];
    //_sleepyHit.position = ccp(154.3, 71.7);
    //_clock.zOrder = 0;
    /*
     if (![[NSUserDefaults standardUserDefaults] integerForKey:@"Level Number"]) {
     [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Level Number"]; //set this to level one to get the user to be able to play one again
     }
     [GameData sharedInstance].level = [[NSUserDefaults standardUserDefaults] integerForKey:@"Level Number"]; //stores the info on the phone
     */
    //countdown before each level
    start = FALSE;
    won = FALSE;
    streak = 0;
    NSString *string = [NSString stringWithFormat:@""];
    _highScore.string = [NSString stringWithFormat:@""];
    stopped = FALSE;
    _stop.enabled = YES;
    _paused.visible = FALSE;
    _popup.visible = FALSE;
    _home.visible = FALSE;
    _home.enabled = FALSE;
    _repeat.visible = FALSE;
    _repeat.enabled = FALSE;
    _resume.visible = NO;
    _resume.enabled = NO;
    _stars.visible = FALSE;
    _startag.visible = FALSE;
    
    //TODO: make sure this works
    pts = 0;
    _night.string = string;
    /*if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Tutorial"]) {
     [[self animationManager] runAnimationsForSequenceNamed:@"Tutorial"];
     [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"Tutorial"];
     [self performSelector:@selector(runStart) withObject:nil afterDelay:6.0];
     }
     else {
     [self runStart];
     }*/
    //[self runStart];
    //[self readySetGo];
    
    won = FALSE;
    _points.string = @"0";

        _night.string = @"Night 0";
        spawnSpeed = 0.5;
        _physicsNode.gravity = ccp(0, -200);
        //_highScore.string = [NSString stringWithFormat:@"Best: %ld", (long)[[GameData sharedInstance] getScore:1]];
    
    
    time = 0.0;
    timeSinceSpawn = 0.0;
    timeSinceDeploy = 0.0;
    
    left = false;
    //joint = false;
    //self.physics = _physicsNode;
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = TRUE;
    _physicsNode.debugDraw = NO;
    
    //sign up as the collision delegate of our physics node
    _physicsNode.collisionDelegate = self;
    
    //initialize array for storing objects
    array = [NSMutableArray array];
    self.score = 5;
    //NSLog(@"%d START", self.score);
    self.hours = 0;
    
    [self spawn];
    start = TRUE;
    
}

#pragma mark pause button
- (BOOL)paused {
    //Pause *pausedPopover = (Pause *)[CCBReader load:@"Pause"];
    //pausedPopover.positionType = CCPositionTypeNormalized;
    //pausedPopover.position = ccp(0.5, 0.5);
    //pausedPopover.zOrder = INT_MAX;
    _stars.string = [NSString stringWithFormat:@"%d",[[GameData sharedInstance] stars]];
    
    if (!stopped) {
        [_physicsNode setPaused:YES];
        [[_plane animationManager] setPaused:TRUE];
        [[_rocket animationManager] setPaused:TRUE];
        //  [self addChild:pausedPopover];
        _popup.visible = YES;
        _home.visible = YES;
        _home.enabled = YES;
        _repeat.visible = YES;
        _repeat.enabled = YES;
        _resume.visible = YES;
        _resume.enabled = YES;
        _paused.visible = YES;
        _stars.visible = YES;
        _startag.visible = YES;
        //get spawning to stop
        return stopped = true;
    }
    else {
        [_physicsNode setPaused:NO];
        // [_plane setPaused:NO];
        // [_rocket setPaused:NO];
        [[_plane animationManager] setPaused:FALSE];
        [[_rocket animationManager] setPaused:FALSE];
        //_rocket.physicsBody.velocity = rocketSpeed;
        //_plane.physicsBody.velocity = planeSpeed;
        /*if (paused) {
         [self removeChild:pausedPopover];
         }*/
        _popup.visible = NO;
        _home.visible = NO;
        _home.enabled = NO;
        _repeat.visible = NO;
        _repeat.enabled = NO;
        _resume.visible = NO;
        _resume.enabled = NO;
        _paused.visible = NO;
        _stars.visible = NO;
        _startag.visible = NO;
        return stopped = false;
    }
}

- (void)home {
    CCScene *leave = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:leave];
}

- (void)resume {
    [_physicsNode setPaused:NO];
    // [_plane setPaused:NO];
    // [_rocket setPaused:NO];
    [[_plane animationManager] setPaused:FALSE];
    [[_rocket animationManager] setPaused:FALSE];
    //_rocket.physicsBody.velocity = rocketSpeed;
    //_plane.physicsBody.velocity = planeSpeed;
    /*if (paused) {
     [self removeChild:pausedPopover];
     }*/
    _popup.visible = NO;
    _home.visible = NO;
    _home.enabled = NO;
    _repeat.visible = NO;
    _repeat.enabled = NO;
    _resume.visible = NO;
    _resume.enabled = NO;
    _paused.visible = NO;
    _stars.visible = NO;
    _startag.visible = NO;
    stopped = false;
}

- (void)repeat {
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)setScore:(NSInteger)score {
    _score = score;
    //_health.string = [NSString stringWithFormat:@"%d", score];
    
    if (score == 5)
        _health.string = @"zzzzz..";
    else if (score == 4)
        _health.string = @"zzzz..";
    else if (score == 3)
        _health.string = @"zzz..";
    else if (score == 2)
        _health.string = @"zz..";
    else if (score == 1)
        _health.string = @"z..";
    else
        _health.string = @"OUCH!!!";
}

- (void)readySetGo {
    won = FALSE;
    _points.string = @"0";
    switch ([GameData sharedInstance].level) {
        case 1:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level One"];
            _night.string = @"Night 1";
            spawnSpeed = 0.5;
            _physicsNode.gravity = ccp(0, -200);
            _highScore.string = [NSString stringWithFormat:@"Best: %ld", (long)[[GameData sharedInstance] getScore:1]];
            break;
        case 2:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Two"];
            _night.string = @"Night 2";
            spawnSpeed = 0.5;
            _physicsNode.gravity = ccp(0, -210);
            _highScore.string = [NSString stringWithFormat:@"Best: %ld", (long)[[GameData sharedInstance] getScore:2]];
            break;
        case 3:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Three"];
            _night.string = @"Night 3";
            spawnSpeed = 0.45;
            _physicsNode.gravity = ccp(0, -220);
            _highScore.string = [NSString stringWithFormat:@"Best: %ld", (long)[[GameData sharedInstance] getScore:3]];
            break;
        case 4:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Four"];
            _night.string = @"Night 4";
            spawnSpeed = 0.55; //0.45 formerly
            deploySpeed = 0.8;
            _physicsNode.gravity = ccp(0, -200);
            _highScore.string = [NSString stringWithFormat:@"Best: %ld", (long)[[GameData sharedInstance] getScore:4]];
            break;
        case 5:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Five"];
            _night.string = @"Night 5";
            spawnSpeed = 0.45;
            deploySpeed = 0.75;
            _physicsNode.gravity = ccp(0, -210);
            _highScore.string = [NSString stringWithFormat:@"Best: %ld", (long)[[GameData sharedInstance] getScore:5]];
            break;
    }
    
    time = 0.0;
    timeSinceSpawn = 0.0;
    timeSinceDeploy = 0.0;
    
    left = false;
    //joint = false;
    //self.physics = _physicsNode;
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = TRUE;
    _physicsNode.debugDraw = NO;
    
    //sign up as the collision delegate of our physics node
    _physicsNode.collisionDelegate = self;
    
    //initialize array for storing objects
    array = [NSMutableArray array];
    self.score = 5;
    //NSLog(@"%d START", self.score);
    self.hours = 0;
    
    [self spawn];
    start = TRUE;
}

#pragma mark - Time-Related Things
- (void)setTime:(double)time {
    if (_hours == 0) {
        _clock.string = @"12:00am";
    }
    else if (_hours == 0.25) {
        _clock.string = @"12:15am";
    }
    else if (_hours == 0.5) {
        _clock.string = @"12:30am";
    }
    else if (_hours == 0.75) {
        _clock.string = @"12:45am";
    }
    else if (_hours == 1) {
        _clock.string = @"1:00am";
    }
    else if (_hours == 1.25) {
        _clock.string = @"1:15am";
    }
    else if (_hours == 1.5) {
        _clock.string = @"1:30am";
    }
    else if (_hours == 1.75) {
        _clock.string = @"1:45am";
    }
    else if (_hours == 2) {
        _clock.string = @"2:00am";
    }
    else if (_hours == 2.25) {
        _clock.string = @"2:15am";
    }
    else if (_hours == 2.5) {
        _clock.string = @"2:30am";
    }
    else if (_hours == 2.75) {
        _clock.string = @"2:45am";
    }
    else if (_hours == 3) {
        _clock.string = @"3:00am";
    }
    else if (_hours == 3.25) {
        _clock.string = @"3:15am";
    }
    else if (_hours == 3.5) {
        _clock.string = @"3:30am";
    }
    else if (_hours == 3.75) {
        _clock.string = @"3:45am";
    }
    else if (_hours == 4) {
        _clock.string = @"4:00am";
    }
    else if (_hours == 4.25) {
        _clock.string = @"4:15am";
    }
    else if (_hours == 4.5) {
        _clock.string = @"4:30am";
    }
    else if (_hours == 4.75) {
        _clock.string = @"4:45am";
    }
    else if (_hours == 5) {
        _clock.string = @"5:00am";
    }
    else if (_hours == 5.25) {
        _clock.string = @"5:15am";
    }
    else if (_hours == 5.5) {
        _clock.string = @"5:30am";
    }
    else if (_hours == 5.75) {
        _clock.string = @"5:45am";
    }
    else if (_hours == 6) {
        _clock.string = @"6:00am";
    }
    /* else if (_hours == 6.25) {
     _clock.string = @"6:15am";
     }
     else if (_hours == 6.5) {
     _clock.string = @"6:30am";
     }
     else if (_hours == 6.75) {
     _clock.string = @"6:45am";
     }
     else if (_hours == 7) {
     _clock.string = @"7:00am";
     }
     else if (_hours == 7.25) {
     _clock.string = @"7:15am";
     }
     else if (_hours == 7.5) {
     _clock.string = @"7:30am";
     }
     else if (_hours == 7.75) {
     _clock.string = @"7:45am";
     }
     else if (_hours == 8){
     _clock.string = @"8:00am";
     }*/
}

- (void)update:(CCTime)delta {
    for (Obstacle *obstacle in array) {
        //if obstacle has left the screen, increase score
        //NSLog(@"%f %f", obstacle.position.x, obstacle.position.y);
        if (!called && obstacle.visible == TRUE && (obstacle.position.x < 0 || obstacle.position.x > [CCDirector sharedDirector].viewSize.width || obstacle.position.y > [CCDirector sharedDirector].viewSize.height)) {
            obstacle.visible = FALSE;
            streak++;
            
            //points determination factor
            if (streak < 100) {
                pts = pts + 1.2*streak;
            }
            else if (100 <= streak < 250) {
                pts = pts + 1.4*streak;
            }
            else if (250 <= streak <= 500) {
                pts = pts + 1.6*streak;
            }
            else if (500 <= streak < 1000) {
                pts = pts + 1.8*streak;
            }
            else {
                pts = pts + 2.0*streak;
            }
            NSString *point = [NSString stringWithFormat:@"%d", pts];
            _points.string = point;
            NSString *chain = [NSString stringWithFormat:@"x %d", streak];
            _streak.string = chain;
        }
    }
    
    if (start && !stopped) {
        time += delta;
        timeSinceSpawn += delta;
        timeSinceDeploy += delta;
        ohSnap += delta;
        if (time <= 61 && !won) {
            if ([GameData sharedInstance].level >= 4 && 20 < _rocket.position.x && _rocket.position.x < [CCDirector sharedDirector].viewSize.width-20 && timeSinceDeploy > deploySpeed) {
                [self deploy];
                timeSinceDeploy = 0.0;
            }
            
            if (timeSinceSpawn > spawnSpeed) {
                [self spawn];
                
                if (!called) {
                    if (time >= 60) {
                        self.hours = 6;
                        [self setTime:6];
                        [self determineScore:pts];
                        [self win];
                    }
                    else if (time >= 57.5) {
                        self.hours = 5.75;
                        [self setTime:5.75];
                    }
                    else if (time >= 55.0) {
                        self.hours = 5.5;
                        [self setTime:5.5];
                    }
                    else if (time >= 52.5) {
                        self.hours = 5.25;
                        [self setTime:5.25];
                    }
                    else if (time >= 50) {
                        self.hours = 5;
                        [self setTime:5];
                    }
                    else if (time >= 47.5) {
                        self.hours = 4.75;
                        [self setTime:4.75];
                    }
                    else if (time >= 45.0) {
                        self.hours = 4.5;
                        [self setTime:4.5];
                    }
                    else if (time >= 42.5) {
                        self.hours = 4.25;
                        [self setTime:4.25];
                    }
                    else if (time >= 40) {
                        self.hours = 4;
                        [self setTime:4];
                    }
                    else if (time >= 37.5) {
                        self.hours = 3.75;
                        [self setTime:3.75];
                    }
                    else if (time >= 35.0) {
                        self.hours = 3.5;
                        [self setTime:3.5];
                    }
                    else if (time >= 32.5) {
                        self.hours = 3.25;
                        [self setTime:3.25];
                    }
                    else if (time >= 30) {
                        self.hours = 3;
                        [self setTime:3];
                    }
                    else if (time >= 27.5) {
                        self.hours = 2.75;
                        [self setTime:2.75];
                    }
                    else if (time >= 25.0) {
                        self.hours = 2.5;
                        [self setTime:2.5];
                    }
                    else if (time >= 22.5) {
                        self.hours = 2.25;
                        [self setTime:2.25];
                    }
                    else if (time >= 20) {
                        self.hours = 2;
                        [self setTime:2];
                    }
                    else if (time >= 17.5) {
                        self.hours = 1.75;
                        [self setTime:1.75];
                    }
                    else if (time >= 15.0) {
                        self.hours = 1.5;
                        [self setTime:1.5];
                    }
                    else if (time >= 12.5) {
                        self.hours = 1.25;
                        [self setTime:1.25];
                    }
                    else if (time >= 10) {
                        self.hours = 1;
                        [self setTime:1];
                    }
                    else if (time >= 7.5) {
                        self.hours = 0.75;
                        [self setTime:0.75];
                    }
                    else if (time >= 5.0) {
                        self.hours = 0.5;
                        [self setTime:0.5];
                    }
                    else if (time >= 2.5) {
                        self.hours = 0.25;
                        [self setTime:0.25];
                    }
                    else {
                        self.hours = 0;
                        [self setTime:0];
                    }
                }
                timeSinceSpawn = 0.0;
            }
        }
    }
}

#pragma mark - Turtles Throwing Things
//spawn obstacles for turtle to push
- (void)spawn {
    Obstacle *obstacle;
    if ([GameData sharedInstance].level == 1) {
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)2]; //first level, only light and medium
    }
    else if ([GameData sharedInstance].level <= 4) {
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)3]; //second level, heavy objects come in
    }
    else {
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)4]; //parachuting turtles begin spawning on level 5
    }
    
    obstacle.gameplayLayer = self;
    obstacle.position = ccpSub(_plane.position, ccp(0, 25));
    //obstacle.physicsBody.collisionType = @"items";
    //obstacle.physicsBody.collisionMask = @[@"items"];
    
    obstacle.zOrder = 2;
    boundingBox = obstacle.boundingBox;
    boundingBox.origin = [obstacle.parent convertToWorldSpace:boundingBox.origin];
    [_physicsNode addChild:obstacle]; //add object to the physics world
    //
    NSAssert(obstacle.parent != nil, @"Bodies connected by a joint must be added to the same CCPhysicsNode.");
    
    [array addObject:obstacle]; //add object to the array
    
    //obstacle.position = _plane.position;
}

- (void)deploy {
    Obstacle *obstacle;
    if ([GameData sharedInstance].level == 4) {
        obstacle = [Obstacle initObstacleForRocket:(NSInteger)2];
    }
    else if ([GameData sharedInstance].level == 5) {
        obstacle = [Obstacle initObstacleForRocket:(NSInteger)3];
    }
    else {
        obstacle = [Obstacle initObstacleForRocket:(NSInteger)4];
    }
    
    obstacle.gameplayLayer = self;
    obstacle.position = ccpSub(_rocket.position, ccp(0, 25));
    
    //obstacle.physicsBody.collisionType = @"items";
    //obstacle.physicsBody.collisionMask = @[@"items"];
    
    obstacle.zOrder = 1;
    boundingBox = obstacle.boundingBox;
    boundingBox.origin = [obstacle.parent convertToWorldSpace:boundingBox.origin];
    [_physicsNode addChild:obstacle]; //add object to the physics world
    //
    NSAssert(obstacle.parent != nil, @"Bodies connected by a joint must be added to the same CCPhysicsNode.");
    
    [array addObject:obstacle];
}

#pragma mark - Collisions

//if an obstacle collides with the ceiling, remove it from play
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair obstacle:(CCNode *)nodeA obstacle:(CCNode *)nodeB {
    return false;
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair obstacle:(Obstacle *)nodeA edge:(CCNode *)nodeB {
    nodeA.visible = FALSE;
    nodeA.physicsBody.collisionMask = @[];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair sleepy:(CCNode *)nodeA obstacle:(Obstacle *)nodeB {
    //NSLog(@"density: %d", nodeB.density);
    
    if (!called && !nodeB.collided) {
        if (nodeB.density < 25){ //light object effects
            self.score--;
            //_sleepyHit.opacity = 1.0;
            
            nodeB.collided = true;
            //NSLog(@"%d", self.score);
        }
        else if (nodeB.density < 50) { //medium object effects
            self.score = self.score/2;
            //_sleepyHit.opacity = 1.0;
            nodeB.collided = true;
            //NSLog(@"%d", self.score);
        }
        else { //heavy object effects
            self.score = self.score - 5; //game over!
            //_sleepyHit.opacity = 1.0;
            nodeB.collided = true;
            //NSLog(@"%d", self.score);
        }
        
        if (self.score <= 0) {
            //_sleepyHit.opacity = 0.0;
            [self lose];
        }
        
        _sleepyHit.opacity = 0.0;
        streak = 0;
        _streak.string = @"";
        
        [[_physicsNode space] addPostStepBlock:^{
            //[self obstacleRemoved:nodeB];
            CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Impact"];
            explosion.autoRemoveOnFinish = TRUE;
            explosion.position = nodeB.position;
            [nodeB.parent addChild:explosion];
            nodeB.visible = FALSE;
        } key:nodeB];
    }
}

//hit the ceiling - want the visibilty to fall - collisionMask of the object becomes empty so it won't collide with anything

- (void)obstacleRemoved:(Obstacle *)obstacle {
    if (!obstacle.removed) {
        [obstacle removeFromParent];
        [array removeObject:obstacle];
        obstacle.removed = true;
    }
}

#pragma mark Start of each level...
- (void)startWithPopup:(NSString*)message {
    GameEnd *gameEndPopover = (GameEnd *)[CCBReader load:@"Directions"];
    gameEndPopover.positionType = CCPositionTypeNormalized;
    gameEndPopover.position = ccp(0.5, 0.5);
    gameEndPopover.zOrder = INT_MAX;
    [gameEndPopover setMessage:message score:self.hours];
    [self addChild:gameEndPopover];
}

#pragma mark The end...?
- (void)win {
    _stop.enabled = NO;
    [self endGameWithMessageWin:@"Survived to sunrise!"];
    //    [GameData sharedInstance].level++;
    NSLog(@"%ld", (long)[GameData sharedInstance].level);
    //[[NSUserDefaults standardUserDefaults] setInteger:[GameData sharedInstance].level forKey:@"Level Number"];
    won = TRUE;
}

- (void)lose {
    _stop.enabled = NO;
    [self endGameWithMessageLose:@"A rude awakening!"];
}

- (void)endGameWithMessageLose:(NSString*)message {
    if (!called) {
        GameEnd *gameEndPopover = (GameEnd *)[CCBReader load:@"GameEnd"];
        gameEndPopover.positionType = CCPositionTypeNormalized;
        gameEndPopover.position = ccp(0.5, 0.5);
        gameEndPopover.zOrder = INT_MAX;
        [gameEndPopover setMessage:message score:self.hours];
        [self addChild:gameEndPopover];
        called = true;
    }
}

- (void)endGameWithMessageWin:(NSString*)message {
    if (!called) {
        Win *gameEndPopover = (Win *)[CCBReader load:@"Win"];
        gameEndPopover.positionType = CCPositionTypeNormalized;
        gameEndPopover.position = ccp(0.5, 0.5);
        gameEndPopover.zOrder = INT_MAX;
        [gameEndPopover setMessage:message score:self.hours];
        
        gameEndPopover.gameplayLayer = self;
        [self addChild:gameEndPopover];
        [gameEndPopover starDisplay];
        called = true;
        
        for (Obstacle *obstacle in array) {
            obstacle.visible = FALSE;
        }
    }
}

- (NSInteger)incrementLevel{
    [GameData sharedInstance].level++;
    //NSLog(@"%d", [GameData sharedInstance].level);
    return [GameData sharedInstance].level;
}

//based on the score, tell determienStars how many stars to give
- (void)determineScore:(NSInteger)pointsEarned{
    NSLog(@"POINTS: %ld", (long)pointsEarned);
    
    [[GameData sharedInstance] setScore: pointsEarned];
    
    if ([GameData sharedInstance].level == 1) {
        if (pointsEarned > 7300) {
            [self determineStars:3];
        }
        else if (pointsEarned > 5600) {
            [self determineStars:2];
        }
        else if (pointsEarned > 4313) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
    }
    else if ([GameData sharedInstance].level == 2) {
        if (pointsEarned > 7470) {
            [self determineStars:3];
        }
        else if (pointsEarned > 5710) {
            [self determineStars:2];
        }
        else if (pointsEarned > 4396) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
        
    }
    else if ([GameData sharedInstance].level == 3 || [GameData sharedInstance].level == 4) {
        if (pointsEarned > 9400) {
            [self determineStars:3];
        }
        else if (pointsEarned > 7190) {
            [self determineStars:2];
        }
        else if (pointsEarned > 5530) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
        
    }
    else if ([GameData sharedInstance].level == 5) {
        if (pointsEarned > 10000) {
            [self determineStars:3];
        }
        else if (pointsEarned > 7690) {
            [self determineStars:2];
        }
        else if (pointsEarned > 5919) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
    }
}

//convey how many stars were earned in the level to the shared instance
- (void)determineStars:(NSInteger)stars{
    NSLog(@"You earned %ld stars", (long)stars);
    [[GameData sharedInstance] setStars1:stars];
}

@end

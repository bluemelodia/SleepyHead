////
////  OldGame.m
////  melaniehsu
////
////  Created by Melanie Hsu on 8/1/14.
////  Copyright (c) 2014 Apportable. All rights reserved.
////
//
//#import "OldGame.h"
//
//
////
////  Gameplay.m
////  melaniehsu
////
////  Created by Melanie Hsu on 7/8/14.
////  Copyright (c) 2014 Apportable. All rights reserved.
////
//
//#import "Gameplay.h"
//#import "Turtle.h"
//#import "Obstacle.h"
//#import "CCPhysics+ObjectiveChipmunk.h"
//#import "GameEnd.h"
//#import "CCAnimationManager.h"
//#import "Win.h"
//#import "CCPhysicsTouchNode.h"
//#import "Directions.h"
////#import "Pause.h"
//#import "GameData.h"
//#import "Sleepy.h"
//#import <QuartzCore/QuartzCore.h>
//
//
//float ohSnap; //snap the joint after a certain amount of time!
//
////float flicked; //limit flicking to every 1/2 to 3/4 second so the user can't "chain"
//
//@implementation OldGame {
//    //CCNode *_mouseJointNode; //the flicking mech node
//    //CCPhysicsJoint *_mouseJoint;//- (void)initialize;
//    CCNode *_turtle; //stores instance of turtle
//    CGRect boundingBox; //bounding box of the object
//    CCNode *_object; //spawned object
//    CCPhysicsNode *_physicsNode;
//    OALSimpleAudio *audio;
//    CCLabelTTF *_comment;
//    Sleepy *sleepyHead;
//    CCNode *_popup;
//    CCLabelTTF *_paused;
//    CCButton *_home;
//    CCButton *_repeat;
//    CCButton *_resume;
//    CCLabelTTF *_stars;
//    CCSprite *_startag;
//    CCButton *_stop;
//    CCLabelTTF *_first;
//    CCLabelTTF *_second;
//    CCLabelTTF *_third;
//    CCButton *_begin;
//    CCButton *_goNext;
//    CCButton *_goTwo;
//    CCLabelTTF *_gotHit;
//    CCSprite *_redBubble;
//    CCSprite *_greenBubble;
//    CCSprite *_blueBubble;
//    CCSprite *_orangeBubble;
//    CCSprite *_yellowBubble;
//    
//    //CCLabelTTF *_wake;
//    float timeSinceCareful;
//    float timeSinceWake;
//    bool tutorial;
//    
//    Boolean left; //is turtle left (if false, turtle is right)
//    //Boolean joint;
//    float timeSinceOuch;
//    bool careful;
//    bool wake;
//    float time; //time
//    float timeSinceSpawn;
//    bool spawnCount;
//    bool okToSpawn;
//    float timeSinceDeploy;
//    float spawnSpeed; //how fast to spawn objects from the plane
//    float deploySpeed; //how fast to spawn objects from the rocket
//    NSMutableArray *array;
//    CCSprite *_plane;
//    CCNode *_ouch;
//    CCSprite *_rocket;
//    CCSprite *_bubble;
//    CCNode *_sleepyHit;
//    CCLabelTTF *_health;
//    CCLabelTTF *_night;
//    CCLabelTTF *_clock;
//    CCLabelTTF *_streak;
//    CCLabelTTF *_points; //round points
//    CCLabelTTF *_highScore;
//    CCLabelTTF *_message;
//    CCNode *_edge;
//    bool called; //the game over/win method should only be called once
//    CCPhysicsTouchNode *_touchNode;
//    bool start; //freeze gameplay to play the beginning
//    bool stopped;
//    bool won;
//    NSInteger streak; //determine multiplier bonus by how many missed
//    NSInteger pts;
//}
//
//#pragma mark - Level Start
//- (void)didLoadFromCCB {
//    _second.visible = FALSE;
//    _third.visible = FALSE;
//    _goTwo.enabled = FALSE;
//    _begin.visible = FALSE;
//    _begin.enabled = FALSE;
//    _ouch.visible = FALSE;
//    self.started = FALSE;
//    _touchNode.game = self;
//    
//    //passes in the levelStart method as an object
//    //[self performSelector:@selector(levelStart) withObject:nil afterDelay:2.0f];
//    
//    //tell this scene to accept touches
//    //self.userInteractionEnabled = TRUE;
//    
//    //    _turtle = [CCBReader load:@"Turtle"];
//    _plane.physicsBody.collisionMask = @[];
//    _plane.visible = FALSE;
//    _rocket.physicsBody.collisionMask = @[];
//    _turtle.physicsBody.collisionMask = @[];
//    _bubble.physicsBody.collisionMask = @[];
//    _bubble.zOrder = 0;
//    _health.zOrder = 1;
//    _redBubble.visible = NO;
//    _orangeBubble.visible = NO;
//    _yellowBubble.visible = NO;
//    _greenBubble.visible = NO;
//    _blueBubble.visible = NO;
//    
//    //_sleepyHit = [CCBReader load:@"sleepyHit"];
//    //_sleepyHit.position = ccp(154.3, 71.7);
//    //_clock.zOrder = 0;
//    /*
//     if (![[NSUserDefaults standardUserDefaults] integerForKey:@"Level Number"]) {
//     [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"Level Number"]; //set this to level one to get the user to be able to play one again
//     }
//     [GameData sharedInstance].level = [[NSUserDefaults standardUserDefaults] integerForKey:@"Level Number"]; //stores the info on the phone
//     */
//    //countdown before each level
//    start = FALSE;
//    won = FALSE;
//    streak = 0;
//    NSString *string = [NSString stringWithFormat:@""];
//    stopped = FALSE;
//    _goNext.enabled = TRUE;
//    _goNext.visible = TRUE;
//    _stop.enabled = YES;
//    _paused.visible = FALSE;
//    _popup.visible = FALSE;
//    _home.visible = FALSE;
//    _home.enabled = FALSE;
//    _repeat.visible = FALSE;
//    _repeat.enabled = FALSE;
//    _resume.visible = NO;
//    _resume.enabled = NO;
//    _stars.visible = FALSE;
//    _startag.visible = FALSE;
//    _message.visible = YES;
//    okToSpawn = TRUE;
//    //sleepyHead = [Sleepy init];
//    //_wake.visible = NO;
//    
//    _points.string = @"";
//    [_points setColor: [CCColor blueColor]];
//    _comment.string = @"";
//    //TODO: make sure this works
//    
//    _highScore.string = @"";
//    _streak.color = [CCColor blueColor];
//    pts = 0;
//    _night.string = string;
//    /*if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Tutorial"]) {
//     [[self animationManager] runAnimationsForSequenceNamed:@"Tutorial"];
//     [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"Tutorial"];
//     [self performSelector:@selector(runStart) withObject:nil afterDelay:6.0];
//     }
//     else {
//     [self runStart];
//     }*/
//    //[self runStart];
//    //[self readySetGo];
//    
//    [[self animationManager] runAnimationsForSequenceNamed:@"Ready"];
//    //_message.string = @"Flick away objects before\n they hit sleepy head!";
//    
//}
//
//#pragma mark pause button
//- (BOOL)paused {
//    //Pause *pausedPopover = (Pause *)[CCBReader load:@"Pause"];
//    //pausedPopover.positionType = CCPositionTypeNormalized;
//    //pausedPopover.position = ccp(0.5, 0.5);
//    //pausedPopover.zOrder = INT_MAX;
//    _stars.string = [NSString stringWithFormat:@"%d",[[GameData sharedInstance] stars]];
//    
//    if (!stopped) {
//        [_physicsNode setPaused:YES];
//        [[_plane animationManager] setPaused:TRUE];
//        [[_rocket animationManager] setPaused:TRUE];
//        //  [self addChild:pausedPopover];
//        _popup.visible = YES;
//        _popup.zOrder = INT_MAX;
//        _resume.zOrder = INT_MAX;
//        _repeat.zOrder = INT_MAX;
//        _paused.zOrder = INT_MAX;
//        _home.zOrder = INT_MAX;
//        _startag.zOrder = INT_MAX;
//        _stars.zOrder = INT_MAX;
//        _home.visible = YES;
//        _home.enabled = YES;
//        _repeat.visible = YES;
//        _repeat.enabled = YES;
//        _resume.visible = YES;
//        _resume.enabled = YES;
//        _paused.visible = YES;
//        _stars.visible = YES;
//        _startag.visible = YES;
//        //get spawning to stop
//        _stop.enabled = NO;
//        return stopped = true;
//    }
//    else {
//        [_physicsNode setPaused:NO];
//        // [_plane setPaused:NO];
//        // [_rocket setPaused:NO];
//        [[_plane animationManager] setPaused:FALSE];
//        [[_rocket animationManager] setPaused:FALSE];
//        //_rocket.physicsBody.velocity = rocketSpeed;
//        //_plane.physicsBody.velocity = planeSpeed;
//        /*if (paused) {
//         [self removeChild:pausedPopover];
//         }*/
//        _popup.visible = NO;
//        _home.visible = NO;
//        _home.enabled = NO;
//        _repeat.visible = NO;
//        _repeat.enabled = NO;
//        _resume.visible = NO;
//        _resume.enabled = NO;
//        _paused.visible = NO;
//        _stars.visible = NO;
//        _startag.visible = NO;
//        _stop.enabled = YES;
//        return stopped = false;
//    }
//}
//
//- (void)home {
//    CCScene *leave = [CCBReader loadAsScene:@"MainScene"];
//    [[CCDirector sharedDirector] replaceScene:leave];
//}
//
//- (void)resume {
//    [_physicsNode setPaused:NO];
//    // [_plane setPaused:NO];
//    // [_rocket setPaused:NO];
//    [[_plane animationManager] setPaused:FALSE];
//    [[_rocket animationManager] setPaused:FALSE];
//    //_rocket.physicsBody.velocity = rocketSpeed;
//    //_plane.physicsBody.velocity = planeSpeed;
//    /*if (paused) {
//     [self removeChild:pausedPopover];
//     }*/
//    _popup.visible = NO;
//    _home.visible = NO;
//    _home.enabled = NO;
//    _repeat.visible = NO;
//    _repeat.enabled = NO;
//    _resume.visible = NO;
//    _resume.enabled = NO;
//    _paused.visible = NO;
//    _stars.visible = NO;
//    _startag.visible = NO;
//    stopped = false;
//}
//
//- (void)repeat {
//    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
//    [[CCDirector sharedDirector] replaceScene:mainScene];
//}
//
//- (void)runStart{
//    [[self animationManager] runAnimationsForSequenceNamed:@"Ready"];
//}
//
//- (void)setScore:(NSInteger)score {
//    _score = score;
//    //_health.string = [NSString stringWithFormat:@"%d", score];
//    
//    if (score == 5)
//        _health.string = @"zzzzz..";
//    else if (score == 4)
//        _health.string = @"zzzz..";
//    else if (score == 3)
//        _health.string = @"zzz..";
//    else if (score == 2)
//        _health.string = @"zz..";
//    else if (score == 1)
//        _health.string = @"z..";
//    else
//        _health.string = @"OUCH!!!";
//}
//
//- (void)readySetGo {
//    won = FALSE;
//    self.started = TRUE;
//    _points.string = @"0";
//    _highScore.string = [NSString stringWithFormat:@"Best: %ld", (long)[[GameData sharedInstance] scoreFor:[GameData sharedInstance].level]];
//    
//    switch ([GameData sharedInstance].level) {
//        case 1:
//            [[self animationManager] runAnimationsForSequenceNamed:@"Level One"];
//            _night.string = @"Night 1";
//            spawnSpeed = 0.5;
//            _physicsNode.gravity = ccp(0, -200);
//            break;
//        case 2:
//            [[self animationManager] runAnimationsForSequenceNamed:@"Level Two"];
//            _night.string = @"Night 2";
//            spawnSpeed = 0.5;
//            _physicsNode.gravity = ccp(0, -210);
//            break;
//        case 3:
//            [[self animationManager] runAnimationsForSequenceNamed:@"Level Three"];
//            _night.string = @"Night 3";
//            spawnSpeed = 0.45;
//            _physicsNode.gravity = ccp(0, -220);
//            break;
//        case 4:
//            [[self animationManager] runAnimationsForSequenceNamed:@"Level Four"];
//            _night.string = @"Night 4";
//            spawnSpeed = 0.55; //0.45 formerly
//            deploySpeed = 0.8;
//            _physicsNode.gravity = ccp(0, -200);
//            break;
//        case 5:
//            [[self animationManager] runAnimationsForSequenceNamed:@"Level Five"];
//            _night.string = @"Night 5";
//            spawnSpeed = 0.45;
//            deploySpeed = 0.75;
//            _physicsNode.gravity = ccp(0, -210);
//            break;
//    }
//    //TODO: after level 5, the gravity keeps increasing steadily
//    
//    time = 0.0;
//    timeSinceSpawn = 0.0;
//    timeSinceDeploy = 0.0;
//    _plane.visible = TRUE;
//    
//    left = false;
//    //joint = false;
//    //self.physics = _physicsNode;
//    self.userInteractionEnabled = YES;
//    self.multipleTouchEnabled = TRUE;
//    _physicsNode.debugDraw = NO;
//    
//    //sign up as the collision delegate of our physics node
//    _physicsNode.collisionDelegate = self;
//    
//    //initialize array for storing objects
//    array = [NSMutableArray array];
//    self.score = 5;
//    //NSLog(@"%d START", self.score);
//    self.hours = 0;
//    
//    [self spawn];
//    start = TRUE;
//}
///*
// - (void)next {
// _first.visible = FALSE;
// _goNext.enabled = FALSE;
// _goNext.visible = FALSE;
// _second.visible = TRUE;
// _goTwo.enabled = TRUE;
// _goTwo.visible = TRUE;
// }
// 
// - (void)nextTwo {
// _second.visible = FALSE;
// _goTwo.enabled = FALSE;
// _goTwo.visible = FALSE;
// _third.visible = TRUE;
// _begin.visible = TRUE;
// _begin.enabled = TRUE;
// }
// 
// - (void)start {
// _third.visible = FALSE;
// _begin.visible = FALSE;
// _begin.enabled = FALSE;
// _tutorial.visible = FALSE;
// self.paused = NO;
// }
// */
//#pragma mark - Time-Related Things
//- (void)setTime:(double)time {
//    if (_hours == 0) {
//        _clock.string = @"12:00am";
//    }
//    else if (_hours == 0.25) {
//        _clock.string = @"12:15am";
//    }
//    else if (_hours == 0.5) {
//        _clock.string = @"12:30am";
//    }
//    else if (_hours == 0.75) {
//        _clock.string = @"12:45am";
//    }
//    else if (_hours == 1) {
//        _clock.string = @"1:00am";
//    }
//    else if (_hours == 1.25) {
//        _clock.string = @"1:15am";
//    }
//    else if (_hours == 1.5) {
//        _clock.string = @"1:30am";
//    }
//    else if (_hours == 1.75) {
//        _clock.string = @"1:45am";
//    }
//    else if (_hours == 2) {
//        _clock.string = @"2:00am";
//    }
//    else if (_hours == 2.25) {
//        _clock.string = @"2:15am";
//    }
//    else if (_hours == 2.5) {
//        _clock.string = @"2:30am";
//    }
//    else if (_hours == 2.75) {
//        _clock.string = @"2:45am";
//    }
//    else if (_hours == 3) {
//        _clock.string = @"3:00am";
//    }
//    else if (_hours == 3.25) {
//        _clock.string = @"3:15am";
//    }
//    else if (_hours == 3.5) {
//        _clock.string = @"3:30am";
//    }
//    else if (_hours == 3.75) {
//        _clock.string = @"3:45am";
//    }
//    else if (_hours == 4) {
//        _clock.string = @"4:00am";
//    }
//    else if (_hours == 4.25) {
//        _clock.string = @"4:15am";
//    }
//    else if (_hours == 4.5) {
//        _clock.string = @"4:30am";
//    }
//    else if (_hours == 4.75) {
//        _clock.string = @"4:45am";
//    }
//    else if (_hours == 5) {
//        _clock.string = @"5:00am";
//    }
//    else if (_hours == 5.25) {
//        _clock.string = @"5:15am";
//    }
//    else if (_hours == 5.5) {
//        _clock.string = @"5:30am";
//    }
//    else if (_hours == 5.75) {
//        _clock.string = @"5:45am";
//    }
//    else if (_hours == 6) {
//        _clock.string = @"6:00am";
//    }
//    /* else if (_hours == 6.25) {
//     _clock.string = @"6:15am";
//     }
//     else if (_hours == 6.5) {
//     _clock.string = @"6:30am";
//     }
//     else if (_hours == 6.75) {
//     _clock.string = @"6:45am";
//     }
//     else if (_hours == 7) {
//     _clock.string = @"7:00am";
//     }
//     else if (_hours == 7.25) {
//     _clock.string = @"7:15am";
//     }
//     else if (_hours == 7.5) {
//     _clock.string = @"7:30am";
//     }
//     else if (_hours == 7.75) {
//     _clock.string = @"7:45am";
//     }
//     else if (_hours == 8){
//     _clock.string = @"8:00am";
//     }*/
//}
//
//- (void)update:(CCTime)delta {
//    for (Obstacle *obstacle in array) {
//        //if obstacle has left the screen, increase score
//        //NSLog(@"%f %f", obstacle.position.x, obstacle.position.y);
//        if (!called && obstacle.visible == TRUE && (obstacle.position.x < 0 || obstacle.position.x > [CCDirector sharedDirector].viewSize.width || obstacle.position.y > [CCDirector sharedDirector].viewSize.height)) {
//            obstacle.visible = FALSE;
//            streak++;
//            
//            //okToSpawn = TRUE;
//            NSLog(@"STREAK: %d", streak);
//            [self determinePoints:streak];
//            /*
//             if (streak < 10) {
//             pts = pts + 1.2*streak;
//             [_streak setColor: [CCColor blueColor]];
//             [_points setColor: [CCColor blueColor]];
//             _blueBubble.visible = YES;
//             CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//             [_points runAction:growAndShrink];
//             _streak.fontSize = 16;
//             _streak.zOrder = INT_MAX-2;
//             
//             CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"LeastIntense"];
//             boom.autoRemoveOnFinish = TRUE;
//             boom.position = _streak.position;
//             [self addChild:boom];
//             
//             CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"LeastIntense"];
//             bam.autoRemoveOnFinish = TRUE;
//             bam.position = _points.position;
//             [self addChild:bam];
//             CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//             [_blueBubble runAction:popAndPush];
//             
//             CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//             [_streak runAction:bigAndSmall];
//             }
//             else if (10 <= streak && streak < 25) {
//             pts = pts + 1.4*streak;
//             _greenBubble.visible = YES;
//             _blueBubble.visible = NO;
//             _streak.fontSize = 18;
//             
//             [_streak setColor: [CCColor greenColor]];
//             _streak.zOrder = INT_MAX-2;
//             
//             CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
//             CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
//             CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
//             [_comment runAction:UpAndDown];
//             _comment.string = @"Fresh!";
//             [_comment setColor: [CCColor greenColor]];
//             [_points setColor: [CCColor greenColor]];
//             
//             CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//             // [_comment runAction:growAndShrink];
//             [_points runAction:growAndShrink];
//             
//             CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//             [_streak runAction:bigAndSmall];
//             CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"FourthIntense"];
//             boom.autoRemoveOnFinish = TRUE;
//             boom.position = _streak.position;
//             [self addChild:boom];
//             
//             CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"FourthIntense"];
//             bam.autoRemoveOnFinish = TRUE;
//             bam.position = _points.position;
//             [self addChild:bam];
//             
//             CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//             [_greenBubble runAction:popAndPush];
//             
//             }
//             else if (25 <= streak && streak < 50) {
//             _streak.fontSize = 20;
//             pts = pts + 1.6*streak;
//             _greenBubble.visible = NO;
//             _yellowBubble.visible = YES;
//             [_streak setColor: [CCColor brownColor]];
//             [_points setColor: [CCColor yellowColor]];
//             _streak.zOrder = INT_MAX-2;
//             _comment.string = @"Smooth!";
//             
//             CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
//             CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
//             CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
//             [_comment runAction:UpAndDown];
//             
//             
//             CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//             //[_comment runAction:growAndShrink];
//             [_comment setColor: [CCColor brownColor]];
//             [_points runAction:growAndShrink];
//             
//             CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//             [_streak runAction:bigAndSmall];
//             CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"ThirdIntense"];
//             boom.autoRemoveOnFinish = TRUE;
//             boom.position = _streak.position;
//             [self addChild:boom];
//             
//             CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"ThirdIntense"];
//             bam.autoRemoveOnFinish = TRUE;
//             bam.position = _points.position;
//             [self addChild:bam];
//             NSLog(@"yellow should be visible");
//             
//             CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//             [_yellowBubble runAction:popAndPush];
//             }
//             else if (50 <= streak && streak < 100) {
//             _streak.fontSize = 22;
//             pts = pts + 1.8*streak;
//             _yellowBubble.visible = NO;
//             _orangeBubble.visible = YES;
//             [_streak setColor: [CCColor orangeColor]];
//             [_points setColor: [CCColor orangeColor]];
//             _streak.zOrder = INT_MAX-2;
//             CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"SecondIntense"];
//             boom.autoRemoveOnFinish = TRUE;
//             boom.position = _streak.position;
//             [self addChild:boom];
//             
//             
//             
//             CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"SecondIntense"];
//             bam.autoRemoveOnFinish = TRUE;
//             bam.position = _points.position;
//             [self addChild:bam];
//             _comment.string = @"Dreamy!";
//             
//             CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
//             CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
//             CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
//             [_comment runAction:UpAndDown];
//             
//             
//             CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//             //[_comment runAction:growAndShrink];
//             [_comment setColor: [CCColor orangeColor]];
//             [_points runAction:growAndShrink];
//             
//             CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//             [_streak runAction:bigAndSmall];
//             NSLog(@"orange should be visible");
//             
//             CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//             [_orangeBubble runAction:popAndPush];
//             }
//             else {
//             _streak.fontSize = 24;
//             pts = pts + 2.0*streak;
//             _orangeBubble.visible = NO;
//             _redBubble.visible = YES;
//             [_streak setColor: [CCColor redColor]];
//             [_points setColor: [CCColor redColor]];
//             _streak.zOrder = INT_MAX-2;
//             CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"MostIntense"];
//             bam.autoRemoveOnFinish = TRUE;
//             bam.position = _points.position;
//             [self addChild:bam];
//             
//             CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"MostIntense"];
//             boom.autoRemoveOnFinish = TRUE;
//             boom.position = _streak.position;
//             [self addChild:boom];
//             _comment.string = @"Sweet!";
//             
//             CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
//             CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
//             CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
//             [_comment runAction:UpAndDown];
//             CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//             //[_comment runAction:growAndShrink];
//             [_comment setColor: [CCColor redColor]];
//             [_points runAction:growAndShrink];
//             NSLog(@"red should be visible");
//             
//             CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//             [_streak runAction:bigAndSmall];
//             
//             CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//             CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//             CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//             [_redBubble runAction:popAndPush];
//             }*/
//            NSString *point = [NSString stringWithFormat:@"%d", pts];
//            _points.string = point;
//            NSString *chain = [NSString stringWithFormat:@"x%d", streak];
//            _streak.string = chain;
//        }
//    }
//    
//    if (start && !stopped) {
//        time += delta;
//        timeSinceSpawn += delta;
//        timeSinceOuch += delta;
//        timeSinceDeploy += delta;
//        ohSnap += delta;
//        if (timeSinceOuch > 0.2) {
//            _ouch.visible = FALSE;
//            timeSinceOuch = 0;
//        }
//        if (time <= 61 && !won) {
//            if ([GameData sharedInstance].level >= 4 && 20 < _rocket.position.x && _rocket.position.x < [CCDirector sharedDirector].viewSize.width-20 && timeSinceDeploy > deploySpeed) {
//                [self deploy];
//                timeSinceDeploy = 0.0;
//            }
//            
//            if (timeSinceSpawn > spawnSpeed) {
//                [self spawn];
//                
//                okToSpawn = FALSE;
//                
//                if (!called) {
//                    if (time >= 60) {
//                        self.hours = 6;
//                        [self setTime:6];
//                        [self determineScore:pts];
//                        [self win];
//                    }
//                    else if (time >= 57.5) {
//                        self.hours = 5.75;
//                        [self setTime:5.75];
//                    }
//                    else if (time >= 55.0) {
//                        self.hours = 5.5;
//                        [self setTime:5.5];
//                    }
//                    else if (time >= 52.5) {
//                        self.hours = 5.25;
//                        [self setTime:5.25];
//                    }
//                    else if (time >= 50) {
//                        self.hours = 5;
//                        [self setTime:5];
//                    }
//                    else if (time >= 47.5) {
//                        self.hours = 4.75;
//                        [self setTime:4.75];
//                    }
//                    else if (time >= 45.0) {
//                        self.hours = 4.5;
//                        [self setTime:4.5];
//                    }
//                    else if (time >= 42.5) {
//                        self.hours = 4.25;
//                        [self setTime:4.25];
//                    }
//                    else if (time >= 40) {
//                        self.hours = 4;
//                        [self setTime:4];
//                    }
//                    else if (time >= 37.5) {
//                        self.hours = 3.75;
//                        [self setTime:3.75];
//                    }
//                    else if (time >= 35.0) {
//                        self.hours = 3.5;
//                        [self setTime:3.5];
//                    }
//                    else if (time >= 32.5) {
//                        self.hours = 3.25;
//                        [self setTime:3.25];
//                    }
//                    else if (time >= 30) {
//                        self.hours = 3;
//                        [self setTime:3];
//                    }
//                    else if (time >= 27.5) {
//                        self.hours = 2.75;
//                        [self setTime:2.75];
//                    }
//                    else if (time >= 25.0) {
//                        self.hours = 2.5;
//                        [self setTime:2.5];
//                    }
//                    else if (time >= 22.5) {
//                        self.hours = 2.25;
//                        [self setTime:2.25];
//                    }
//                    else if (time >= 20) {
//                        self.hours = 2;
//                        [self setTime:2];
//                    }
//                    else if (time >= 17.5) {
//                        self.hours = 1.75;
//                        [self setTime:1.75];
//                    }
//                    else if (time >= 15.0) {
//                        self.hours = 1.5;
//                        [self setTime:1.5];
//                    }
//                    else if (time >= 12.5) {
//                        self.hours = 1.25;
//                        [self setTime:1.25];
//                    }
//                    else if (time >= 10) {
//                        self.hours = 1;
//                        [self setTime:1];
//                        //[self win];
//                    }
//                    else if (time >= 7.5) {
//                        self.hours = 0.75;
//                        [self setTime:0.75];
//                    }
//                    else if (time >= 5.0) {
//                        self.hours = 0.5;
//                        [self setTime:0.5];
//                        //[self win];
//                    }
//                    else if (time >= 2.5) {
//                        self.hours = 0.25;
//                        [self setTime:0.25];
//                    }
//                    else {
//                        self.hours = 0;
//                        [self setTime:0];
//                    }
//                }
//                timeSinceSpawn = 0.0;
//            }
//        }
//    }
//}
//
//
//#pragma mark - Turtles Throwing Things
////spawn obstacles for turtle to push
//- (void)spawn {
//    Obstacle *obstacle;
//    if ([GameData sharedInstance].level == 1) {
//        obstacle = [Obstacle initObstacleForLevel:(NSInteger)2]; //first level, only light and medium
//    }
//    else if ([GameData sharedInstance].level <= 4) {
//        obstacle = [Obstacle initObstacleForLevel:(NSInteger)3]; //second level, heavy objects come in
//    }
//    else {
//        obstacle = [Obstacle initObstacleForLevel:(NSInteger)4]; //parachuting turtles begin spawning on level 5
//    }
//    
//    obstacle.gameplayLayer = self;
//    obstacle.position = ccpSub(_plane.position, ccp(0, 25));
//    //obstacle.physicsBody.collisionType = @"items";
//    //uncomment to see if they collide
//    //obstacle.physicsBody.collisionMask = @[@"items"];
//    
//    obstacle.zOrder = 2;
//    boundingBox = obstacle.boundingBox;
//    boundingBox.origin = [obstacle.parent convertToWorldSpace:boundingBox.origin];
//    [_physicsNode addChild:obstacle]; //add object to the physics world
//    //
//    NSAssert(obstacle.parent != nil, @"Bodies connected by a joint must be added to the same CCPhysicsNode.");
//    
//    [array addObject:obstacle]; //add object to the array
//    
//    //obstacle.position = _plane.position;
//}
//
//- (void)deploy {
//    Obstacle *obstacle;
//    if ([GameData sharedInstance].level == 4) {
//        obstacle = [Obstacle initObstacleForRocket:(NSInteger)2];
//    }
//    else if ([GameData sharedInstance].level == 5) {
//        obstacle = [Obstacle initObstacleForRocket:(NSInteger)3];
//    }
//    else {
//        obstacle = [Obstacle initObstacleForRocket:(NSInteger)4];
//    }
//    
//    obstacle.gameplayLayer = self;
//    obstacle.position = ccpSub(_rocket.position, ccp(0, 25));
//    
//    //obstacle.physicsBody.collisionType = @"items";
//    //uncomment to see if they collide
//    //obstacle.physicsBody.collisionMask = @[@"items"];
//    
//    obstacle.zOrder = 1;
//    boundingBox = obstacle.boundingBox;
//    boundingBox.origin = [obstacle.parent convertToWorldSpace:boundingBox.origin];
//    [_physicsNode addChild:obstacle]; //add object to the physics world
//    //
//    NSAssert(obstacle.parent != nil, @"Bodies connected by a joint must be added to the same CCPhysicsNode.");
//    
//    [array addObject:obstacle];
//}
//
//#pragma mark - Collisions
//
////objects can now collide with each other
//- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair obstacle:(CCNode *)nodeA obstacle:(CCNode *)nodeB {
//    if (!called) {
//        for (Obstacle *obstacle in array) {
//            if (obstacle == nodeA || obstacle == nodeB) {
//                NSLog(@"health was %d", obstacle.health);
//                obstacle.health--;
//                NSLog(@"health decreased to %d", obstacle.health);
//                
//                if (obstacle.health <= 0) {
//                    [[_physicsNode space] addPostStepBlock:^{
//                        //[self obstacleRemoved:nodeB];
//                        CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Impact"];
//                        explosion.autoRemoveOnFinish = TRUE;
//                        explosion.position = obstacle.position;
//                        [obstacle.parent addChild:explosion];
//                        obstacle.visible = FALSE;
//                        obstacle.physicsBody.collisionMask = @[]; //can't collide with the object anymore
//                    } key:obstacle];
//                    
//                    streak++;
//                    
//                    //okToSpawn = TRUE;
//                    NSLog(@"STREAK: %d", streak);
//                    
//                    
//                }
//            }
//        }
//        return true; //TODO: this used to be false
//    }
//    
//    //if an obstacle collides with the ceiling, remove it from play
//    - (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair obstacle:(Obstacle *)nodeA edge:(CCNode *)nodeB {
//        nodeA.visible = FALSE;
//        nodeA.physicsBody.collisionMask = @[];
//    }
//    
//    - (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair sleepy:(CCNode *)nodeA obstacle:(Obstacle *)nodeB {
//        //NSLog(@"density: %d", nodeB.density);
//        
//        if (!called && !nodeB.collided) {
//            _ouch.visible = TRUE;
//            timeSinceOuch = 0;
//            if (nodeB.density < 25){ //light object effects
//                self.score--;
//                //_sleepyHit.opacity = 1.0;
//                
//                nodeB.collided = true;
//                //NSLog(@"%d", self.score);
//            }
//            else if (nodeB.density < 50) { //medium object effects
//                self.score = self.score/2;
//                //_sleepyHit.opacity = 1.0;
//                nodeB.collided = true;
//                //NSLog(@"%d", self.score);
//            }
//            else { //heavy object effects
//                self.score = self.score - 5; //game over!
//                //_sleepyHit.opacity = 1.0;
//                nodeB.collided = true;
//                //NSLog(@"%d", self.score);
//            }
//            //TODO: sleepy got hit!
//            if (self.score <= 0) {
//                //_sleepyHit.opacity = 0.0;
//                [self lose];
//            }
//            //careful.visible = YES;
//            //careful = TRUE;
//            //timeSinceCareful = 0;
//            
//            _sleepyHit.opacity = 0.0;
//            streak = 0;
//            [_points setColor: [CCColor blueColor]];
//            _streak.fontSize = 14;
//            _redBubble.visible = NO;
//            _orangeBubble.visible = NO;
//            _yellowBubble.visible = NO;
//            _greenBubble.visible = NO;
//            _blueBubble.visible = NO;
//            
//            okToSpawn = TRUE;
//            _streak.string = @"";
//            _comment.string = @"";
//            _streak.zOrder = INT_MAX-2;
//            
//            [[_physicsNode space] addPostStepBlock:^{
//                //[self obstacleRemoved:nodeB];
//                CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Impact"];
//                explosion.autoRemoveOnFinish = TRUE;
//                explosion.position = nodeB.position;
//                [nodeB.parent addChild:explosion];
//                nodeB.visible = FALSE;
//            } key:nodeB];
//            
//        }
//    }
//    
//    //hit the ceiling - want the visibilty to fall - collisionMask of the object becomes empty so it won't collide with anything
//    
//    - (void)obstacleRemoved:(Obstacle *)obstacle {
//        if (!obstacle.removed) {
//            [obstacle removeFromParent];
//            [array removeObject:obstacle];
//            obstacle.removed = true;
//        }
//    }
//    
//#pragma mark Start of each level...
//    - (void)startWithPopup:(NSString*)message {
//        GameEnd *gameEndPopover = (GameEnd *)[CCBReader load:@"Directions"];
//        gameEndPopover.positionType = CCPositionTypeNormalized;
//        gameEndPopover.position = ccp(0.5, 0.5);
//        gameEndPopover.zOrder = INT_MAX;
//        [gameEndPopover setMessage:message score:self.hours];
//        [self addChild:gameEndPopover];
//    }
//    
//#pragma mark The end...?
//    - (void)win {
//        _stop.enabled = NO;
//        [self endGameWithMessageWin:@"Survived to sunrise!"];
//        //[GameData sharedInstance].level++;
//        NSLog(@"%ld", (long)[GameData sharedInstance].level);
//        [[NSUserDefaults standardUserDefaults] setInteger:[GameData sharedInstance].level forKey:@"Level Number"];
//        won = TRUE;
//    }
//    
//    - (void)lose {
//        _stop.enabled = NO;
//        [audio stopBg];
//        audio = [OALSimpleAudio sharedInstance];
//        // play background sound
//        [audio playBg:@"pianoBG.wav" loop:TRUE];
//        [self endGameWithMessageLose:@"A rude awakening!"];
//    }
//    
//    - (void)endGameWithMessageLose:(NSString*)message {
//        if (!called) {
//            GameEnd *gameEndPopover = (GameEnd *)[CCBReader load:@"GameEnd"];
//            gameEndPopover.positionType = CCPositionTypeNormalized;
//            gameEndPopover.position = ccp(0.5, 0.5);
//            gameEndPopover.zOrder = INT_MAX;
//            [gameEndPopover setMessage:message score:self.hours];
//            [self addChild:gameEndPopover];
//            called = true;
//        }
//    }
//    
//    - (void)endGameWithMessageWin:(NSString*)message {
//        _stop.enabled = NO;
//        
//        if (!called) {
//            Win *gameEndPopover = (Win *)[CCBReader load:@"Win"];
//            gameEndPopover.positionType = CCPositionTypeNormalized;
//            gameEndPopover.position = ccp(0.5, 0.5);
//            gameEndPopover.zOrder = INT_MAX;
//            [gameEndPopover setMessage:message score:self.hours];
//            
//            gameEndPopover.gameplayLayer = self;
//            [self addChild:gameEndPopover];
//            [gameEndPopover starDisplay];
//            called = true;
//            
//            for (Obstacle *obstacle in array) {
//                obstacle.visible = FALSE;
//            }
//        }
//    }
//    
//    -(void)determinePoints:(NSInteger)streak {
//        //points determination factor
//        if (streak < 10) {
//            pts = pts + 1.2*streak;
//            _streak.fontSize = 16;
//            
//            [_points setColor: [CCColor blueColor]];
//            _blueBubble.visible = YES;
//            CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//            [_points runAction:growAndShrink];
//            [_streak setColor: [CCColor blueColor]];
//            
//            CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"LeastIntense"];
//            boom.autoRemoveOnFinish = TRUE;
//            boom.position = _streak.position;
//            [self addChild:boom];
//            
//            CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"LeastIntense"];
//            bam.autoRemoveOnFinish = TRUE;
//            bam.position = _points.position;
//            [self addChild:bam];
//            
//            CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//            [_streak runAction:bigAndSmall];
//            
//            CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//            [_blueBubble runAction:popAndPush];
//        }
//        else if (10 <= streak && streak < 25) {
//            pts = pts + 1.4*streak;
//            [_streak setColor: [CCColor greenColor]];
//            [_points setColor: [CCColor greenColor]];
//            _streak.fontSize = 18;
//            
//            CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
//            CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
//            CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
//            [_comment runAction:UpAndDown];
//            
//            
//            _blueBubble.visible = NO;
//            _greenBubble.visible = YES;
//            _streak.zOrder = INT_MAX-2;
//            _comment.string = @"Fresh!";
//            CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//            [_streak runAction:bigAndSmall];
//            //TODO: scale by positive action, scale by negative action
//            CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"FourthIntense"];
//            boom.autoRemoveOnFinish = TRUE;
//            boom.position = _streak.position;
//            [self addChild:boom];
//            
//            CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"FourthIntense"];
//            bam.autoRemoveOnFinish = TRUE;
//            bam.position = _points.position;
//            [self addChild:bam];
//            
//            CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//            [_greenBubble runAction:popAndPush];
//        }
//        else if (25 <= streak && streak < 50) {
//            pts = pts + 1.6*streak;
//            _greenBubble.visible = NO;
//            _yellowBubble.visible = YES;
//            _streak.fontSize = 20;
//            
//            CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
//            CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
//            CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
//            [_comment runAction:UpAndDown];
//            
//            
//            [_streak setColor: [CCColor brownColor]];
//            [_points setColor: [CCColor yellowColor]];
//            _streak.zOrder = INT_MAX-2;
//            CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"ThirdIntense"];
//            boom.autoRemoveOnFinish = TRUE;
//            boom.position = _streak.position;
//            [self addChild:boom];
//            
//            CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"ThirdIntense"];
//            bam.autoRemoveOnFinish = TRUE;
//            bam.position = _points.position;
//            [self addChild:bam];
//            
//            NSLog(@"yellow should be visible");
//            _comment.string = @"Smooth!";
//            CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//            [_points runAction:growAndShrink];
//            [_comment setColor: [CCColor brownColor]];
//            
//            CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//            [_streak runAction:bigAndSmall];
//            
//            CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//            [_yellowBubble runAction:popAndPush];
//        }
//        else if (50 <= streak && streak < 100) {
//            pts = pts + 1.8*streak;
//            _streak.fontSize = 22;
//            
//            
//            CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
//            CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
//            CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
//            [_comment runAction:UpAndDown];
//            
//            _yellowBubble.visible = NO;
//            _orangeBubble.visible = YES;
//            [_streak setColor: [CCColor orangeColor]];
//            [_points setColor: [CCColor orangeColor]];
//            _streak.zOrder = INT_MAX-2;
//            CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"SecondIntense"];
//            boom.autoRemoveOnFinish = TRUE;
//            boom.position = _streak.position;
//            [self addChild:boom];
//            
//            CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"SecondIntense"];
//            bam.autoRemoveOnFinish = TRUE;
//            bam.position = _points.position;
//            [self addChild:bam];
//            
//            _comment.string = @"Dreamy!";
//            CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//            //[_comment runAction:growAndShrink];
//            [_comment setColor: [CCColor orangeColor]];
//            [_points runAction:growAndShrink];
//            
//            CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//            [_streak runAction:bigAndSmall];
//            NSLog(@"orange should be visible");
//            
//            CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//            [_orangeBubble runAction:popAndPush];
//        }
//        else {
//            pts = pts + 2.0*streak;
//            _streak.fontSize = 24;
//            _orangeBubble.visible = NO;
//            _redBubble.visible = YES;
//            [_streak setColor: [CCColor redColor]];
//            [_points setColor: [CCColor redColor]];
//            _streak.zOrder = INT_MAX-2;
//            CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"MostIntense"];
//            boom.autoRemoveOnFinish = TRUE;
//            boom.position = _streak.position;
//            [self addChild:boom];
//            
//            
//            CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
//            CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
//            CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
//            [_comment runAction:UpAndDown];
//            
//            
//            CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"MostIntense"];
//            bam.autoRemoveOnFinish = TRUE;
//            bam.position = _points.position;
//            [self addChild:bam];
//            
//            _comment.string = @"Sweet!";
//            CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
//            //[_comment runAction:growAndShrink];
//            [_comment setColor: [CCColor redColor]];
//            [_points runAction:growAndShrink];
//            
//            CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
//            [_streak runAction:bigAndSmall];
//            NSLog(@"red should be visible");
//            
//            CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
//            CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
//            CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
//            [_redBubble runAction:popAndPush];
//        }
//        NSString *point = [NSString stringWithFormat:@"%d", pts];
//        _points.string = point;
//        NSString *chain = [NSString stringWithFormat:@"x%d", streak];
//        _streak.string = chain;
//    }
//}
//
//- (NSInteger)incrementLevel{
//    [GameData sharedInstance].level++;
//    //NSLog(@"%d", [GameData sharedInstance].level);
//    return [GameData sharedInstance].level;
//}
//
////based on the score, tell determienStars how many stars to give
//- (void)determineScore:(NSInteger)pointsEarned{
//    NSLog(@"POINTS: %ld", (long)pointsEarned);
//    
//    [[GameData sharedInstance] setScore: pointsEarned];
//    
//    
//    
//    if ([GameData sharedInstance].level == 1) {
//        if (pointsEarned > 11400) {
//            [self determineStars:3];
//        }
//        else if (pointsEarned > 8720) {
//            [self determineStars:2];
//        }
//        else if (pointsEarned > 6705) {
//            [self determineStars:1];
//        }
//        else {
//            [self determineStars:0];
//        }
//    }
//    else if ([GameData sharedInstance].level == 2) {
//        if (pointsEarned > 11400) {
//            [self determineStars:3];
//        }
//        else if (pointsEarned > 8720) {
//            [self determineStars:2];
//        }
//        else if (pointsEarned > 6705) {
//            [self determineStars:1];
//        }
//        else {
//            [self determineStars:0];
//        }
//        
//    }
//    else if ([GameData sharedInstance].level == 3) {
//        if (pointsEarned > 15870) {
//            [self determineStars:3];
//        }
//        else if (pointsEarned > 12140) {
//            [self determineStars:2];
//        }
//        else if (pointsEarned > 9340) {
//            [self determineStars:1];
//        }
//        else {
//            [self determineStars:0];
//        }
//        
//    }
//    else if ([GameData sharedInstance].level == 4) {
//        if (pointsEarned > 26240) {
//            [self determineStars:3];
//        }
//        else if (pointsEarned > 20070) {
//            [self determineStars:2];
//        }
//        else if (pointsEarned > 15440) {
//            [self determineStars:1];
//        }
//        else {
//            [self determineStars:0];
//        }
//    }
//    else if ([GameData sharedInstance].level == 5) {
//        if (pointsEarned > 37240) {
//            [self determineStars:3];
//        }
//        else if (pointsEarned > 28480) {
//            [self determineStars:2];
//        }
//        else if (pointsEarned > 21905) {
//            [self determineStars:1];
//        }
//        else {
//            [self determineStars:0];
//        }
//    }
//}
//
////convey how many stars were earned in the level to the shared instance
//- (void)determineStars:(NSInteger)stars{
//    NSLog(@"You earned %ld stars", (long)stars);
//    [[GameData sharedInstance] setStars:stars];
//}
//
//@end

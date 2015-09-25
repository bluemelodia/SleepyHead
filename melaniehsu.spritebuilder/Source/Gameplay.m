//
// Gameplay.m
// melaniehsu
//
// Created by Melanie Hsu on 7/8/14.
// Copyright (c) 2014 Apportable. All rights reserved.
//

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
#import "Sleepy.h"
#import <QuartzCore/QuartzCore.h>


float ohSnap; //snap the joint after a certain amount of time!

//float flicked; //limit flicking to every 1/2 to 3/4 second so the user can't "chain"

@implementation Gameplay {
    //CCNode *_mouseJointNode; //the flicking mech node
    //CCPhysicsJoint *_mouseJoint;//- (void)initialize;
    BOOL done;
    BOOL fall;
    BOOL shown;
    BOOL alert;
    CCNode *_turtle; //stores instance of turtle
    CGRect boundingBox; //bounding box of the object
    CCNode *_object; //spawned object
    CCPhysicsNode *_physicsNode;
    OALSimpleAudio *audio;
    CCLabelTTF *_comment;
    Sleepy *sleepyHead;
    CCNode *_popup;
    CCLabelTTF *_paused;
    CCSprite *_thoughts; 
    CCButton *_home;
    CCButton *_repeat;
    CCButton *_resume;
    CCLabelTTF *_stars;
    CCSprite *_startag;
    CCButton *_stop;
    CCLabelTTF *_first;
    CCLabelTTF *_second;
    CCLabelTTF *_third;
    CCButton *_begin;
    CCButton *_goNext;
    CCButton *_goTwo;
    CCLabelTTF *_gotHit;
    CCSprite *_redBubble;
    CCSprite *_greenBubble;
    CCSprite *_blueBubble;
    CCSprite *_orangeBubble;
    CCSprite *_yellowBubble;
    CCSprite *_sky;
    CCSprite *_dying;
    CCSprite *_won;
    CCSprite *_aboutToDie;
    CCSprite *_sun;
    CCSprite *_moon;
    CCSprite *_skySunset;
    CCSprite *_test;
    CCLabelTTF *_instructions;
    CCNode *_redAlert;
    CCSprite *_wake;
    
    //CCLabelTTF *_wake;
    float timeSinceCareful;
    float timeSinceWake;
    float timeSinceAlert;
    
    Boolean left; //is turtle left (if false, turtle is right)
    //Boolean joint;
    float timeSinceOuch;
    bool careful;
    bool wake;
    float time; //time
    float timeSinceSpawn;
    bool spawnCount;
    bool okToSpawn;
    float timeSinceDeploy;
    float spawnSpeed; //how fast to spawn objects from the plane
    float deploySpeed; //how fast to spawn objects from the rocket
    NSMutableArray *array;
    CCSprite *_plane;
    CCSprite *_knight;
    CCNode *_ouch;
    CCSprite *_rocket;
    CCSprite *_bubble;
    CCNode *_sleepyHit;
    CCLabelTTF *_health;
    CCLabelTTF *_night;
    CCLabelTTF *_clock;
    CCLabelTTF *_streak;
    CCLabelTTF *_points; //round points
    CCLabelTTF *_highScore;
    CCLabelTTF *_message;
    CCButton *_start;
    CCNode *_edge;
    bool called; //the game over/win method should only be called once
    CCPhysicsTouchNode *_touchNode;
    bool start; //freeze gameplay to play the beginning
    bool stopped;
    bool won;
   // NSInteger streak; //determine multiplier bonus by how many missed
    NSInteger pts;
}

#pragma mark - Level Start
- (void)didLoadFromCCB {
    // access audio object
    // play background sound
    
    //_sky.position = ccp(158.8, -1930);
    shown = FALSE;
    _redAlert.visible = FALSE;
    _wake.visible = FALSE;
    _wake.physicsBody.collisionMask = @[];
     _redAlert.zOrder = INT_MAX;
    _dying.visible = FALSE;
    _aboutToDie.visible = FALSE;
    _second.visible = FALSE;
    _third.visible = FALSE;
    _goTwo.enabled = FALSE;
    _begin.visible = FALSE;
    _begin.enabled = FALSE;
    _ouch.visible = FALSE;
    self.started = FALSE;
    _touchNode.game = self;
    _instructions.visible = NO;
    _thoughts.visible = TRUE;
    _won.visible = NO;
    
    //passes in the levelStart method as an object
    //[self performSelector:@selector(levelStart) withObject:nil afterDelay:2.0f];
    
    //tell this scene to accept touches
    //self.userInteractionEnabled = TRUE;
    
    // _turtle = [CCBReader load:@"Turtle"];
    _plane.physicsBody.collisionMask = @[];
    _knight.physicsBody.collisionMask = @[]; 
    _plane.visible = FALSE;
    _rocket.physicsBody.collisionMask = @[];
    _turtle.physicsBody.collisionMask = @[];
    _bubble.physicsBody.collisionMask = @[];
    //_bubble.zOrder = _redAlert.zOrder-2;
    _health.zOrder = 1;
    _redBubble.visible = NO;
    _orangeBubble.visible = NO;
    _yellowBubble.visible = NO;
    _greenBubble.visible = NO;
    _blueBubble.visible = NO;
    
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
    done = FALSE;
    fall = FALSE;
    self.streakNumber = 0;
    NSString *string = [NSString stringWithFormat:@""];
    stopped = FALSE;
    _goNext.enabled = TRUE;
    _goNext.visible = TRUE;
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
    _message.visible = YES;
    okToSpawn = TRUE;
    alert = FALSE;
    
    _start.visible = NO;
    _start.enabled = NO;
    //sleepyHead = [Sleepy init];
    //_wake.visible = NO;
    
    _points.string = @"";
    [_points setFontColor: [CCColor blueColor]];
    //[_points setOutlineColor: [CCColor whiteColor]];
    [_points setShadowColor: [CCColor whiteColor]];
    
    _comment.string = @"";
    
    _highScore.string = @"";
    [_streak setColor : [CCColor blueColor]];
    [_streak setOutlineColor: [CCColor blackColor]];

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

    _night.string = @"Survive to \nSunrise";
    [[self animationManager] runAnimationsForSequenceNamed:@"Ready"];
    //_message.string = @"Flick away objects before\n they hit sleepy head!";
}

#pragma mark pause button
- (BOOL)paused {
    //Pause *pausedPopover = (Pause *)[CCBReader load:@"Pause"];
    //pausedPopover.positionType = CCPositionTypeNormalized;
    //pausedPopover.position = ccp(0.5, 0.5);
    //pausedPopover.zOrder = INT_MAX;
    _stars.string = [NSString stringWithFormat:@"%ld",(long)[[GameData sharedInstance] stars]];
    
    if (!stopped) {
        OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
        [scream playEffect:@"press.wav"];
        [_physicsNode setPaused:YES];
        [[_plane animationManager] setPaused:TRUE];
        [[_knight animationManager] setPaused:TRUE];
        [[_rocket animationManager] setPaused:TRUE];
        [_sky setPaused:YES];
        [_sun setPaused:YES];
        [_moon setPaused:YES];
        // [self addChild:pausedPopover];
        _popup.visible = YES;
        _popup.zOrder = INT_MAX;
        _resume.zOrder = INT_MAX;
        _repeat.zOrder = INT_MAX;
        _paused.zOrder = INT_MAX;
        _home.zOrder = INT_MAX;
        _startag.zOrder = INT_MAX;
        _stars.zOrder = INT_MAX;
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
        _stop.enabled = NO;
        return stopped = true;
    }
    else {
        OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
        [scream playEffect:@"press.wav"];
        [_physicsNode setPaused:NO];
        [_sky setPaused:NO];
        [_sun setPaused:NO];
        [_moon setPaused:NO];
        // [_plane setPaused:NO];
        // [_rocket setPaused:NO];
        [[_plane animationManager] setPaused:FALSE];
        [[_rocket animationManager] setPaused:FALSE];
        [[_knight animationManager] setPaused:FALSE];
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
        _stop.enabled = YES;
        return stopped = false;
    }
}

- (void)home {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    CCScene *leave = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:leave];
}

- (void)resume {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    [_physicsNode setPaused:NO];
    [_sky setPaused:NO];
    [_moon setPaused:NO];
    [_sun setPaused:NO];
    // [_plane setPaused:NO];
    // [_rocket setPaused:NO];
    [[_plane animationManager] setPaused:FALSE];
    [[_rocket animationManager] setPaused:FALSE];
    [[_knight animationManager] setPaused:FALSE];
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

    
    _stop.enabled = YES;
    stopped = false;
}

- (void)repeat {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
}

- (void)runStart{
    [[self animationManager] runAnimationsForSequenceNamed:@"Ready"];
}

- (void)setScore:(NSInteger)score {
    _score = score;
    //_health.string = [NSString stringWithFormat:@"%d", score];
    //378.0, 368.0
    if (score == 5) {
        _health.string = @"zzzzz..";
        _thoughts.scale = 0.6;
    }
    else if (score == 4) {
        _health.string = @"zzzz..";
       // _health.scale = 0.8;
        _thoughts.scale = 0.5;
        _thoughts.visible = TRUE;
        
        //_thoughts.position = ccp(251.8, 51.2);
        
    }
    else if (score == 3) {
        _health.string = @"zzz..";
        //_health.scale = 0.7;
        _thoughts.scale = 0.4;
        _thoughts.visible = TRUE;
        //_thoughts.position = ccp(251.8, 51.2);

    }
    else if (score == 2) {
        _health.string = @"zz..";
       // _health.scale = 0.6;
        _thoughts.scale = 0.3;
        _thoughts.visible = TRUE;
        //_thoughts.position = ccp(251.8, 51.2);

    }
    else if (score == 1) {
        _health.string = @"z..";
       // _health.scale = 0.5;
        _thoughts.scale = 0.2;
        _thoughts.visible = TRUE;
        //_thoughts.position = ccp(251.8, 51.2);


        timeSinceAlert = 0;

        alert = TRUE;
        _aboutToDie.visible = TRUE;
    }
    else if (score <= 0) {
        _health.string = @"";
        _thoughts.visible= FALSE;

    }
}

- (void)readySetGo {

    won = FALSE;
    self.started = TRUE;
    _points.string = @"0";
    _highScore.string = [NSString stringWithFormat:@"Best: %ld", (long)[[GameData sharedInstance] scoreFor:[GameData sharedInstance].level]];
    
    switch ([GameData sharedInstance].level) {
        case 1:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level One"];
            
            if (![GameData sharedInstance].tutorial) {
                _night.string = @"Tutorial";
                spawnSpeed = 2;
                _physicsNode.gravity = ccp(0, -5);
                _plane.position = ccp(250, 250);
                _instructions.visible = YES;
                _instructions.string = @" Flick the sock off screen\n before it hits Sleepy Head";
                [_physicsNode setPaused:NO];
                _stop.enabled = NO;
                [[_plane animationManager] setPaused:TRUE];
                [[_rocket animationManager] setPaused:TRUE];
                [[_knight animationManager] setPaused:TRUE];
                [_sky setPaused:YES];
                [_sun setPaused:YES];
                [_moon setPaused:YES];
            }
            else {
                _night.string = @"Night 1";
                spawnSpeed = 0.5;
                _physicsNode.gravity = ccp(0, -200);
            }
            break;
        case 2:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Two"];
            _night.string = @"Night 2";
            spawnSpeed = 0.5;
            _physicsNode.gravity = ccp(0, -210);
            break;
        case 3:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Three"];
            _night.string = @"Night 3";
            spawnSpeed = 0.45;
            _physicsNode.gravity = ccp(0, -220);
            break;
        case 4:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Four"];
            _night.string = @"Night 4";
            spawnSpeed = 0.55; //0.45 formerly
            deploySpeed = 0.8;
            _physicsNode.gravity = ccp(0, -200);
            break;
        case 5:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Five"];
            _night.string = @"Night 5";
            spawnSpeed = 0.45;
            deploySpeed = 0.75;
            _physicsNode.gravity = ccp(0, -210);
            break;
        case 6:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Six"];
            _night.string = @"Night 6";
            spawnSpeed = 0.45;
            deploySpeed = 0.65;
            int random = arc4random_uniform(15);
            if (random%2 == 0) {
                random = -random;
            }
            _physicsNode.gravity = ccp(random, -230);
            break;
        case 7:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Seven"];
            _night.string = @"Night 7";
            spawnSpeed = 0.45;
            deploySpeed = 0.6;
            int lottery = arc4random_uniform(15);
            if (lottery%2 == 0) {
                lottery = -lottery;
            }
            _physicsNode.gravity = ccp(lottery, -270);
            break;
        case 8:
            [[self animationManager] runAnimationsForSequenceNamed:@"Level Eight"];
            _night.string = @"Night 8";
            spawnSpeed = 0.4;
            deploySpeed = 0.55;
            int chance = arc4random_uniform(15);
            if (chance %2 == 0) {
                chance = -chance;
            }
            _physicsNode.gravity = ccp (chance, -280);
            break;
    }
    
    [_sky runAction:[CCActionMoveBy actionWithDuration:60.f position:ccp(0, 1900)]];
    
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
    _plane.visible = TRUE;
    _knight.visible = TRUE;
    _rocket.visible = TRUE;
    
    CCActionCallFunc *call = [CCActionCallFunc actionWithTarget:self selector:@selector(spawn)];
    CCActionDelay *delay = [CCActionDelay actionWithDuration:0.5f];
    CCActionCallFunc *scream = [CCActionCallFunc actionWithTarget:self selector:@selector(initialize)];
    CCActionSequence *gogo = [CCActionSequence actions:delay, call, scream, nil];
    [self runAction:gogo];
    start = TRUE;
}

-(void)initialize {
    time = 0.0;
    timeSinceSpawn = 0.0;
    timeSinceDeploy = 0.0;
}

#pragma mark - Time-Related Things
- (void)setTime:(double)time {
    if (_hours == 0) {
        _clock.string = @"12:00am";
        if (!fall) {
            [self performSelector:@selector(moonFall) withObject:nil afterDelay:0];
        }
        fall = TRUE;
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
        if (!done) {
            [self performSelector:@selector(sunRise) withObject:nil afterDelay:0];
        }
        done = TRUE;
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
}

- (void)sunRise {
    //_sun.position = ccp(158.8, -800);
    [_sun runAction:[CCActionMoveBy actionWithDuration:15.f position:ccp(0, 100)]];
    //_sun.position = ccp(158.8, 300);
    
}

- (void)moonFall {
    [_moon runAction:[CCActionMoveBy actionWithDuration:50.f position:ccp(0, [CCDirector sharedDirector].viewSize.height*0.6)]];
    //_moon.position = ccp(165.0, 0);
}

- (void)update:(CCTime)delta {
    
    for (Obstacle *obstacle in array) {
        //if obstacle has left the screen, increase score
        //NSLog(@"%f %f", obstacle.position.x, obstacle.position.y);
        
        //if collided is true, add to it...
        if (obstacle.collided) {
            obstacle.timeSinceCollision += delta;
            if (obstacle.timeSinceCollision > 0.1) {
                obstacle.collided = FALSE;
                obstacle.timeSinceCollision = 0;
            }
        }
        
        
        if (!called && obstacle.visible == TRUE && (obstacle.position.x < 0 || obstacle.position.x > [CCDirector sharedDirector].viewSize.width || obstacle.position.y > [CCDirector sharedDirector].viewSize.height)) {
            obstacle.visible = FALSE;
            if (![GameData sharedInstance].tutorial) {
                
                [[GameData sharedInstance] didTutorial];
                _instructions.string = @"Excellent! Let's start\n the REAL game.";
                _start.visible = YES;
                _start.enabled = YES;
                _start.zOrder = INT_MAX;
            }
            else {
            
                self.streakNumber++;
            
                //okToSpawn = TRUE;
                NSLog(@"STREAK: %ld", (long)self.streakNumber);
                //points determination factor
                [self determinePoints:self.streakNumber];
            
                NSString *point = [NSString stringWithFormat:@"%ld", (long)pts];
                _points.string = point;
                NSString *chain = [NSString stringWithFormat:@"x%ld", (long)self.streakNumber];
                _streak.string = chain;
            }
        }
    }
    
    if (start && !stopped) {
        if (alert) {
            timeSinceAlert += delta;
            //NSLog(@"Time Since Alert %f", timeSinceAlert);
        }
        if (self.score == 1 && timeSinceAlert > 0.75 && !called) {
            CCActionShow *visible = [CCActionShow action];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:0.5f];
            CCActionHide *invisible = [CCActionHide action];
            CCActionSequence *visibleAndInvisible = [CCActionSequence actions: visible, delay, invisible, nil];
            [_redAlert runAction:visibleAndInvisible];
            //NSLog(@"LOW HEALTH WARNING");
            timeSinceAlert = -0.5;
            OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
            [scream playEffect:@"redAlert.mp3"];
        }
  
        
        time += delta;
        timeSinceSpawn += delta;
        timeSinceOuch += delta;
        timeSinceDeploy += delta;
        ohSnap += delta;
        
        if (timeSinceOuch > 0.5) {
            _ouch.visible = FALSE;
            timeSinceOuch = 0;
        }
        if (time > 61) {
            _plane.visible = NO;
            _knight.visible = NO;
            _rocket.visible = NO;
        }
        if (time <= 61 && !won) {
            
            //on level seven, eight, and nine, the knight will obscure the room
            if ([GameData sharedInstance].level == 7 || [GameData sharedInstance].level == 8) {
                CCParticleSystem *cloud = (CCParticleSystem *)[CCBReader load:@"dragon"];
                cloud.autoRemoveOnFinish = TRUE;
                cloud.position = ccp((_knight.position.x-60), _knight.position.y);
                [self addChild:cloud];
            }
            
            
            if ([GameData sharedInstance].level == 4 || [GameData sharedInstance].level == 5 || [GameData sharedInstance].level == 6 || [GameData sharedInstance].level == 7 || [GameData sharedInstance].level == 8) {
                CCParticleSystem *flame = (CCParticleSystem *)[CCBReader load:@"smoke"];
                flame.autoRemoveOnFinish = TRUE;
                flame.position = ccp((_rocket.position.x+80), _rocket.position.y);
                //flame.zOrder = INT_MAX;
                [self addChild:flame];
            }
            if (([GameData sharedInstance].level == 4 || [GameData sharedInstance].level == 5 || [GameData sharedInstance].level == 6 || [GameData sharedInstance].level == 7 || [GameData sharedInstance].level == 8) && 20 < _rocket.position.x && _rocket.position.x < [CCDirector sharedDirector].viewSize.width-20 && timeSinceDeploy > deploySpeed) {
                [self deploy];
                //TODO: add those particles

                timeSinceDeploy = 0.0;
            }
            
            if (timeSinceSpawn > spawnSpeed && [GameData sharedInstance].tutorial && time > 0.8) {
                [self spawn];
                
                
                if (!called) {
                    if (time >= 60 && [GameData sharedInstance].tutorial) {
                        self.hours = 6;
                        [self setTime:6];
                        [self determineScore:pts];
                        _won.visible = TRUE;
                        _thoughts.visible = NO;
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
                        //[self win];
                    }
                    else if (time >= 7.5) {
                        self.hours = 0.75;
                        [self setTime:0.75];
                    }
                    else if (time >= 5.0) {
                        self.hours = 0.5;
                        [self setTime:0.5];
                        //[self win];
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

- (void)start {
    [[GameData sharedInstance] doneTutorial];
    NSLog(@"BEGIN!");
    _stop.enabled = YES;
    //restart with level one
    CCScene *mainScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] replaceScene:mainScene];
    /*
    [[_plane animationManager] setPaused:FALSE];
    [[_rocket animationManager] setPaused:FALSE];
    [_sky setPaused:NO];
    [_sun setPaused:NO];
    [_moon setPaused:NO];
    spawnSpeed = 0.5;
    _physicsNode.gravity = ccp(0, -200);
    _start.enabled = NO;
    _start.visible = NO;*/
}

#pragma mark - Turtles Throwing Things
//spawn obstacles for turtle to push
- (void)spawn {
    Obstacle *obstacle;
    if ([GameData sharedInstance].level == 1 && ![GameData sharedInstance].tutorial) {
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)1]; //first level, only light and medium
    }
    else if ([GameData sharedInstance].level == 1) {
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)2];
    }
    else if ([GameData sharedInstance].level == 2 || [GameData sharedInstance].level == 3 || [GameData sharedInstance].level == 4) {
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)3]; //second level, heavy objects come in
    }
    else if ([GameData sharedInstance].level == 5){
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)4]; //parachuting turtles begin spawning on level 5
    }
    else if ([GameData sharedInstance].level == 6 || [GameData sharedInstance].level == 7){
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)5]; //skydiving turtles begin spawning on level 6
    }
    else if ([GameData sharedInstance].level == 8) {
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)6];
    }
    else {
        obstacle = [Obstacle initObstacleForLevel:(NSInteger)6];
    }
    
    obstacle.gameplayLayer = self;
    obstacle.position = ccpSub(_plane.position, ccp(0, 25));
    //obstacle.physicsBody.collisionType = @"items";
    //uncomment to see if they collide
    //obstacle.physicsBody.collisionMask = @[@"items"];
    
    obstacle.zOrder = _plane.zOrder-1;
    boundingBox = obstacle.boundingBox;
    boundingBox.origin = [obstacle.parent convertToWorldSpace:boundingBox.origin];
    [_physicsNode addChild:obstacle]; //add object to the physics world
    //
    NSAssert(obstacle.parent != nil, @"Bodies connected by a joint must be added to the same CCPhysicsNode.");
    
    [array addObject:obstacle]; //add object to the array
    
    //obstacle.position = _plane.position;
}

//this enemy is only present from levels 4-6
- (void)deploy {
    Obstacle *obstacle;
    if ([GameData sharedInstance].level == 4) {
        obstacle = [Obstacle initObstacleForRocket:(NSInteger)2];
    }
    else if ([GameData sharedInstance].level == 5) {
        obstacle = [Obstacle initObstacleForRocket:(NSInteger)3];
    }
    else if ([GameData sharedInstance].level == 6) {
        obstacle = [Obstacle initObstacleForRocket:(NSInteger)4];
    }
   else if ([GameData sharedInstance].level == 7){
        obstacle = [Obstacle initObstacleForRocket:(NSInteger)5];
    }
   else if ([GameData sharedInstance].level == 8){
       obstacle = [Obstacle initObstacleForRocket:(NSInteger)5];
   }
    
    obstacle.gameplayLayer = self;
    obstacle.position = ccpSub(_rocket.position, ccp(0, 25));
    
    //obstacle.physicsBody.collisionType = @"items";
    //uncomment to see if they collide
    //obstacle.physicsBody.collisionMask = @[@"items"];
    
    obstacle.zOrder = _rocket.zOrder-1;
    boundingBox = obstacle.boundingBox;
    boundingBox.origin = [obstacle.parent convertToWorldSpace:boundingBox.origin];
    [_physicsNode addChild:obstacle]; //add object to the physics world
    //
    NSAssert(obstacle.parent != nil, @"Bodies connected by a joint must be added to the same CCPhysicsNode.");
    
    [array addObject:obstacle];
}

#pragma mark - Collisions

//objects can now collide with each other
- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair obstacle:(CCNode *)nodeA obstacle:(CCNode *)nodeB {
    
    if (!called) {
        for (Obstacle *obstacle in array) {
            if (obstacle == nodeA || obstacle == nodeB) {
                //NSLog(@"health was %d", obstacle.health);
                if (!obstacle.collided) {
                    obstacle.health--;
                    obstacle.collided = TRUE;
                    obstacle.timeSinceCollision = 0;
                }
                //NSLog(@"health decreased to %d", obstacle.health);
                
                if (obstacle.health <= 0 && [GameData sharedInstance].tutorial) {
                    [[_physicsNode space] addPostStepBlock:^{
                        //[self obstacleRemoved:nodeB];
                        CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Impact"];
                        explosion.autoRemoveOnFinish = TRUE;
                        explosion.position = obstacle.position;
                        [obstacle.parent addChild:explosion];
                        obstacle.visible = FALSE;
                        obstacle.physicsBody.collisionMask = @[]; //can't collide with the object anymore
                    } key:obstacle];
                    
                    //explosions!
                    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
                    [scream playEffect:@"quieterExplosion.wav"];
                    
                    self.streakNumber++;
                    [self determinePoints:self.streakNumber];
                    
                    //okToSpawn = TRUE;
                   // NSLog(@"STREAK: %d", self.streakNumber);
                    //points determination factor
              
                    NSString *point = [NSString stringWithFormat:@"%d", pts];
                    _points.string = point;
                    NSString *chain = [NSString stringWithFormat:@"x%d", self.streakNumber];
                    _streak.string = chain;
                }
            }
        }
    }
    return true; //TODO: this used to be false
}

//if an obstacle collides with the ceiling, remove it from play
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair obstacle:(Obstacle *)nodeA edge:(CCNode *)nodeB {
    
    nodeA.visible = FALSE;
    nodeA.physicsBody.collisionMask = @[];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair sleepy:(CCNode *)nodeA obstacle:(Obstacle *)nodeB {
    //NSLog(@"density: %d", nodeB.density);
    
    
    CCActionMoveBy *vibrateUp = [CCActionMoveBy actionWithDuration:0.05f position:ccp(0, 5)];
    CCActionMoveBy *vibrateDown = [CCActionMoveBy actionWithDuration:0.05f position:ccp(0, -5)];
    CCActionSequence *vibration = [CCActionSequence actions: vibrateUp, vibrateDown, vibrateUp, vibrateDown,
                                   vibrateUp, vibrateDown, vibrateUp, vibrateDown, nil];
    
    CCActionMoveBy *up = [CCActionMoveBy actionWithDuration:0.05f position:ccp(0, 5)];
    CCActionMoveBy *down = [CCActionMoveBy actionWithDuration:0.05f position:ccp(0, -5)];
   /* CCActionSequence *upDown = [CCActionSequence actions: up, down, up, down,
                                   up, down, up, down, nil];*/
    bool vibrate = FALSE;
    if (!called && !nodeB.collided) {
        _ouch.visible = TRUE;
        
        if (![GameData sharedInstance].tutorial) {
            _instructions.string = @"Don't hit Sleepy Head!";
            [self spawn];
        }
        timeSinceOuch = 0;
        if (nodeB.density < 25){ //light object effects
            self.score--;
            OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
            [scream playEffect:@"grunting.wav"];
            if (!vibrate) {
                [_thoughts runAction:vibration];
                //[_health runAction:upDown];
                vibrate = TRUE;
            }
            //_sleepyHit.opacity = 1.0;
            
            nodeB.collided = true;
            //NSLog(@"%d", self.score);
        }
        else if (nodeB.density < 50) { //medium object effects
            self.score = self.score/2;
            OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
            [scream playEffect:@"grunting.wav"];
            //_sleepyHit.opacity = 1.0;
            nodeB.collided = true;
            if (!vibrate) {
                [_thoughts runAction:vibration];
               // [_health runAction:upDown];
                vibrate = TRUE;
            }
            //NSLog(@"%d", self.score);
        }
        else { //heavy object effects
            self.score = self.score - 5; //game over!
            //_sleepyHit.opacity = 1.0;
            nodeB.collided = true;
            if (!vibrate) {
                [_thoughts runAction:vibration];
                //[_health runAction:upDown];
                vibrate = TRUE;
            }
            //NSLog(@"%d", self.score);
        }
        if (self.score <= 0 && [GameData sharedInstance].tutorial) {
            //_sleepyHit.opacity = 0.0;
            _wake.visible = TRUE;
            //_sleepyHit.visible = FALSE;
            if (!vibrate) {
                [_thoughts runAction:vibration];
               // [_health runAction:upDown];
                vibrate = TRUE;
            }
            //TODO: the bubble should do something different when you die
            [self lose];
        }
        else if (self.score <= 0 && ![GameData sharedInstance].tutorial){
            _wake.visible = TRUE;
            //OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
            //[scream playEffect:@"screamer.wav"];

            if (!vibrate) {
                [_thoughts runAction:vibration];
               // [_health runAction:upDown];
            }
            _instructions.string = @"If Sleepy Head's dream \nbursts, you lose!";
           // [self stopAction:vibration];
           // [self stopAction:upDown];
        }
        if (!shown) {
            CCActionShow *visible = [CCActionShow action];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:0.3f];
            CCActionHide *invisible = [CCActionHide action];
            CCActionSequence *visibleAndInvisible = [CCActionSequence actions: visible, delay, invisible, nil];
            [_dying runAction:visibleAndInvisible];
            shown = true;
        }
        //careful.visible = YES;
        //careful = TRUE;
        //timeSinceCareful = 0;
        
        _sleepyHit.opacity = 0.0;
        self.streakNumber = 0;
        [_points setFontColor: [CCColor blueColor]];
        [_streak setColor: [CCColor blueColor]];
        [_points setOutlineColor:[CCColor whiteColor]];
        [_points setShadowColor: [CCColor whiteColor]];
        [_comment setOutlineColor: [CCColor blackColor]];
        [_streak setOutlineColor: [CCColor blackColor]];
        _streak.fontSize = 20;
        _redBubble.visible = NO;
        _orangeBubble.visible = NO;
        _yellowBubble.visible = NO;
        _greenBubble.visible = NO;
        _blueBubble.visible = NO;
        
        okToSpawn = TRUE;
        _streak.string = @"";
        _comment.string = @"";
        _streak.zOrder = INT_MAX-2;
        shown = FALSE;
        vibrate = FALSE;
        
        [[_physicsNode space] addPostStepBlock:^{
            //[self obstacleRemoved:nodeB];
            CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Impact"];
            explosion.autoRemoveOnFinish = TRUE;
            explosion.position = nodeB.position;
            [nodeB.parent addChild:explosion];
            nodeB.visible = FALSE;
            nodeB.physicsBody.collisionMask = @[];
        } key:nodeB];
    }


}

-(void)flipTurtle {
    _plane.flipX = !_plane.flipX;
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
    //CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"Impact"];
    //explosion.autoRemoveOnFinish = TRUE;
    //explosion.position = _plane.position;
    //[self addChild:explosion];
    _plane.visible = NO;
    
    //CCParticleSystem *bang = (CCParticleSystem *)[CCBReader load:@"Impact"];
    //bang.autoRemoveOnFinish = TRUE;
    //bang.position = _knight.position;
    //[self addChild:bang];
    _knight.visible = NO;
    
   // CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"Impact"];
   // bam.autoRemoveOnFinish = TRUE;
    //bam.position = _rocket.position;
    //[self addChild:bam];
    _rocket.visible = NO;
    [self endGameWithMessageWin:@"Survived to sunrise!"];
    //[GameData sharedInstance].level++;
    //NSLog(@"%ld", (long)[GameData sharedInstance].level);
    [[NSUserDefaults standardUserDefaults] setInteger:[GameData sharedInstance].level forKey:@"Level Number"];
    won = TRUE;
}

//Sleepy Head's hitpoints completely depleted
- (void)lose {
    _stop.enabled = NO;
    [_sky setPaused:YES];
    [_sun setPaused:YES];
    [_moon setPaused:YES];
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    //[scream playEffect:@"screamer.wav"];
    id<ALSoundSource>screamSound = [scream playEffect:@"terror.wav"];
    [self scheduleBlock:^(CCTimer *timer) {
        [screamSound stop];
    } delay:2.0];
   
    
    [audio stopBg];
    audio = [OALSimpleAudio sharedInstance];
    // play background sound
    [audio playBg:@"pianoBG.wav" loop:TRUE];
    [self endGameWithMessageLose:@"A rude awakening!"];
}

//pause button disabled upon game end
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
    _stop.enabled = NO;
    
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
        
        CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"Winning"];
        bam.autoRemoveOnFinish = TRUE;
        bam.position = _sun.position;
        bam.zOrder = INT_MAX;
        [self addChild:bam];
        done = TRUE;
        
        for (Obstacle *obstacle in array) {
            obstacle.visible = FALSE;
        }
    }
}

- (NSInteger)incrementLevel{
    if ([GameData sharedInstance].level < 8) {
        [GameData sharedInstance].level++;
    }
    //NSLog(@"%d", [GameData sharedInstance].level);
    return [GameData sharedInstance].level;
}

//based on the score, tell determineStars how many stars to give
- (void)determineScore:(NSInteger)pointsEarned{
   // NSLog(@"POINTS: %ld", (long)pointsEarned);
    
    [[GameData sharedInstance] setScore: pointsEarned];
    
    
    
    if ([GameData sharedInstance].level == 1) {
        if (pointsEarned > 11400) {
            [self determineStars:3];
        }
        else if (pointsEarned > 8720) {
            [self determineStars:2];
        }
        else if (pointsEarned > 6705) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
    }
    else if ([GameData sharedInstance].level == 2) {
        if (pointsEarned > 11400) {
            [self determineStars:3];
        }
        else if (pointsEarned > 8720) {
            [self determineStars:2];
        }
        else if (pointsEarned > 6705) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
        
    }
    else if ([GameData sharedInstance].level == 3) {
        if (pointsEarned > 15160) {
            [self determineStars:3];
        }
        else if (pointsEarned > 11590) {
            [self determineStars:2];
        }
        else if (pointsEarned > 8920) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
        
    }
    else if ([GameData sharedInstance].level == 4) {
        if (pointsEarned > 18110) {
            [self determineStars:3];
        }
        else if (pointsEarned > 13850) {
            [self determineStars:2];
        }
        else if (pointsEarned > 10650) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
    }
    else if ([GameData sharedInstance].level == 5) {
        if (pointsEarned > 29707) {
            [self determineStars:3];
        }
        else if (pointsEarned > 22720) {
            [self determineStars:2];
        }
        else if (pointsEarned > 17475) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
    }
    else if ([GameData sharedInstance].level == 6) {
        if (pointsEarned > 29105) {
            [self determineStars:3];
        }
        else if (pointsEarned > 21490) {
            [self determineStars:2];
        }
        else if (pointsEarned > 16530) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
    }
    
    else if ([GameData sharedInstance].level == 7) {
        if (pointsEarned > 21180) {
            [self determineStars:3];
        }
        else if (pointsEarned > 16190) {
            [self determineStars:2];
        }
        else if (pointsEarned > 12455) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
    }
    else if ([GameData sharedInstance].level == 8) {
        if (pointsEarned > 38645) {
            [self determineStars:3];
        }
        else if (pointsEarned > 29550) {
            [self determineStars:2];
        }
        else if (pointsEarned > 22730) {
            [self determineStars:1];
        }
        else {
            [self determineStars:0];
        }
    }
}

//convey how many stars were earned in the level to the shared instance
- (void)determineStars:(NSInteger)stars{
    //NSLog(@"You earned %ld stars", (long)stars);
    [[GameData sharedInstance] setStars:stars];
}

- (void)determinePoints:(NSInteger)chain {
    if (chain < 10) {
        pts = pts + 1.2*chain;
        _streak.fontSize = 20;
        //_streak.zOrder = _redAlert.zOrder -1;
        _streak.zOrder = INT_MAX-2;
        [_streak setColor: [CCColor blueColor]];
        [_comment setOutlineColor: [CCColor blackColor]];
        [_streak setOutlineColor: [CCColor blackColor]];
        [_points setOutlineColor:[CCColor whiteColor]];
        [_points setShadowColor: [CCColor whiteColor]];

        _blueBubble.visible = YES;
        CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
        [_points runAction:growAndShrink];
        
        CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"LeastIntense"];
        boom.autoRemoveOnFinish = TRUE;
        boom.position = _streak.positionInPoints;
        [self addChild:boom];
        
        CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"LeastIntense"];
        bam.autoRemoveOnFinish = TRUE;
        bam.position = _points.positionInPoints;
        [self addChild:bam];
        
        CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
        [_streak runAction:bigAndSmall];
        
        CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
        [_blueBubble runAction:popAndPush];
        
        CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
        CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
        CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
        [_comment runAction:UpAndDown];
    }
    else if (10 <= chain && chain < 25) {
        pts = pts + 1.4*chain;
        [_streak setColor: [CCColor greenColor]];
        [_points setFontColor: [CCColor greenColor]];
        [_comment setColor: [CCColor greenColor]];
        [_points setOutlineColor:[CCColor whiteColor]];
          [_points setShadowColor: [CCColor whiteColor]];
        [_comment setOutlineColor: [CCColor blackColor]];
        [_streak setOutlineColor: [CCColor blackColor]];

        
        _streak.fontSize = 22;
        
        _blueBubble.visible = NO;
        _greenBubble.visible = YES;
        _streak.zOrder = INT_MAX-2;
        _comment.string = @"Fresh!";
        CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
        [_streak runAction:bigAndSmall];
        //TODO: scale by positive action, scale by negative action
        CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"FourthIntense"];
        boom.autoRemoveOnFinish = TRUE;
        boom.position = _streak.positionInPoints;
        [self addChild:boom];
        
        CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"FourthIntense"];
        bam.autoRemoveOnFinish = TRUE;
        bam.position = _points.positionInPoints;
        [self addChild:bam];
        
        CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
        [_greenBubble runAction:popAndPush];
        
        CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
        CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
        CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
        [_comment runAction:UpAndDown];
    }
    else if (25 <= chain && chain < 50) {
        pts = pts + 1.6*chain;
        _greenBubble.visible = NO;
        _yellowBubble.visible = YES;
        _streak.fontSize = 24;
        
        [_streak setColor: [CCColor brownColor]];
        [_points setFontColor: [CCColor brownColor]];
        [_comment setColor: [CCColor brownColor]];
        
        [_points setOutlineColor:[CCColor whiteColor]];
          [_points setShadowColor: [CCColor whiteColor]];
        [_comment setOutlineColor: [CCColor blackColor]];
        [_streak setOutlineColor: [CCColor blackColor]];

        _streak.zOrder = INT_MAX-2;
        
        
        CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"ThirdIntense"];
        boom.autoRemoveOnFinish = TRUE;
        boom.position = _streak.positionInPoints;
        [self addChild:boom];
        
        CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"ThirdIntense"];
        bam.autoRemoveOnFinish = TRUE;
        bam.position = _points.positionInPoints;
        [self addChild:bam];
        
        //NSLog(@"yellow should be visible");
        _comment.string = @"Smooth!";
        CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
        [_points runAction:growAndShrink];
       
        
        CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
        [_streak runAction:bigAndSmall];
        
        CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
        [_yellowBubble runAction:popAndPush];
        
        CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
        CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
        CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
        [_comment runAction:UpAndDown];
    }
    else if (50 <= chain && chain < 100) {
        pts = pts + 1.8*chain;
        _streak.fontSize = 26;
        
        _yellowBubble.visible = NO;
        _orangeBubble.visible = YES;
        [_streak setColor: [CCColor orangeColor]];
        [_points setFontColor: [CCColor orangeColor]];
        [_comment setColor: [CCColor orangeColor]];
        
        [_points setOutlineColor:[CCColor whiteColor]];
          [_points setShadowColor: [CCColor whiteColor]];
        [_comment setOutlineColor: [CCColor blackColor]];
        [_streak setOutlineColor: [CCColor blackColor]];


        _streak.zOrder = INT_MAX-2;
        CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"SecondIntense"];
        boom.autoRemoveOnFinish = TRUE;
        boom.position = _streak.positionInPoints;
        [self addChild:boom];
        
        CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"SecondIntense"];
        bam.autoRemoveOnFinish = TRUE;
        bam.position = _points.positionInPoints;
        [self addChild:bam];
        
        _comment.string = @"Dreamy!";
        CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
        //[_comment runAction:growAndShrink];
        [_points runAction:growAndShrink];
        
        CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
        [_streak runAction:bigAndSmall];
        //NSLog(@"orange should be visible");
        
        CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
        [_orangeBubble runAction:popAndPush];
        
        CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
        CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
        CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
        [_comment runAction:UpAndDown];
    }
    else {
        pts = pts + 2.0*chain;
        _streak.fontSize = 28;
        _orangeBubble.visible = NO;
        _redBubble.visible = YES;
        [_streak setColor: [CCColor redColor]];
        [_points setFontColor: [CCColor redColor]];
        [_comment setColor: [CCColor redColor]];
        
        [_points setOutlineColor:[CCColor whiteColor]];
          [_points setShadowColor: [CCColor whiteColor]];
        [_comment setOutlineColor: [CCColor blackColor]];
        [_streak setOutlineColor: [CCColor blackColor]];


        _streak.zOrder = INT_MAX-2;
        CCParticleSystem *boom = (CCParticleSystem *)[CCBReader load:@"MostIntense"];
        boom.autoRemoveOnFinish = TRUE;
        boom.position = _streak.positionInPoints;
        [self addChild:boom];
        
        
        CCParticleSystem *bam = (CCParticleSystem *)[CCBReader load:@"MostIntense"];
        bam.autoRemoveOnFinish = TRUE;
        bam.position = _points.positionInPoints;
        [self addChild:bam];
        
        _comment.string = @"Sweet!";
        CCActionScaleTo *grow = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *shrink = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *growAndShrink = [CCActionSequence actions: grow, shrink, nil];
        //[_comment runAction:growAndShrink];
        [_points runAction:growAndShrink];
        
        CCActionScaleTo *big = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *small = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *bigAndSmall = [CCActionSequence actions: big, small, nil];
        [_streak runAction:bigAndSmall];
        //NSLog(@"red should be visible");
        
        CCActionScaleTo *push = [CCActionScaleTo actionWithDuration:0.1f scale:1.25];
        CCActionScaleTo *pop = [CCActionScaleTo actionWithDuration:0.1f scale:0.8];
        CCActionSequence *popAndPush = [CCActionSequence actions: push, pop, nil];
        [_redBubble runAction:popAndPush];
        
        CCActionScaleTo *up = [CCActionScaleTo actionWithDuration:0.1f scaleX:1.25 scaleY:1];
        CCActionScaleTo *down = [CCActionScaleTo actionWithDuration:0.1f scaleX:0.8 scaleY:1];
        CCActionSequence *UpAndDown = [CCActionSequence actions: up, down, nil];
        [_comment runAction:UpAndDown];
    }
}

@end



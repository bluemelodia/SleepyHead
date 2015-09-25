//
//  GameData.m
//  melaniehsu
//
//  Created by Melanie Hsu on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameData.h"
#import "Win.h"
#import "Select.h"

static NSString *const GAME_STATE_LEVEL_KEY = @"GameStateLevelKey";
static NSString *const GAME_STATE_STAR_KEY = @"GameStateStarKey";
static NSString *const GAME_STATE_STAR_ARRAY = @"GameStateStarArray";
static NSString *const GAME_STATE_LEVEL_ARRAY = @"GameStateLevelArray";
static NSString *const GAME_STATE_SCORE_ARRAY = @"GameStateScoreArray";
static NSString *const GAME_STATE_TUTORIAL_KEY = @"GameStateTutorialKey";
static NSString *const GAME_STATE_NAMED_KEY = @"GameStateNamedKey";
static NSString *const GAME_STATE_NAME_KEY = @"GameStateNameKey";
static NSString *const GAME_STATE_SUBMITTED_KEY = @"GameStateSubmittedKey";
static NSString *const GAME_STATE_USERNAME_ARRAY = @"GameStateUsernameKey";
static NSString *const GAME_STATE_HIGHSCORE_KEY = @"GameStateHighScoreKey";


static NSInteger MAX_LEVEL = 10;
NSInteger currentStar = 0;
//TODO: make a boolean array for the levels

@implementation GameData

+ (instancetype)sharedInstance {
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc]init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        if (![[NSUserDefaults standardUserDefaults]integerForKey:GAME_STATE_LEVEL_KEY]) {
            [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:GAME_STATE_LEVEL_KEY];
        }
        self.level = [[NSUserDefaults standardUserDefaults]integerForKey:GAME_STATE_LEVEL_KEY];
        
        if (![[NSUserDefaults standardUserDefaults]integerForKey:GAME_STATE_STAR_KEY]) {
            [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:GAME_STATE_STAR_KEY];
        }
        
        if (![[NSUserDefaults standardUserDefaults]boolForKey:GAME_STATE_TUTORIAL_KEY]) {
            [[NSUserDefaults standardUserDefaults]setBool:FALSE forKey:GAME_STATE_TUTORIAL_KEY];
        }
        else {
            self.tutorial = [[NSUserDefaults standardUserDefaults]boolForKey:GAME_STATE_TUTORIAL_KEY];
        }
        if (![[NSUserDefaults standardUserDefaults]objectForKey:GAME_STATE_NAME_KEY]) {
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:GAME_STATE_NAME_KEY];
            //[[NSUserDefaults standardUserDefaults]set:@"" forKey:GAME_STATE_NAME_KEY];
        }
        else {
            self.name = [[NSUserDefaults standardUserDefaults]objectForKey:GAME_STATE_NAME_KEY];
            //self.name = [[NSUserDefaults standardUserDefaults]NSStringForKey:GAME_STATE_NAME_KEY];
        }
        if (![[NSUserDefaults standardUserDefaults]boolForKey:GAME_STATE_NAMED_KEY]) {
            [[NSUserDefaults standardUserDefaults]setBool:FALSE forKey:GAME_STATE_NAMED_KEY];
        }
        else {
            self.named = [[NSUserDefaults standardUserDefaults]boolForKey:GAME_STATE_NAMED_KEY];
        }
        if (![[NSUserDefaults standardUserDefaults]boolForKey:GAME_STATE_SUBMITTED_KEY]) {
            [[NSUserDefaults standardUserDefaults]setBool:FALSE forKey:GAME_STATE_SUBMITTED_KEY];
        }
        else {
            self.submitted = [[NSUserDefaults standardUserDefaults]boolForKey:GAME_STATE_SUBMITTED_KEY];
        }
        if (![[NSUserDefaults standardUserDefaults]integerForKey:GAME_STATE_HIGHSCORE_KEY]) {
            [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:GAME_STATE_HIGHSCORE_KEY];
        }
        else {
            self.highScore = [[NSUserDefaults standardUserDefaults]integerForKey:GAME_STATE_HIGHSCORE_KEY];
        }
        if (![[NSUserDefaults standardUserDefaults]objectForKey:GAME_STATE_STAR_ARRAY]) {
            self.starRec = [NSMutableArray array];
            //in the beginning, you have no stars for each level
            for (int i = 0; i < MAX_LEVEL; i++) {
                [self.starRec insertObject:[NSNumber numberWithInt: 0] atIndex:i];
            }
            [[NSUserDefaults standardUserDefaults]setObject:self.starRec forKey:GAME_STATE_STAR_ARRAY];
        }
        else {
            self.starRec = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey: GAME_STATE_STAR_ARRAY]];
        }
        if (![[NSUserDefaults standardUserDefaults] objectForKey:GAME_STATE_USERNAME_ARRAY]) {
            self.nameRec = [NSMutableArray array];
            [[NSUserDefaults standardUserDefaults]setObject:self.nameRec forKey:GAME_STATE_USERNAME_ARRAY];
        }
        else {
            self.nameRec = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey: GAME_STATE_USERNAME_ARRAY]];
        }
        
        if (![[NSUserDefaults standardUserDefaults]objectForKey:GAME_STATE_SCORE_ARRAY]) {
            self.scoreRec = [NSMutableArray array];
            for (int i = 0; i < MAX_LEVEL; i++) {
                [self.scoreRec insertObject:[NSNumber numberWithInt: 0] atIndex:i];
            }
            [[NSUserDefaults standardUserDefaults]setObject:self.scoreRec forKey:GAME_STATE_SCORE_ARRAY];
        }
        else {
            self.scoreRec = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey: GAME_STATE_SCORE_ARRAY]];
        }
        if (![[NSUserDefaults standardUserDefaults]objectForKey:GAME_STATE_LEVEL_ARRAY]) {
            //in the beginning, only level one is playable
            NSNumber *yes = [NSNumber numberWithBool:YES];
            NSNumber *no = [NSNumber numberWithBool:NO];
            self.levelRec = [[NSMutableArray alloc] initWithObjects:
                             yes, no, no, no, no, no, no, no, no, no, nil];
        }
        else {
            self.levelRec = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey: GAME_STATE_LEVEL_ARRAY]];
        }
//        self.starRec = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey:GAME_STATE_STAR_ARRAY]];
//        self.scoreRec = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey:GAME_STATE_SCORE_ARRAY]];
 
        self.stars = [[NSUserDefaults standardUserDefaults]integerForKey:GAME_STATE_STAR_KEY];
    }
    return self;
}

#pragma mark - Setter Override

- (bool)didTutorial {
    NSLog(@"Player did the tutorial: %d", self.tutorial);
    [MGWU logEvent:@"tutorialComplete" withParams:nil];
    return self.tutorial;
}

- (void)doneTutorial {
    self.tutorial = TRUE;
    [[NSUserDefaults standardUserDefaults]setBool:TRUE forKey:GAME_STATE_TUTORIAL_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)doneSubmit {
    self.named = TRUE;
    [[NSUserDefaults standardUserDefaults]setBool:TRUE forKey:GAME_STATE_NAMED_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)submittedScore {
    self.submitted = TRUE;
    [[NSUserDefaults standardUserDefaults]setBool:TRUE forKey:GAME_STATE_SUBMITTED_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//each time you top the score, you set it to false - then after submission, set it back to true
-(void)updatedScore {
    self.submitted = FALSE;
    [[NSUserDefaults standardUserDefaults]setBool:TRUE forKey:GAME_STATE_SUBMITTED_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)saveName:(NSString*)namae {
    self.name = [NSString stringWithFormat:@"%@", namae];
    NSLog(@"saving %@", namae);
    NSLog(@"self.name is %@", self.name);
    [[NSUserDefaults standardUserDefaults]setObject:self.name forKey:GAME_STATE_NAME_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(NSString*)getName {
    return self.name;
}

- (void)setLevel:(NSInteger)level {
    _level = level;
    
    NSNumber *levelNumber = [NSNumber numberWithInt:level];
    
    // broadcast change
    [[NSNotificationCenter defaultCenter]postNotificationName:GAME_STATE_LEVEL_NOTIFICATION object:levelNumber];
    
    // store change
    [[NSUserDefaults standardUserDefaults]setInteger:level forKey:GAME_STATE_LEVEL_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//update the score if it exceeds the current score
- (void)setScore:(NSInteger)score {
    //NSLog(@"current high score: %d", [[self.scoreRec objectAtIndex:self.level-1] intValue]);
    if (score > [[self.scoreRec objectAtIndex:self.level-1] intValue]) {
        [self.scoreRec replaceObjectAtIndex:(self.level-1) withObject:[NSNumber numberWithInt:score]];
    }
    [[NSUserDefaults standardUserDefaults]setObject:self.scoreRec forKey:GAME_STATE_SCORE_ARRAY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void) newHighScore:(NSInteger)highScore {
    self.highScore = highScore;
    NSLog(@"HIGH SCORE: %d", self.highScore);
    [[NSUserDefaults standardUserDefaults]setInteger:self.highScore forKey:GAME_STATE_HIGHSCORE_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSInteger) getHighScore {
    NSLog(@"PREVIOUS HIGH: %d", self.highScore);
    return self.highScore;
}

//what is their highest score? 
- (NSInteger)scoreFor:(NSInteger)level {
    //NSLog(@"return high score: %d", [[self.scoreRec objectAtIndex:level-1] intValue]);
    return [[self.scoreRec objectAtIndex:level-1] intValue];
}

//how many stars did they get for this level?
- (NSInteger)starsFor:(NSInteger)level {
    return [[self.starRec objectAtIndex:level-1] intValue];
}

- (NSMutableArray*) getNames {
    return self.nameRec;
}

- (void)addName:(NSString*)label {
    [self.nameRec addObject:label];
    [[NSUserDefaults standardUserDefaults]setObject:self.nameRec forKey:GAME_STATE_USERNAME_ARRAY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)setStars:(NSInteger)stars {
    //three stars is the highest you can get, so always update to that
   // NSLog(@"Stars passed in: %ld", (long)stars);
   // NSLog(@"Original array had: %d", [[self.starRec objectAtIndex:self.level-1] intValue]);
    
    if (stars == 3) {
        //self.stars += stars - [[self.starRec objectAtIndex:self.level-1] intValue];
       // NSLog(@"Now, star count is %ld", (long)self.stars);
        [self.starRec replaceObjectAtIndex:(self.level-1) withObject:[NSNumber numberWithInt:3]]; //0
        //NSLog(@"Index has %d stars", [[self.starRec objectAtIndex:self.level-1] intValue]);
        //[myMutableArray replaceObjectAtIndex:index withObject:newObject];
    }
    //get two stars, have two stars - two stars
    else if ((stars == 2) && [[self.starRec objectAtIndex:self.level] isEqual:[NSNumber numberWithInt: 2]])
    {
        [self.starRec replaceObjectAtIndex:self.level-1 withObject:[NSNumber numberWithInt:2]];
    }
    //if you get two stars, update to two stars if you have fewer than two stars
    else if ((stars == 2) && ([[self.starRec objectAtIndex:self.level-1] isEqual:[NSNumber numberWithInt: 0]] || [[self.starRec objectAtIndex:0] isEqual:[NSNumber numberWithInt: 1]])) {
        //self.stars += stars - [[self.starRec objectAtIndex:self.level-1] intValue];
        [self.starRec replaceObjectAtIndex:self.level-1 withObject:[NSNumber numberWithInt:2]];
    }
    //if you get one star, and have one star - one star
    else if((stars == 1) && [[self.starRec objectAtIndex:self.level-1] isEqual:[NSNumber numberWithInt: 1]]) {
        [self.starRec replaceObjectAtIndex:self.level-1 withObject:[NSNumber numberWithInt:1]];
    }
    //if you get one star, and you don't have any stars - one star
    else if ((stars == 1) && [[self.starRec objectAtIndex:self.level-1] isEqual:[NSNumber numberWithInt: 0]]){
        //self.stars += stars - [[self.starRec objectAtIndex:self.level-1] intValue];
        [self.starRec replaceObjectAtIndex:self.level-1 withObject:[NSNumber numberWithInt:1]];
    }
    else if (stars == 0 && [[self.starRec objectAtIndex:self.level-1] isEqual:[NSNumber numberWithInt: 0]]){
        //no change
    }
    
    currentStar = stars;
    //NSLog(@"Earned %@ stars for level %ld", [self.starRec objectAtIndex:self.level-1], (long)self.level);
    
    int count = 0;
    for (int i = 0; i < MAX_LEVEL; i++) {
        count += [[self.starRec objectAtIndex:i] intValue];
    }
    //self.stars = count; //update the star count by iterating through all of the array
    NSNumber *starNumber = [NSNumber numberWithInt:count];
    //NSLog(@"star count: %@", starNumber);
    [[NSUserDefaults standardUserDefaults]setObject:self.starRec forKey:GAME_STATE_STAR_ARRAY];
    //NSNumber *starNumber = [NSNumber numberWithInt:self.stars];
    
    // broadcast change
    [[NSNotificationCenter defaultCenter]postNotificationName:GAME_STATE_STAR_NOTIFICATION object:starNumber];
    
    // store change
    [[NSUserDefaults standardUserDefaults]setObject:starNumber forKey:GAME_STATE_STAR_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//is level unlocked?
- (BOOL)locked: (NSInteger)level {
    BOOL lock = [[self.levelRec objectAtIndex:level-1] boolValue];
    return lock;
}

//unlock a level, and remember that it was unlocked
- (void)unlock: (NSInteger)lvl {
    if (lvl <= MAX_LEVEL) {
        //NSLog(@"Level passed in: %ld", (long)lvl);
        //level unlocks
        [self.levelRec replaceObjectAtIndex:lvl-1 withObject:[NSNumber numberWithBool:YES]];
        [[NSUserDefaults standardUserDefaults]setObject:self.levelRec forKey:GAME_STATE_LEVEL_ARRAY];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        Select *choose = [[Select alloc] init];
        [choose enable:lvl];
        /*S
        if (level == 2) {
            choose.leveltwobutton.enabled = YES;
        }
        else if (level == 3) {
            choose.levelthreebutton.enabled = YES;
        }
        else if (level == 4) {
            choose.levelfourbutton.enabled = YES;
        }
        else if (level == 5) {
            choose.levelfivebutton.enabled = YES; 
        }*/
    }
}

//need to update the label
- (NSInteger)stars {
    int count = 0;
    for (int i = 0; i < MAX_LEVEL; i++) {
        count += [[self.starRec objectAtIndex:i] intValue];
    }
    return count;
}

- (NSInteger)getStars{
    NSInteger num = currentStar; //you should not be giving the array entry, becuase once they get three stars it will always be perfect
    //NSLog(@"Display: Earned %ld stars for level %ld", (long)num, (long)self.level);
    return num;
}

- (void)resetTutorial {
    self.tutorial = FALSE;
    NSLog(@"tutorial set to %d", self.tutorial);
    [[NSUserDefaults standardUserDefaults]setBool:TRUE forKey:GAME_STATE_TUTORIAL_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)resetLocks {
    for (int i = 1; i < MAX_LEVEL; i++) {
        [self.levelRec replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
    }
    [[NSUserDefaults standardUserDefaults]setObject:self.levelRec forKey:GAME_STATE_LEVEL_ARRAY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (void)resetStars {
    for (int i = 0; i < MAX_LEVEL; i++) {
        [self.starRec replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
    }
    NSNumber *starNumber = [NSNumber numberWithInt:0];
    [[NSUserDefaults standardUserDefaults]setObject:self.starRec forKey:GAME_STATE_STAR_ARRAY];
    
    // broadcast change
    [[NSNotificationCenter defaultCenter]postNotificationName:GAME_STATE_STAR_NOTIFICATION object:starNumber];
    
    // store change
    [[NSUserDefaults standardUserDefaults]setObject:starNumber forKey:GAME_STATE_STAR_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
//
//  GameData.h
//  melaniehsu
//
//  Created by Melanie Hsu on 7/21/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const GAME_STATE_LEVEL_NOTIFICATION = @"GameState_LevelChanged";
static NSString *const GAME_STATE_STAR_NOTIFICATION = @"GameState_StarChanged";

@interface GameData : NSObject

+ (instancetype)sharedInstance;
- (NSInteger)getStars;
- (void)resetStars;
- (void)resetLocks;
- (BOOL)locked: (NSInteger)level;
- (void)unlock: (NSInteger)level;
- (NSInteger)starsFor:(NSInteger)level;
- (NSInteger)scoreFor:(NSInteger)level;
- (void)setScore:(NSInteger)score;
- (void)setStars1:(NSInteger)stars;
- (NSInteger)getScore:(NSInteger)level;
-(void)saveName:(NSString*)namae;
-(NSString*)getName;
//- (bool)didTutorial;
- (bool)didTutorial;
- (void)doneTutorial;
- (void)resetTutorial;
-(void)doneSubmit;
-(void)updatedScore;
-(void)submittedScore;
-(void)addName:(NSString*)label;
- (NSMutableArray*) getNames;
- (void) newHighScore:(NSInteger)highScore;
- (NSInteger) getHighScore;

@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger stars;
@property (nonatomic, assign) NSInteger highScore;
@property (nonatomic, assign) BOOL tutorial;
@property (nonatomic, assign) BOOL named;
@property (nonatomic, assign) BOOL submitted; 
@property (nonatomic, strong) NSMutableArray *starRec;
@property (nonatomic, strong) NSMutableArray *nameRec;
@property (nonatomic, strong) NSMutableArray *levelRec;
@property (nonatomic, strong) NSMutableArray *scoreRec;
@property (nonatomic, strong) NSString *name;
//@property (nonatomic, assign) NSInteger _starCount;

@end
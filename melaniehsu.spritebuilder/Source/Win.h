//
//  Win.h
//  melaniehsu
//
//  Created by Melanie Hsu on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
@class Gameplay;

@interface Win : CCNode

@property (nonatomic, weak) Gameplay* gameplayLayer;
@property (nonatomic, assign) NSInteger level; 
- (void)setMessage:(NSString *)message score:(double)score;
- (void)starDisplay;

@end

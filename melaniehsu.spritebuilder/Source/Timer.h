//
//  Timer.h
//  melaniehsu
//
//  Created by Melanie Hsu on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Timer : NSObject {
    NSDate *start;
    NSDate *end;
}

- (void) startTimer;
- (void) stopTimer;
- (double) timeElapsedInSeconds;
- (double) timeElapsedInMilliseconds;
- (double) timeElapsedInMinutes;

@end

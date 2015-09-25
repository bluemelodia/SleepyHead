//
//  HighScore.m
//  melaniehsu
//
//  Created by Melanie Hsu on 8/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "HighScore.h"
#import "GameData.h"

@implementation HighScore {
    int totalScore;
    CCLabelTTF *first;
    CCLabelTTF *firstscore;
    CCLabelTTF *second;
    CCLabelTTF *secondscore;
    CCLabelTTF *third;
    CCLabelTTF *thirdscore;
    CCLabelTTF *fourth;
    CCLabelTTF *fourthscore;
    CCLabelTTF *fifth;
    CCLabelTTF *fifthscore;
    CCLabelTTF *sixth;
    CCLabelTTF *sixthscore;
    CCLabelTTF *seventh;
    CCLabelTTF *seventhscore;
    CCLabelTTF *eighth;
    CCLabelTTF *eighthscore;
    CCLabelTTF *ninth;
    CCLabelTTF *ninthscore;
    CCLabelTTF *tenth;
    CCLabelTTF *tenthscore;
    CCLabelTTF *_score;
    CCButton *friend;
    CCButton *invitation;
}

- (void) didLoadFromCCB {
    totalScore = 0;
    firstscore.string = [NSString stringWithFormat:@"%d", 0];
    secondscore.string = [NSString stringWithFormat:@"%d", 0];
    thirdscore.string = [NSString stringWithFormat:@"%d", 0];
    fourthscore.string = [NSString stringWithFormat:@"%d", 0];
    fifthscore.string = [NSString stringWithFormat:@"%d", 0];
    sixthscore.string = [NSString stringWithFormat:@"%d", 0];
    seventhscore.string = [NSString stringWithFormat:@"%d", 0];
    eighthscore.string = [NSString stringWithFormat:@"%d", 0];
    ninthscore.string = [NSString stringWithFormat:@"%d", 0];
    tenthscore.string = [NSString stringWithFormat:@"%d", 0];

    [self submitHighScore];
    //[self getHighScore];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    // attempt to extract a token from the url
    return [MGWU handleURL:url];
}

- (void) house {
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"press.wav"];
    CCScene *leave = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:leave];
}

- (void) submitHighScore {
    if (![GameData sharedInstance].named) {
        //UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hello!" message:@"Please enter your name:" delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:nil];
       UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Hello!" message:@"Please enter your name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        alert.delegate = self;
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField * alertTextField = [alert textFieldAtIndex:0];
        alertTextField.keyboardType = UIKeyboardTypeDefault;
        alertTextField.placeholder = @"Enter your name (up to 10 characters)";
        [alert show];
    }
    else {
        NSString *savedName = [[GameData sharedInstance]getName];
        NSLog(@"saved name: %@", savedName);
        [self updateScores];
    }
}

- (void)updateScores {
    NSString *savedName = [[GameData sharedInstance]getName];
    //NSLog(@"saved name: %@", savedName);
    
    for (int i = 1; i <= 8; i++) {
        totalScore += [[GameData sharedInstance] scoreFor: i];
    }
    
    NSInteger oldHigh = [[GameData sharedInstance] getHighScore];
    NSLog(@"OLD HIGH %d", oldHigh);
    if (totalScore > oldHigh) {
        _score.string = [NSString stringWithFormat:@"%d", totalScore];
        [[GameData sharedInstance]newHighScore:totalScore];
        NSLog(@"NEW SCORE!");
        [MGWU submitHighScore:totalScore byPlayer:savedName forLeaderboard:@"HallofFame" withCallback:@selector(receivedScores:) onTarget:self];
    }
    else {
        _score.string = [NSString stringWithFormat:@"%d", oldHigh];
        [MGWU submitHighScore:0 byPlayer:savedName forLeaderboard:@"HallofFame" withCallback:@selector(receivedScores:) onTarget:self];
    }
    // [MGWU submitHighScore:totalScore byPlayer:@"ashu" forLeaderboard:@"HallofFame"];
}

+(UIImage *)imageNamed:(NSString *)name cache:(BOOL)cache {
    if (cache)
        return [UIImage imageNamed:name];
    name = [[NSBundle mainBundle] pathForResource:[name stringByDeletingPathExtension] ofType:[name pathExtension]];
    UIImage *retVal = [[UIImage alloc] initWithContentsOfFile:name];
    return retVal;
}

- (void)challenge {
    int points = 0;
    for (int i = 1; i <= 8; i++) {
        points += [[GameData sharedInstance] scoreFor: i];
    }
    NSString *total = [NSString stringWithFormat:@"%d", points];
    NSString *message = [NSString stringWithFormat:@"I scored %@ points in Sleepy Head", total];
    //NSLog(@"tada");
    //NSLog(@"totalScore %d", points);
    
    if ([MGWU isFacebookActive]) {
        //[self (UIImage *)imageNamed:@"AppIcon50x50.png" cache:TRUE];
        //[MGWU postToFacebook:message withImage:image];
        //NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"AppIcon50x50.png" ofType:@"png"];
        //UIImage *myImage = [UIImage imageWithContentsOfFile:imagePath];
        //NSData *pngImageData = UIImagePNGRepresentation(myImage);
        //[MGWU postToFacebook:message withImage:pngImageData];
        //NSString *filename = @"AppIcon50x50.png";
        
        [MGWU shareWithTitle:message caption:@"" andDescription:@"Can you out-flick me?"];
    }
    else {
        [MGWU loginToFacebook];
    }
}

- (void) invite {
    if ([MGWU canInviteFriends]) {
        [MGWU inviteFriendsWithMessage:@"Flick your way to a good night's sleep in Sleepy Head: Survive to Sunrise!"];
    }
    else {
         [MGWU loginToFacebook];
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //addName:(NSString*)label
    NSString *name = [alertView textFieldAtIndex:0].text;
    
    if ([[alertView textFieldAtIndex:0].text length] <= 0 || buttonIndex == 0){
        return; //If cancel or 0 length string the string doesn't matter
    }
    
    NSMutableArray *data = [[GameData sharedInstance] getNames];
    //for (NSDictionary *listing in allScores)
    for (NSString *label in data) {
        //NSLog(@"NAME: %@", label);
        if ([name isEqualToString:label]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Oops, that name is taken!" message:@"Please enter a different name:" delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:nil];
            alert.delegate = self;
            alert.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField * alertTextField = [alert textFieldAtIndex:0];
            alertTextField.keyboardType = UIKeyboardTypeDefault;
            alertTextField.placeholder = @"Enter your name (up to 10 characters)";
            [alert show];
        }
    }
            //[name isEqualToString:first.string]
    
    //NSString *name = [alertView textFieldAtIndex:0].text;
    NSRange stringRange = {0, MIN([name length], 10)};
    stringRange = [name rangeOfComposedCharacterSequencesForRange:stringRange];
    
    NSString *shortString = [name substringWithRange:stringRange];
    //NSLog(@"%@", shortString);
    [[GameData sharedInstance] addName:shortString];
    [[GameData sharedInstance]saveName:shortString];

    //NSLog(@"%s", alertTextField.)
    for (int i = 1; i <= 8; i++) {
      totalScore += [[GameData sharedInstance] scoreFor: i];
    }
   // NSLog(@"total score %d", totalScore);
    //[MGWU submitHighScore:totalScore byPlayer:@"ashu" forLeaderboard:@"HallofFame"];
    [[GameData sharedInstance]doneSubmit];
    [MGWU submitHighScore:totalScore byPlayer:shortString forLeaderboard:@"HallofFame" withCallback:@selector(receivedScores:) onTarget:self];
    [[GameData sharedInstance]newHighScore:totalScore];
}

- (void)receivedScores:(NSDictionary*)scores
{
    //Do stuff with scores in here! Display them!
    NSArray *allScores = [scores objectForKey:@"all"];
    
    int count = 1;
//    for (scores in allScores) {
//        
//    }
    //NSLog(@"total score %d", totalScore);
    _score.string = [NSString stringWithFormat:@"%d", totalScore];
    //int firstnumber =  [firstscore.string intValue];
    //int secondnumber = [secondscore.string intValue];
    //int thirdnumber = [thirdscore.string intValue];
    //int fourthnumber = [fourthscore.string intValue];
    
    for (NSDictionary *listing in allScores) {
 
        int score = [[listing objectForKey:@"score"] intValue];
        NSString *name = [listing objectForKey:@"name"];
        //NSLog(@"%@: %i", name, score);
        
        if (count == 1 && score != 0) {
            first.string = name;
            firstscore.string = [NSString stringWithFormat:@"%d", score];
        }
        else if (count == 2 && score != 0 /*&& ![name isEqualToString:first.string]*/) {
            //int firstnumber =  [firstscore.string intValue];
            //int secondnumber = [secondscore.string intValue];
            //NSLog(@"numberone %d", firstnumber);
            //NSLog(@"numbertwo %d", secondnumber);
            //if (firstnumber > secondnumber) {
                second.string = name;
                secondscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else if (count == 3 && score != 0 /*&& ![name isEqualToString:first.string] && ![name isEqualToString:second.string]*/) {
            //int secondnumber =  [secondscore.string intValue];
            //int thirdnumber = [thirdscore.string intValue];
            //if (secondnumber > thirdnumber) {
                third.string = name;
                thirdscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else if (count == 4 && score != 0 /*&& ![name isEqualToString:first.string] && ![name isEqualToString:second.string] && ![name isEqualToString:third.string]*/) {
            //int thirdnumber = [thirdscore.string intValue];
            //int fourthnumber = [fourthscore.string intValue];
           // if (thirdnumber > fourthnumber) {
                fourth.string = name;
                fourthscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else if (count == 5 && score != 0 /*&& ![name isEqualToString:first.string] && ![name isEqualToString:second.string] && ![name isEqualToString:third.string] && ![name isEqualToString:fourth.string]*/) {
            //int fourthnumber = [fourthscore.string intValue];
            //int fifthnumber = [fifthscore.string intValue];
            //if (fourthnumber > fifthnumber) {
                fifth.string = name;
                fifthscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else if (count == 6 && score != 0 /*&& ![name isEqualToString:first.string] && ![name isEqualToString:second.string] && ![name isEqualToString:third.string] && ![name isEqualToString:fourth.string] && ![name isEqualToString:fifth.string]*/) {
            //int fifthnumber = [fifthscore.string intValue];
            //int sixthnumber = [sixthscore.string intValue];
            //if (fifthnumber > sixthnumber) {
                sixth.string = name;
                sixthscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else if (count == 7 && score != 0 /*&& ![name isEqualToString:first.string] && ![name isEqualToString:second.string] && ![name isEqualToString:third.string] && ![name isEqualToString:fourth.string] && ![name isEqualToString:fifth.string] && ![name isEqualToString:sixth.string]*/) {
           // int sixthnumber = [sixthscore.string intValue];
           // int seventhnumber = [seventhscore.string intValue];
           // if (sixthnumber > seventhnumber) {
                seventh.string = name;
                seventhscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else if (count == 8 && score != 0 /*&& ![name isEqualToString:first.string] && ![name isEqualToString:second.string] && ![name isEqualToString:third.string] && ![name isEqualToString:fourth.string] && ![name isEqualToString:fifth.string] && ![name isEqualToString:sixth.string] && ![name isEqualToString:seventh.string]*/) {
            //int seventhnumber = [seventhscore.string intValue];
            //int eighthnumber = [eighthscore.string intValue];
            //if (seventhnumber > eighthnumber) {
                eighth.string = name;
                eighthscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else if (count == 9 && score != 0 /*&& ![name isEqualToString:first.string] && ![name isEqualToString:second.string] && ![name isEqualToString:third.string] && ![name isEqualToString:fourth.string] && ![name isEqualToString:fifth.string] && ![name isEqualToString:sixth.string] && ![name isEqualToString:seventh.string] && ![name isEqualToString:eighth.string]*/) {
            //int eighthnumber = [eighthscore.string intValue];
            //int ninthnumber = [ninthscore.string intValue];
            //if (eighthnumber > ninthnumber) {
                ninth.string = name;
                ninthscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else if (count == 10 && score != 0 /*&& ![name isEqualToString:first.string] && ![name isEqualToString:second.string] && ![name isEqualToString:third.string] && ![name isEqualToString:fourth.string] && ![name isEqualToString:fifth.string] && ![name isEqualToString:sixth.string] && ![name isEqualToString:seventh.string] && ![name isEqualToString:eighth.string] && ![name isEqualToString:ninth.string])*/) {
            //int ninthnumber = [ninthscore.string intValue];
            //int tenthnumber = [tenthscore.string intValue];
            //if (ninthnumber > tenthnumber) {
                tenth.string = name;
                tenthscore.string = [NSString stringWithFormat:@"%d", score];
            //}
        }
        else {
            //do nothing
        }
        count++;
    }
}



@end

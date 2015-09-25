//
//  Select.h
//  melaniehsu
//
//  Created by Melanie Hsu on 7/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Gameplay.h"

@interface Select : CCScene
/*
@property (nonatomic, strong) CCButton *levelonebutton;
@property (nonatomic, strong) CCButton *leveltwobutton;
@property (nonatomic, strong) CCButton *levelthreebutton;
@property (nonatomic, strong) CCButton *levelfourbutton;
@property (nonatomic, strong) CCButton *levelfivebutton;*/
- (void)enable:(NSInteger)level;

@end

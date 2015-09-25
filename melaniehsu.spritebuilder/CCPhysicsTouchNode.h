#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class ChipmunkMultiGrab;
@class Gameplay;
@interface CCPhysicsTouchNode : CCNode {
    
}

@property (nonatomic,strong) ChipmunkMultiGrab *grab;
@property (nonatomic,weak) Gameplay *game; 
@end

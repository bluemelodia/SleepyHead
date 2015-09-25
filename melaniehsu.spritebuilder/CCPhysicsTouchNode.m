#import "CCPhysicsTouchNode.h"
#import "CCPhysics+ObjectiveChipmunk.h"
#import "touch.h"
#import "Gameplay.h"


@implementation CCPhysicsTouchNode {
	CCSprite *_spot;
    CCParticleSystem *explosion;
}

-(id)init
{
	if((self = [super init])){
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = YES;
	}
	
	return self;
}

-(void)onEnter
{
	CCPhysicsNode *physics = self.physicsNode;
	NSAssert(physics, @"Must be added to a physics node.");
	
	self.grab = [[ChipmunkMultiGrab alloc] initForSpace:physics.space withSmoothing:powf(0.8f, 60.0f) withGrabForce:1e7]; //alter the grab force to make flicking weaker
	self.grab.grabRadius = 20.f;
    
	[super onEnter];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
//    if (touch.locationInWorld.y < 220) {
//        return;
//    }
    
    if (!self.game.started) {
        [self.game readySetGo];
    }
    
	[self.grab beginLocation:[touch locationInNode:self]];
    
    /*_spot = [CCSprite spriteWithImageNamed:@"cursor.png"];
    [self addChild:_spot];
    _spot.position = [touch locationInNode:self];
    _spot.zOrder = 10;*/
    
    explosion = (CCParticleSystem *)[CCBReader load:@"ShootingStar"];
    explosion.autoRemoveOnFinish = TRUE;
    [self addChild:explosion];
    explosion.position = [touch locationInNode:self];

    
    if (self.game.streakNumber < 10) {
        explosion.startColor = [CCColor blueColor];
        explosion.endColor = [CCColor blueColor];
        
    }
    else if (10 <= self.game.streakNumber && self.game.streakNumber < 25) {
        explosion.startColor = [CCColor greenColor];
        explosion.endColor = [CCColor greenColor];
    }
    else if (25 <= self.game.streakNumber && self.game.streakNumber < 50) {
        
        explosion.startColor = [CCColor yellowColor];
        explosion.endColor = [CCColor yellowColor];
        
    }
    else if (50 <= self.game.streakNumber && self.game.streakNumber < 100) {
        explosion.startColor = [CCColor orangeColor];
        explosion.endColor = [CCColor orangeColor];
        
    }
    else {
        explosion.startColor = [CCColor redColor];
        explosion.endColor = [CCColor redColor];
        
    }

    //TODO: let user see where they tap
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
//    if (touch.locationInWorld.y < 220 || self.grab.grabs.count == 0) {
//        if (self.grab.grabs.count != 0) {
//            [[CCDirector sharedDirector] touchesEnded:[NSSet setWithObjects:touch, nil] withEvent:event];
//            [self touchEnded:touch withEvent:event];
//        }
//        return;
//    }
    
	[self.grab updateLocation:[touch locationInNode:self]];
    //explosion.position = [touch locationInNode:self];
    

    explosion = (CCParticleSystem *)[CCBReader load:@"ShootingStar"];
    explosion.autoRemoveOnFinish = TRUE;
    [self addChild:explosion];
    explosion.position = [touch locationInNode:self];
    //_spot.position = [touch locationInNode:self];
    //_spot.zOrder = 10;
    
    if (self.game.streakNumber < 10) {
        explosion.startColor = [CCColor blueColor];
        explosion.endColor = [CCColor blueColor];
        
    }
    else if (10 <= self.game.streakNumber && self.game.streakNumber < 25) {
        explosion.startColor = [CCColor greenColor];
        explosion.endColor = [CCColor greenColor];
    }
    else if (25 <= self.game.streakNumber && self.game.streakNumber < 50) {
        
        explosion.startColor = [CCColor yellowColor];
        explosion.endColor = [CCColor yellowColor];

    }
    else if (50 <= self.game.streakNumber && self.game.streakNumber < 100) {
        explosion.startColor = [CCColor orangeColor];
        explosion.endColor = [CCColor orangeColor];

    }
    else {
        explosion.startColor = [CCColor redColor];
        explosion.endColor = [CCColor redColor];

    }
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
//    if (touch.locationInWorld.y < 220 || self.grab.grabs.count == 0) {
//        return;
//    }
    [self.grab endLocation:[touch locationInNode:self]];
    
    OALSimpleAudio *scream = [OALSimpleAudio sharedInstance];
    [scream playEffect:@"flick.wav"];
    
    //[self removeChild:_spot];
    //[self removeChild:explosion];
}


-(void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
	[self touchEnded:touch withEvent:event];
}

@end

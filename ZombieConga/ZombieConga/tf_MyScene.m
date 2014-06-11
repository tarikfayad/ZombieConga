//
//  tf_MyScene.m
//  ZombieConga
//
//  Created by Tarik Fayad on 6/10/14.
//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import "tf_MyScene.h"

static inline CGPoint CGPointAdd(const CGPoint a,
                                 const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointSubtract(const CGPoint a,
                                      const CGPoint b)
{
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a,
                                            const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}

static inline CGFloat CGPointLength(const CGPoint a)
{
    return sqrtf(a.x * a.x + a.y * a.y);
}

static inline CGPoint CGPointNormalize(const CGPoint a)
{
    CGFloat length = CGPointLength(a);
    return CGPointMake(a.x / length, a.y / length);
}

static inline CGFloat CGPointToAngle(const CGPoint a)
{
    return atan2f(a.y, a.x);
}

static const float ZOMBIE_MOVE_POINTS_PER_SEC = 120.0; //The zombie should move 120 points (about 1/5th of the screen) every second

@implementation tf_MyScene
{
    SKSpriteNode *_zombie;
    
    CGPoint _velocity;
    CGPoint _lastTouchLocation;
    
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
}

-(void) update:(NSTimeInterval)currentTime
{
    //Logging the time it takes for the update function to run.
    if (_lastUpdateTime) {
        _dt = currentTime - _lastUpdateTime;
    } else {
        _dt = 0;
    }
    _lastUpdateTime = currentTime;
    NSLog(@"%0.2f milliseconds since last update", _dt * 1000);
    
    CGPoint offsetBetweenZombieAndTouch = CGPointSubtract(_zombie.position, _lastTouchLocation);
    if (CGPointLength(offsetBetweenZombieAndTouch) <= (ZOMBIE_MOVE_POINTS_PER_SEC * _dt)) {
        _zombie.position = _lastTouchLocation;
        _velocity = CGPointZero;
    } else {
        [self moveSprite:_zombie velocity:_velocity];
        
        //Calling the Bounds Functionwhy a tar and not a zip
        [self boundsCheckPlayer];
        [self rotateSprite:_zombie toFace:_velocity];
    }
    
}

//Velocity multiplied by delta time (dt)
-(void) moveSprite: (SKSpriteNode *) sprite velocity: (CGPoint) velocity
{
    //Since velocity is in points per second, you need to figure out how much to move the zombie in each frame, which is done by multiplying by the fraction of seconds since last update
    CGPoint amountToMove = CGPointMultiplyScalar(velocity, _dt);
    NSLog(@"Amount to move: %@", NSStringFromCGPoint(amountToMove));
    
    //To determine the new position for the zombie, just add the vector to the point
    sprite.position = CGPointAdd (sprite.position, amountToMove);

}

//Make the zombie move the direction of a tap.
- (void)moveZombieToward:(CGPoint)location
{
    //Calculating the offset vector between the touch location and the zombie's location
    CGPoint offset = CGPointSubtract (location, _zombie.position);
    
    //Normalizing the offset vector length to ensure steady movment
    CGPoint direction = CGPointNormalize(offset);
    
    _velocity = CGPointMultiplyScalar(direction, ZOMBIE_MOVE_POINTS_PER_SEC);
    
}

-(id) initWithSize:(CGSize)size {

    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor whiteColor]; //Setting the inital background color to white.
        
        //Adding a background image to the scene.
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        bg.position = CGPointMake(self.size.width/2, self.size.height/2); //Moving the background away from the origin (0,0) or the bottom left of the screen and to the center
        [self addChild:bg];
        
        //Adding the zombie to the scene
        _zombie = [SKSpriteNode spriteNodeWithImageNamed:@"zombie1"];
        _zombie.position = CGPointMake(100, 100);
        //[_zombie setScale:2];
        [self addChild:_zombie];
        
        //Getting the size of the background sprite
        CGSize mySize = bg.size;
        NSLog(@"Size: %@", NSStringFromCGSize(mySize));
        
    }
    
    return self;
}

//Logging touch events in three methods
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _lastTouchLocation = [touch locationInNode:self];
    [self moveZombieToward:_lastTouchLocation];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _lastTouchLocation = [touch locationInNode:self];
    [self moveZombieToward:_lastTouchLocation];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    _lastTouchLocation = [touch locationInNode:self];
    [self moveZombieToward:_lastTouchLocation];
}

- (void) boundsCheckPlayer
{
    //Storing the position and velocity
    CGPoint newPosition = _zombie.position;
    CGPoint newVelocity = _velocity;
    
    //Getting the bottom left and top right coordinates
    CGPoint bottomLeft = CGPointZero;
    CGPoint topRight = CGPointMake(self.size.width, self.size.height);
    
    //Establishing the boundaries
    if (newPosition.x <= bottomLeft.x) {
        newPosition.x = bottomLeft.x;
        newVelocity.x = -newVelocity.x;
    }
    if (newPosition.x >= topRight.x) {
        newPosition.x = topRight.x;
        newVelocity.x = -newVelocity.x;
    }
    if (newPosition.y <= bottomLeft.y) {
        newPosition.y = bottomLeft.y;
        newVelocity.y = -newVelocity.y;
    }
    if (newPosition.y >= topRight.y) {
        newPosition.y = topRight.y;
        newVelocity.y = -newVelocity.y;
    }
    
    //Setting the zombie to the new position
    _zombie.position = newPosition;
    _velocity = newVelocity;
}

//Rotate the zombie to face in the direction pointed
- (void) rotateSprite:(SKSpriteNode *)sprite toFace:(CGPoint)direction
{
    sprite.zRotation = CGPointToAngle(direction);
}

@end

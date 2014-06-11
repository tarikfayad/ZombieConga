//
//  tf_MyScene.m
//  ZombieConga
//
//  Created by Tarik Fayad on 6/10/14.
//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import "tf_MyScene.h"

static const float ZOMBIE_MOVE_POINTS_PER_SEC = 120.0; //The zombie should move 120 points (about 1/5th of the screen) every second

@implementation tf_MyScene
{
    SKSpriteNode *_zombie;
    
    CGPoint _velocity;
    
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
    
    //Calling movement methods
    //_zombie.position = CGPointMake(_zombie.position.x + 2, _zombie.position.y); //Constant fixed movment per frame
    [self moveSprite:_zombie veloocity:CGPointMake(ZOMBIE_MOVE_POINTS_PER_SEC, 0)]; //Velocity multiplied by delta time (dt)
}

//Velocity multiplied by delta time (dt)
-(void) moveSprite: (SKSpriteNode *) sprite veloocity: (CGPoint) velocity
{
    //Since velocity is in points per second, you need to figure out how much to move the zombie in each frame, which is done by multiplying by the fraction of seconds since last update
    CGPoint amountToMove = CGPointMake(velocity.x * _dt, velocity.y * _dt);
    NSLog(@"Amount to move: %@", NSStringFromCGPoint(amountToMove));
    
    //To determine the new position for the zombie, just add the vector to the point
    sprite.position = CGPointMake(sprite.position.x + amountToMove.x, sprite.position.y + amountToMove.y);
}

//Make the zombie move the direction of a tap.
- (void)moveZombieToward:(CGPoint)location
{
    //Calculating the offset vector between the touch location and the zombie's location
    CGPoint offset = CGPointMake(location.x - _zombie.position.y, location.y - _zombie.position.y);
    
    //Calculating the offset vector length
    CGFloat length = sqrtf(offset.x * offset.x + offset.y * offset.y);
    
    //Normalizing the offset vector length to ensure steady movment
    CGPoint direction = CGPointMake(offset.x / length, offset.y / length);
    
    _velocity = CGPointMake(direction.x * ZOMBIE_MOVE_POINTS_PER_SEC, direction.y * ZOMBIE_MOVE_POINTS_PER_SEC);
    
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

@end

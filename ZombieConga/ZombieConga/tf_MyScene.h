//
//  tf_MyScene.h
//  ZombieConga
//

//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface tf_MyScene : SKScene

- (void) moveSprite: (SKSpriteNode *) sprite velocity: (CGPoint) velocity;
- (void) moveZombieToward: (CGPoint) location;
- (void) boundsCheckPlayer;
- (void) rotateSprite: (SKSpriteNode *) sprite toFace:(CGPoint) direction;

static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b);
static inline CGPoint CGPointSubtract(const CGPoint a, const CGPoint b);
static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b);
static inline CGFloat CGPointLength(const CGPoint a);
static inline CGPoint CGPointNormalize(const CGPoint a);
static inline CGFloat CGPointToAngle(const CGPoint a);

@end

//
//  tf_MyScene.h
//  ZombieConga
//

//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface tf_MyScene : SKScene

- (void) moveSprite: (SKSpriteNode *) sprite veloocity: (CGPoint) velocity;
- (void) moveZombieToward: (CGPoint) location;
- (void) boundsCheckPlayer;

@end

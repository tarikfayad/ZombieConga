//
//  tf_MyScene.m
//  ZombieConga
//
//  Created by Tarik Fayad on 6/10/14.
//  Copyright (c) 2014 Tarik Fayad. All rights reserved.
//

#import "tf_MyScene.h"

@implementation tf_MyScene
{
    SKSpriteNode *_zombie;
}

-(void) update:(NSTimeInterval)currentTime
{
    _zombie.position = CGPointMake(_zombie.position.x + 2, _zombie.position.y); //Constant movment in the X direction as the update funciton refreshes
}

-(id)initWithSize:(CGSize)size {    

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

//
//  GameSession.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "GameSession.h"
#import "Game.h"

@interface GameSession ()

@property Game *game;

@end

@implementation GameSession

- (instancetype)initWithGame:(Game *)game
{
    self = [super init];
    if (self) {
        self.game = game;
        self.game.gameSession = self;
        self.lastWinner = (id <PlayerProtocol> )self.game.playerHuman;
    }
    return self;
}

- (void)newGame
{
    [self.game start];
}

- (void)quit
{
    
}

@end

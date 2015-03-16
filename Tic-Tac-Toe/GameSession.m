//
//  GameSession.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "GameSession.h"
#import "Game.h"

@interface GameSession () <GameDelegate>

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
    if (self.lastWinner == nil) {
        self.lastWinner = (id <PlayerProtocol> )self.game.playerHuman;
    }
    [self.game start];
}

- (void)quit
{
    
}

#pragma mark GameDelegate

-(void)game:(Game *)game didEndWithStatus:(GameStatus)status winner:(id<PlayerProtocol>)player
{
    self.lastWinner = player;
    if ([self.delegate respondsToSelector:@selector(game:didEndWithStatus:winner:)]) {
        [self.delegate game:game didEndWithStatus:status winner:player];
    }
}

@end

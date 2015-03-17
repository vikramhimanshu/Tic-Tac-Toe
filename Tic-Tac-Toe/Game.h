//
//  Game.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@class Board;
@class HumanPlayer;
@class ComputerPlayer;
@class GameSession;

typedef enum : NSUInteger {
    GameDraw,
    GameWin
} GameStatus;

@protocol GameDelegate <NSObject>

- (void)game:(Game *)game didEndWithStatus:(GameStatus)status winner:(id<PlayerProtocol>)player;

@end

@interface Game : NSObject

@property (nonatomic, weak) GameSession <GameDelegate> *gameSession;

@property (nonatomic, readonly) ComputerPlayer *playerComputer;
@property (nonatomic, readonly) HumanPlayer *playerHuman;
@property (nonatomic, readonly) id <PlayerProtocol> currentPlayer;

- (instancetype)initWithComputerPlayer:(ComputerPlayer *)computer andHuman:(HumanPlayer *)human;
- (instancetype)initWithPlayer:(HumanPlayer *)player1 secondPlayer:(HumanPlayer *)player2;

- (void)setBoard:(Board *)board;

- (void)start;
- (void)end;

@end

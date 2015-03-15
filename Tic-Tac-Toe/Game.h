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

@interface Game : NSObject

@property (nonatomic, weak) GameSession *gameSession;

@property (nonatomic, readonly) ComputerPlayer *playerComputer;
@property (nonatomic, readonly) HumanPlayer *playerHuman;
@property (nonatomic, readonly) id <PlayerProtocol> currentPlayer;

- (instancetype)initWithComputerPlayer:(ComputerPlayer *)computer andHuman:(HumanPlayer *)human;

- (void)setBoard:(Board *)board;

- (void)start;
- (void)end;

@end

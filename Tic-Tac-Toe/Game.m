//
//  Game.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "Game.h"
#import "Board.h"
#import "ComputerPlayer.h"
#import "HumanPlayer.h"
#import "GameSession.h"

@interface Game () <BoardProtocol, PlayerDelegate>

@property Board *gameBoard;

@property (nonatomic, readwrite) ComputerPlayer *playerComputer;
@property (nonatomic, readwrite) HumanPlayer *playerHuman;
@property (nonatomic, readwrite) id <PlayerProtocol> currentPlayer;

@property SymbolCell *lastMove;

@end

@implementation Game

-(instancetype)initWithComputerPlayer:(ComputerPlayer <PlayerProtocol>*)computer andHuman:(HumanPlayer *)human
{
    self = [super init];
    if (self) {
        self.playerComputer = computer;
        self.playerComputer.delegate = self;
        self.playerHuman = human;
        self.playerHuman.delegate = self;
    }
    return self;
}

-(void)setBoard:(Board *)board
{
    self.gameBoard = board;
    self.gameBoard.delegate = self;
}

- (void)start
{
    [self.gameBoard display];
    self.currentPlayer = [self.gameSession lastWinner];
}

-(void)end
{
    
}

-(Player *)checkWinStatus
{
    return nil;
}

- (void)evaluateGameState
{
    
}

- (void)swapPlayers
{
    if (self.currentPlayer == self.playerHuman) {
        self.currentPlayer = self.playerComputer;
    } else {
        self.currentPlayer = self.playerHuman;
    }
}

- (void)currentPlayerTakesTurn
{
    if ([self.currentPlayer conformsToProtocol:@protocol(PlayerProtocol)]) {
        if ([self.currentPlayer respondsToSelector:@selector(takeTurn)]) {
            [self.currentPlayer takeTurn];
        }
    }
}

-(void)boardWillChangeWithMove:(SymbolCell *)move
{
    self.lastMove = move;
    [self.playerHuman takeTurn];
}

-(void)boardDidChangeWithMove:(SymbolCell *)move
{
    [self evaluateGameState];
    [self swapPlayers];
    
    if ([self.currentPlayer isEqual:self.playerComputer]) {
        [self.playerComputer takeTurn];
    }
}

#pragma mark PlayerDelegate

-(void)player:(id<PlayerProtocol>)player willMakeMove:(SymbolCell *)move
{
    [self.gameBoard markCell:move withSymbol:player.symbol];
}

-(SymbolCell *)lastMoveInGame
{
    return self.lastMove;
}

@end

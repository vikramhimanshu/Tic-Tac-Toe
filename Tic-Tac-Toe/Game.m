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

@interface Game () <BoardDelegate, PlayerDelegate>

@property Board *gameBoard;

@property (nonatomic, readwrite) ComputerPlayer *playerComputer;
@property (nonatomic, readwrite) HumanPlayer *playerHuman;
@property (nonatomic, readwrite) id <PlayerProtocol> currentPlayer;

@property (nonatomic) BOOL shouldContinueGame;

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
    [self.playerComputer cleanup];
    [self.gameBoard display];
    self.currentPlayer = [self.gameSession lastWinner];
    self.shouldContinueGame = YES;
    if ([self.currentPlayer isEqual:self.playerComputer]) {
        [self.playerComputer performSelector:@selector(takeTurn)
                                  withObject:nil
                                  afterDelay:0.5];
    }
}

-(void)end
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

#pragma mark BoardDelegate

-(void)boardWillChangeWithMove:(SymbolCell *)move
{
    self.lastMove = move;
    if ([self.currentPlayer isEqual:self.playerHuman] && self.shouldContinueGame) {
        [self.playerHuman takeTurn];
    }
}

-(void)boardDidChangeWithMove:(SymbolCell *)move
{
    [self swapPlayers];
    
    if ([self.currentPlayer isEqual:self.playerComputer] && self.shouldContinueGame) {
        [self.playerComputer performSelector:@selector(takeTurn)
                                  withObject:nil
                                  afterDelay:0.5];
    }
}

-(void)boardDidDetectWinInRow:(NSString *)winningRow forSymbol:(Symbol)symbol
{
    self.shouldContinueGame = NO;
    if ([self.gameSession respondsToSelector:@selector(game:didEndWithStatus:winner:)]) {
        if (self.playerComputer.symbol == symbol) {
            [self.gameSession game:self didEndWithStatus:GameWin winner:self.playerComputer];
        } else {
            [self.gameSession game:self didEndWithStatus:GameWin winner:self.playerHuman];
        }
    }
}

-(void)boardDidDetectDraw
{
    self.shouldContinueGame = NO;
    if ([self.gameSession respondsToSelector:@selector(game:didEndWithStatus:winner:)]) {
        [self.gameSession game:self didEndWithStatus:GameDraw winner:nil];
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

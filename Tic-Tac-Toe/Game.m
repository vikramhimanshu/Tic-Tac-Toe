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
@property (nonatomic, readwrite) HumanPlayer *playerHuman2;

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

- (instancetype)initWithPlayer:(HumanPlayer *)player1 secondPlayer:(HumanPlayer *)player2
{
    self = [super init];
    if (self) {
        self.playerHuman = player1;
        self.playerHuman.delegate = self;
        self.playerHuman2 = player2;
        self.playerHuman2.delegate = self;
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
    self.shouldContinueGame = YES;
    
    self.currentPlayer = [self.gameSession lastWinner];
    [self.currentPlayer takeTurn];
}

-(void)end
{
    
}

- (BOOL)isSinglePlayerGame
{
    return [self.playerComputer isKindOfClass:[ComputerPlayer class]];
}

- (void)swapPlayers
{
    if ([self isSinglePlayerGame]) {
        self.currentPlayer = (self.currentPlayer == self.playerHuman)?
                                                    self.playerComputer : self.playerHuman;
    } else {
        self.currentPlayer = (self.currentPlayer == self.playerHuman)?
                                                    self.playerHuman2 : self.playerHuman;
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
    
    if ([self.currentPlayer isKindOfClass:[ComputerPlayer class]] && self.shouldContinueGame) {
        [self.playerComputer takeTurn];
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
    if (move) {
        [self.gameBoard markCell:move withSymbol:player.symbol];
    }
}

-(SymbolCell *)lastMoveInGame
{
    return self.lastMove;
}

@end

//
//  ComputerPlayer.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "ComputerPlayer.h"
#import "TicTacToeStrategy.h"

@interface ComputerPlayer ()

@property TicTacToeStrategy *strategy;

@property id <PlayerDelegate> myDelegate;
@property Symbol mySymbol;

@end

@implementation ComputerPlayer

- (instancetype)initWithStrategy:(TicTacToeStrategy *)strategy
{
    self = [super init];
    if (self) {
        self.strategy = strategy;
    }
    return self;
}

-(void)cleanup
{
    [self.strategy cleanup];
}

-(void)takeTurn
{
    SymbolCell *lastMove = nil;
    if ([self.delegate respondsToSelector:@selector(lastMoveInGame)]) {
        lastMove = [self.delegate lastMoveInGame];
    }
    
    SymbolCell *nextMove = [self.strategy nextMoveForCurrentOpponentMove:lastMove];
    if ([self.delegate respondsToSelector:@selector(player:willMakeMove:)]) {
        [self.delegate player:self willMakeMove:nextMove];
    }
}

-(void)setSymbol:(Symbol)symbol
{
    self.mySymbol = symbol;
}

-(Symbol)symbol
{
    return self.mySymbol;
}

-(void)setDelegate:(id<PlayerDelegate>)delegate
{
    self.myDelegate = delegate;
}

-(id<PlayerDelegate>)delegate
{
    return self.myDelegate;
}

@end

//
//  HumanPlayer.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/15/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "HumanPlayer.h"

@interface HumanPlayer ()

@property id <PlayerDelegate> myDelegate;
@property Symbol mySymbol;

@end

@implementation HumanPlayer

-(void)takeTurn
{
    SymbolCell *lastMove = nil;
    if ([self.delegate respondsToSelector:@selector(lastMoveInGame)]) {
        lastMove = [self.delegate lastMoveInGame];
    }
    
    if ([self.delegate respondsToSelector:@selector(player:willMakeMove:)]) {
        [self.delegate player:self willMakeMove:lastMove];
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

//
//  Board+BoardDelegate.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/17/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "Board+BoardDelegate.h"

@implementation Board (BoardDelegate)

- (void)boardWillChangeWithMove:(SymbolCell *)move
{
    if ([self.delegate respondsToSelector:@selector(boardWillChangeWithMove:)]) {
        [self.delegate boardWillChangeWithMove:move];
    }
}
- (void)boardDidChangeWithMove:(SymbolCell *)move
{
    if ([self.delegate respondsToSelector:@selector(boardDidChangeWithMove:)]) {
        [self.delegate boardDidChangeWithMove:move];
    }
}
- (void)boardDidDetectForkInRows:(NSArray *)winningRows forSymbol:(Symbol)symbol
{
    if ([self.delegate respondsToSelector:@selector(boardDidDetectForkInRows:forSymbol:)]) {
        [self.delegate boardDidDetectForkInRows:winningRows forSymbol:symbol];
    }
}
- (void)boardDidDetectBlockInRows:(NSArray *)winningRows forSymbol:(Symbol)symbol
{
    if ([self.delegate respondsToSelector:@selector(boardDidDetectBlockInRows:forSymbol:)]) {
        [self.delegate boardDidDetectBlockInRows:winningRows forSymbol:symbol];
    }
}
- (void)boardDidDetectWinInRow:(NSString *)winningRow forSymbol:(Symbol)symbol
{
    if ([self.delegate respondsToSelector:@selector(boardDidDetectWinInRow:forSymbol:)]) {
        [self.delegate boardDidDetectWinInRow:winningRow forSymbol:symbol];
    }
}
- (void)boardDidDetectDraw
{
    if ([self.delegate respondsToSelector:@selector(boardDidDetectDraw)]) {
        [self.delegate boardDidDetectDraw];
    }
}
- (void)boardDidCompleteCheckWithAvailableMoves:(NSArray *)availableMoves
{
    if ([self.delegate respondsToSelector:@selector(boardDidCompleteCheckWithAvailableMoves:)]) {
        [self.delegate boardDidCompleteCheckWithAvailableMoves:availableMoves];
    }
}

@end

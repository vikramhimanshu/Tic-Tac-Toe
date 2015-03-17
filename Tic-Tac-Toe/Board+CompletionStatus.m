//
//  Board+CompletionStatus.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/17/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "Board+CompletionStatus.h"
#import "Board+Grid.h"
#import "Board+BoardDelegate.h"
#import "SymbolCell.h"

@implementation Board (CompletionStatus)

@dynamic rowsToCheck;

- (void)evaluateBoardForStatus
{
    NSMutableArray *winningRowsX = [NSMutableArray array];
    NSMutableArray *winningRowsO = [NSMutableArray array];
    NSMutableArray *availableMoves = [NSMutableArray array];
    NSMutableArray *completedRows = [NSMutableArray array];
    
    for (NSString *row in self.rowsToCheck)
    {
        NSArray *cells = [self cellsForRow:row];
        int markedCountX = 0;
        int markedCountO = 0;
        int availableCount = 0;
        for (SymbolCell *cell in cells)
        {
            if (cell.currentSymbol == SymbolO) {
                markedCountO++;
            } else if (cell.currentSymbol == SymbolX) {
                markedCountX++;
            } else {
                availableCount++;
                [availableMoves addObject:cell];
            }
        }
        if (availableCount) {
            if (markedCountX>1) {
                [winningRowsX addObject:row];
            } else if (markedCountO>1) {
                [winningRowsO addObject:row];
            }
        } else {
            [completedRows addObject:row];
            if (markedCountO == 3) {
                [self boardDidDetectWinInRow:row forSymbol:SymbolO];
                return;
            } else if (markedCountX == 3) {
                [self boardDidDetectWinInRow:row forSymbol:SymbolX];
                return;
            }
        }
    }
    
    [self.rowsToCheck removeObjectsInArray:completedRows];
    
    if ([availableMoves count] == 0) {
        [self boardDidDetectDraw];
    }
    
    NSInteger winningRowsCountX = [winningRowsO count];
    NSInteger winningRowsCountO = [winningRowsX count];
    if (winningRowsCountO>0) {
        [self boardDidDetectBlockInRows:winningRowsO forSymbol:SymbolO];
        if (winningRowsCountO>1) {
            [self boardDidDetectForkInRows:winningRowsO forSymbol:SymbolO];
        }
    } else if (winningRowsCountX>0) {
        [self boardDidDetectBlockInRows:winningRowsX forSymbol:SymbolX];
        if (winningRowsCountX>1) {
            [self boardDidDetectForkInRows:winningRowsX forSymbol:SymbolX];
        }
    }
    [self boardDidCompleteCheckWithAvailableMoves:availableMoves];
}

@end

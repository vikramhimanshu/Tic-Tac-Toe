//
//  TicTacToeStrategy.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "TicTacToeStrategy.h"
#import "SymbolCell.h"
#import "Board.h"

@interface TicTacToeStrategy ()

@property (nonatomic, strong) Board *board;
@property Symbol opponenetSymbol;
@property Symbol mySymbol;
@property (nonatomic)  NSMutableArray *rowsToCheck;

@end

@implementation TicTacToeStrategy

-(NSMutableArray *)rowsToCheck
{
    if (_rowsToCheck == nil) {
        _rowsToCheck = [@[KeyRowTop,KeyRowMiddle,KeyRowBottom,
                          KeyRowLeft,KeyRowRight,KeyRowCenter,
                          KeyRowDiagonal1,KeyRowDiagonal2] mutableCopy];
    }
    return _rowsToCheck;
}

- (void)cleanup
{
    [self.rowsToCheck removeAllObjects];
    self.rowsToCheck = nil;
}

- (instancetype)initWithBoard:(Board *)board;
{
    self = [super init];
    if (self) {
        self.board = board;
    }
    return self;
}

- (void)setPlayerSymbols:(Symbol)opponenet mySymbol:(Symbol)my
{
    self.opponenetSymbol = opponenet;
    self.mySymbol = my;
}

- (SymbolCell *)nextMoveForCurrentOpponentMove:(SymbolCell *)cell
{
    if (cell == nil) { //Computer is playing first
        return [self.board center]; //open with center
    }
    SymbolCell *nextMove = [self evaluateBoardForStatusWithOpponentMove:cell];
    return nextMove;
}

#warning refactor this to share it with board
- (SymbolCell *)evaluateBoardForStatusWithOpponentMove:(SymbolCell *)cell
{
    NSMutableArray *winningRowsAI = [NSMutableArray array];
    NSMutableArray *winningRowsOpponent = [NSMutableArray array];
    NSMutableArray *availableMoves = [NSMutableArray array];
    NSMutableArray *completedRows = [NSMutableArray array];
    
    for (NSString *row in self.rowsToCheck)
    {
        NSArray *cells = [self.board cellsForRow:row];
        int markedCountAI = 0;
        int markedCountOpponent = 0;
        int availableCount = 0;
        for (SymbolCell *cell in cells)
        {
            if (cell.currentSymbol == self.opponenetSymbol) {
                markedCountOpponent++;
            } else if (cell.currentSymbol == self.mySymbol) {
                markedCountAI++;
            } else {
                availableCount++;
                [availableMoves addObject:cell];
            }
        }
        if (availableCount) {
            if (markedCountAI>1) {
                [winningRowsAI addObject:row];
            } else if (markedCountOpponent>1) {
                [winningRowsOpponent addObject:row];
            }
        } else {
            NSLog(@"\n%@ is full, removing it from the check\n",row);
            [completedRows addObject:row];
            if (markedCountOpponent == 3) {
                NSLog(@"\n###Opponent Wins\n");
                [self cleanup];
                return nil;
            } else if (markedCountAI == 3) {
                NSLog(@"\n###AI Wins\n");
                [self cleanup];
                return nil;
            }
        }
    }
    
    if ([availableMoves count] == 0) {
        NSLog(@"\n###Game Draw\n");
        [self cleanup];
        return nil;
    } else if ([availableMoves count] == 1) {
        return [self playFromAvailableMoves:availableMoves];
    }

    [self.rowsToCheck removeObjectsInArray:completedRows];
    
    int winningRowsCountOpp = [winningRowsOpponent count];
    int winningRowsCountAI = [winningRowsAI count];
    if (winningRowsCountAI>0) {
        if (winningRowsCountAI>1) {
            NSLog(@"\n**AI managed to create a fork. Opponent Looses.\n");
        }
        NSLog(@"\n**Play The Winning Move\n");
        availableMoves = [self resetAvailableMovesForRows:winningRowsAI];
        return [self playFromAvailableMoves:availableMoves];
    } else if (winningRowsCountOpp>0) {
        if (winningRowsCountOpp>1) {
            NSLog(@"\n###Opponent managed to create a fork. AI Looses.\n");
        }
        NSLog(@"\n$$Block Opponent\n");
        availableMoves = [self resetAvailableMovesForRows:winningRowsOpponent];
        return [self playFromAvailableMoves:availableMoves];
    }
    NSLog(@"\n@@Strategize The Next Move\n");
    return [self playNextMoveForOpponent:cell];
}

- (NSMutableArray *)resetAvailableMovesForRows:(NSArray *)winningRows
{
    NSMutableArray *availableMoves = [NSMutableArray array];
    for (NSString *row in winningRows) {
        NSArray *cells = [self.board cellsForRow:row];
        for (SymbolCell *cell in cells) {
            if ([cell isAvailable]) {
                [availableMoves addObject:cell];
            }
        }
    }
    return availableMoves;
}

- (SymbolCell *)playFromAvailableMoves:(NSArray *)cells
{
    for (SymbolCell *cell in cells) {
        if ([cell isAvailable]) {
            return cell;
        }
    }
    return nil;
}

- (SymbolCell *)playNextMoveForOpponent:(SymbolCell *)cell
{
    //respond to a center opening with a corner
    if ([self.board isCenter:cell]) {
        SymbolCell *potentialMove = [self firstAvailableCorner];
        if ([potentialMove isAvailable]) {
            return potentialMove;
        }
        potentialMove = [self firstAvailableEdge];
        if ([potentialMove isAvailable]) {
            return potentialMove;
        }
    }
    
    //if the player plays corner; AI plays opposite corner
    if ([self.board isCorner:cell]) {
        SymbolCell *potentialMove = [self.board center];
        if ([potentialMove isAvailable]) {
            return potentialMove;
        }
        potentialMove = [self.board oppositeCorner:cell];
        if ([potentialMove isAvailable]) {
            return potentialMove;
        } else if (potentialMove.currentSymbol != self.mySymbol) {
            potentialMove = [self firstAvailableEdge];
            if ([potentialMove isAvailable]) {
                return potentialMove;
            }
        }
        potentialMove = [self firstAvailableCorner];
        if ([potentialMove isAvailable]) {
            return potentialMove;
        }
    }
    
    if ([self.board isEdge:cell]) {
        SymbolCell *potentialMove = [self.board center];
        if ([potentialMove isAvailable]) {
            return potentialMove;
        }
        potentialMove = [self availableNextCornerToCell:cell];
        if (potentialMove) {
            return potentialMove;
        }
        potentialMove = [self.board oppositeEdge:cell];
        if (potentialMove) {
            return potentialMove;
        }
    }
    return nil;
}

- (SymbolCell *)availableNextCornerToCell:(SymbolCell *)cell
{
    SymbolCell *potentialMove = [self.board topCornerToEdge:cell];
    if ([potentialMove isAvailable]) {
        return potentialMove;
    }
    potentialMove = [self.board leftCornerToEdge:cell];
    if ([potentialMove isAvailable]) {
        return potentialMove;
    }
    potentialMove = [self.board rightCornerToEdge:cell];
    if ([potentialMove isAvailable]) {
        return potentialMove;
    }
    potentialMove = [self.board bottomCornerToEdge:cell];
    if ([potentialMove isAvailable]) {
        return potentialMove;
    }
    return nil;
}

- (SymbolCell *)firstAvailableCorner
{
    SymbolCell *availableCorner = [self.board topLeftCorner];
    if ([availableCorner isAvailable]) {
        return availableCorner;
    }
    availableCorner = [self.board topRightCorner];
    if ([availableCorner isAvailable]) {
        return availableCorner;
    }
    availableCorner = [self.board bottomLeftCorner];
    if ([availableCorner isAvailable]) {
        return availableCorner;
    }
    availableCorner = [self.board bottomRightCorner];
    if ([availableCorner isAvailable]) {
        return availableCorner;
    }
    return nil;
}

- (SymbolCell *)firstAvailableEdge
{
    SymbolCell *availableEdge = [self.board topEdge];
    if ([availableEdge isAvailable]) {
        return availableEdge;
    }
    availableEdge = [self.board leftEdge];
    if ([availableEdge isAvailable]) {
        return availableEdge;
    }
    availableEdge = [self.board bottomEdge];
    if ([availableEdge isAvailable]) {
        return availableEdge;
    }
    availableEdge = [self.board rightEdge];
    if ([availableEdge isAvailable]) {
        return availableEdge;
    }
    return nil;
}

@end

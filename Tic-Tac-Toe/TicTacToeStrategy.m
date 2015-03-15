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

@end

@implementation TicTacToeStrategy

- (instancetype)initWithBoard:(Board *)board;
{
    self = [super init];
    if (self) {
        self.board = board;
    }
    return self;
}

- (SymbolCell *)nextMoveForCurrentOpponentMove:(SymbolCell *)cell
{
    SymbolCell *nextMove = [self attemptWiningMove:cell];
    
    return nextMove;
}

- (SymbolCell *)evaluateCurrentMove:(SymbolCell *)currentCell
{
    NSMutableArray *winningRow = [NSMutableArray array];
    NSMutableArray *availableMoves = [NSMutableArray array];
    NSArray *affectedRows = [self.board rowsForCellAtIndex:currentCell.tag];
    for (NSString *row in affectedRows)
    {
        NSArray *cells = [self.board cellsForRow:row];
        int markedCount = 0;
        int availableCount = 0;
        for (SymbolCell *cell in cells)
        {
            if ([cell isAvailable]) availableCount++;
            if (cell.currentSymbol == SymbolO) {
                markedCount++;
            } else if ([cell isAvailable]) {
                [availableMoves addObject:cell];
            }
        }
        if (markedCount>1) {
            if (markedCount == 3) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Win!"
//                                                                message:nil
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil];
//                [alert show];
            } else if (availableCount) {
                [winningRow addObject:row];
            } else if (availableCount == 0){
                NSLog(@"%@ is full",row);
            }
        }
    }
    
    if ([winningRow count]) {
        availableMoves = [self resetAvailableMovesForWinningRows:winningRow];
        return [self playBlockingMoveFromAvailableMoves:availableMoves forCurrentMove:currentCell];
    } else {
        return [self playNextMoveFromAvailableMoves:availableMoves forCurrentMove:currentCell];
    }
    return nil;
}

- (NSMutableArray *)resetAvailableMovesForWinningRows:(NSArray *)winningRows
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

- (SymbolCell *)attemptWiningMove:(SymbolCell *)cell
{
    NSMutableArray *winningRow = [NSMutableArray array];
    NSMutableArray *availableMoves = [NSMutableArray array];
    NSArray *affectedRows = @[KeyRowBottom,KeyRowCenter,KeyRowDiagonal1,KeyRowDiagonal2,KeyRowLeft,KeyRowMiddle,KeyRowRight,KeyRowTop];
    
    for (NSString *row in affectedRows)
    {
        NSArray *cells = [self.board cellsForRow:row];
        int markedCount = 0;
        int availableCount = 0;
        for (SymbolCell *cell in cells)
        {
            if ([cell isAvailable]) availableCount++;
            if (cell.currentSymbol == SymbolX) {
                markedCount++;
            } else if ([cell isAvailable]) {
                [availableMoves addObject:cell];
            }
        }
        if (availableCount && markedCount>=2) {
            [winningRow addObject:row];
        } else if (availableCount == 0){
            NSLog(@"%@ is full",row);
        } else {
            [availableMoves removeAllObjects];
        }
    }
    
    if ([winningRow count]) {
        return [self playWinningMoveFromAvailableMoves:availableMoves];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"I Win!"
//                                                        message:nil
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
    } else {
        return [self evaluateCurrentMove:cell];
    }
    return nil;
}

- (SymbolCell *)playWinningMoveFromAvailableMoves:(NSArray *)cells
{
    for (SymbolCell *cell in cells) {
        if ([cell isAvailable]) {
            return cell;
//            [self mark:cell];
//            break;
        }
    }
    return nil;
}

- (SymbolCell *)playNextMoveFromAvailableMoves:(NSArray *)availableMoves forCurrentMove:(SymbolCell *)cell
{
    //respond to a center opening with a corner
    if ([self.board isCenter:cell]) {
        SymbolCell *potentialMove = [self firstAvailableCorner];
        if ([potentialMove isAvailable]) {
            return potentialMove;
//            [self mark:potentialMove];
//            return;
        }
        potentialMove = [self firstAvailableEdge];
        if ([potentialMove isAvailable]) {
            return potentialMove;
//            [self mark:potentialMove];
//            return;
        }
    }
    
    //if the player plays corner; AI plays opposite corner
    if ([self.board isCorner:cell]) {
        SymbolCell *potentialMove = [self.board center];
        if ([potentialMove isAvailable]) {
            return potentialMove;
//            [self mark:potentialMove];
//            return;
        }
        potentialMove = [self.board oppositeCorner:cell];
        if ([potentialMove isAvailable]) {
            return potentialMove;
//            [self mark:potentialMove];
//            return;
        } else if (potentialMove.currentSymbol == SymbolO) {
            potentialMove = [self firstAvailableEdge];
            if ([potentialMove isAvailable]) {
                return potentialMove;
//                [self mark:potentialMove];
//                return;
            }
        }
        potentialMove = [self firstAvailableCorner];
        if ([potentialMove isAvailable]) {
            return potentialMove;
//            [self mark:potentialMove];
//            return;
        }
    }
    
    if ([self.board isEdge:cell]) {
        SymbolCell *potentialMove = [self.board center];
        if ([potentialMove isAvailable]) {
            return potentialMove;
//            [self mark:potentialMove];
//            return;
        }
        potentialMove = [self availableNextCornerToCell:cell];
        if (potentialMove) {
            return potentialMove;
//            [self mark:potentialMove];
//            return;
        }
        potentialMove = [self.board oppositeEdge:cell];
        if (potentialMove) {
            return potentialMove;
//            [self mark:potentialMove];
//            return;
        }
    }
    return nil;
}

- (SymbolCell *)playBlockingMoveFromAvailableMoves:(NSArray *)cells forCurrentMove:(SymbolCell *)cell
{
    for (SymbolCell *cell in cells) {
        if ([cell isAvailable]) {
            return cell;
//            [self mark:cell];
//            break;
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

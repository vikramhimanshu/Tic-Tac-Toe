//
//  Board.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//


#import "Board.h"
#import "BoardView.h"
#import "SymbolCell.h"

#import "NSIndexPath+Compare.h"

@interface Board ()

@property (nonatomic, weak) BoardView *boardView;
@property (nonatomic, strong) Grid *gameGrid;
@property (nonatomic)  NSMutableArray *allCellsArray;

@end

@implementation Board

- (instancetype)initWithBoardView:(BoardView *)boardView
{
    self = [super init];
    if (self) {
        self.boardView = boardView;
    }
    return self;
}

- (void)display
{
    if (self.gameGrid) {
        self.gameGrid = nil;
    }
    [self.boardView reloadData];
}

-(NSArray *)allCells
{
    return [self.allCellsArray copy];
}

+ (NSInteger)numberOfRows
{
    return 3;
}

+ (NSInteger)numberOfColumns
{
    return 3;
}

+ (NSInteger)lastRowIndex
{
    return ([Board numberOfColumns]*[Board numberOfRows])-1;
}

- (NSArray *)rowsForCellAtIndex:(NSInteger)idx
{
    return [self.gameGrid rowsForCellAtIndex:idx];
}

- (NSArray *)cellsForRow:(NSString *)rowKey
{
    return [self.gameGrid cellsForRow:rowKey];
}

- (SymbolCell *)center
{
    return [self.gameGrid center];
}

- (SymbolCell *)topLeftCorner
{
    return [self.gameGrid topLeftCorner];
}

- (SymbolCell *)topRightCorner
{
    return [self.gameGrid topRightCorner];
}

- (SymbolCell *)bottomLeftCorner
{
    return [self.gameGrid bottomLeftCorner];
}

- (SymbolCell *)bottomRightCorner
{
    return [self.gameGrid bottomRightCorner];
}

-(SymbolCell *)topEdge
{
    return [self.gameGrid topEdge];
}

-(SymbolCell *)leftEdge
{
    return [self.gameGrid leftEdge];
}

-(SymbolCell *)rightEdge
{
    return [self.gameGrid rightEdge];
}

-(SymbolCell *)bottomEdge
{
    return [self.gameGrid bottomEdge];
}

- (BOOL)isTopLeftCorner:(SymbolCell *)cell
{
    return [self.gameGrid isTopLeftCorner:cell];
}

- (BOOL)isTopRightCorner:(SymbolCell *)cell
{
    return [self.gameGrid isTopRightCorner:cell];
}

- (BOOL)isBottomLeftCorner:(SymbolCell *)cell
{
    return [self.gameGrid isBottomLeftCorner:cell];
}

- (BOOL)isBottomRightCorner:(SymbolCell *)cell
{
    return [self.gameGrid isBottomRightCorner:cell];
}

- (BOOL)isTopEdge:(SymbolCell *)cell
{
    return [self.gameGrid isTopEdge:cell];
}

- (BOOL)isBottomEdge:(SymbolCell *)cell
{
    return [self.gameGrid isBottomEdge:cell];
}

- (BOOL)isLeftEdge:(SymbolCell *)cell
{
    return [self.gameGrid isLeftEdge:cell];
}

- (BOOL)isRightEdge:(SymbolCell *)cell
{
    return [self.gameGrid isRightEdge:cell];
}

- (SymbolCell *)leftCornerToEdge:(SymbolCell *)cell
{
    return [self.gameGrid leftCornerToEdge:cell];
}

- (SymbolCell *)rightCornerToEdge:(SymbolCell *)cell
{
    return [self.gameGrid rightCornerToEdge:cell];
}

- (SymbolCell *)topCornerToEdge:(SymbolCell *)cell
{
    return [self.gameGrid topCornerToEdge:cell];
}

- (SymbolCell *)bottomCornerToEdge:(SymbolCell *)cell
{
    return [self.gameGrid bottomCornerToEdge:cell];
}

- (SymbolCell *)oppositeCorner:(SymbolCell *)cell
{
    return [self.gameGrid oppositeCorner:cell];
}

- (SymbolCell *)oppositeEdge:(SymbolCell *)cell
{
    return [self.gameGrid oppositeEdge:cell];
}

- (BOOL)isCorner:(SymbolCell *)cell
{
    return [self.gameGrid isCorner:cell];
}

- (BOOL)isCenter:(SymbolCell *)cell
{
    return [self.gameGrid isCenter:cell];
}

- (BOOL)isEdge:(SymbolCell *)cell
{
    return [self.gameGrid isEdge:cell];
}

//- (void)evaluateCurrentMove:(SymbolCell *)currentCell
//{
//    NSMutableArray *winningRow = [NSMutableArray array];
//    NSMutableArray *availableMoves = [NSMutableArray array];
//    NSArray *affectedRows = [self.gameGrid rowsForCellAtIndex:currentCell.tag];
//    for (NSString *row in affectedRows)
//    {
//        NSArray *cells = [self.gameGrid cellsForRow:row];
//        int markedCount = 0;
//        int availableCount = 0;
//        for (SymbolCell *cell in cells)
//        {
//            if ([cell isAvailable]) availableCount++;
//            if (cell.currentSymbol == SymbolO) {
//                markedCount++;
//            } else if ([cell isAvailable]) {
//                [availableMoves addObject:cell];
//            }
//        }
//        if (markedCount>1) {
//            if (markedCount == 3) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Win!"
//                                                                message:nil
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"OK"
//                                                      otherButtonTitles:nil];
//                [alert show];
//            } else if (availableCount) {
//                [winningRow addObject:row];
//            } else if (availableCount == 0){
//                NSLog(@"%@ is full",row);
//            }
//        }
//    }
//    
//    if ([winningRow count]) {
//        availableMoves = [self resetAvailableMovesForWinningRows:winningRow];
//        [self playBlockingMoveFromAvailableMoves:availableMoves forCurrentMove:currentCell];
//    } else {
//        [self playNextMoveFromAvailableMoves:availableMoves forCurrentMove:currentCell];
//    }
//}
//
//- (NSMutableArray *)resetAvailableMovesForWinningRows:(NSArray *)winningRows
//{
//    NSMutableArray *availableMoves = [NSMutableArray array];
//    for (NSString *row in winningRows) {
//        NSArray *cells = [self.gameGrid cellsForRow:row];
//        for (SymbolCell *cell in cells) {
//            if ([cell isAvailable]) {
//                [availableMoves addObject:cell];
//            }
//        }
//    }
//    return availableMoves;
//}
//
//- (void)attemptWiningMove:(SymbolCell *)cell
//{
//    NSMutableArray *winningRow = [NSMutableArray array];
//    NSMutableArray *availableMoves = [NSMutableArray array];
//    NSArray *affectedRows = @[KeyRowBottom,KeyRowCenter,KeyRowDiagonal1,KeyRowDiagonal2,KeyRowLeft,KeyRowMiddle,KeyRowRight,KeyRowTop];
//    
//    for (NSString *row in affectedRows)
//    {
//        NSArray *cells = [self.gameGrid cellsForRow:row];
//        int markedCount = 0;
//        int availableCount = 0;
//        for (SymbolCell *cell in cells)
//        {
//            if ([cell isAvailable]) availableCount++;
//            if (cell.currentSymbol == SymbolX) {
//                markedCount++;
//            } else if ([cell isAvailable]) {
//                [availableMoves addObject:cell];
//            }
//        }
//        if (availableCount && markedCount>=2) {
//            [winningRow addObject:row];
//        } else if (availableCount == 0){
//            NSLog(@"%@ is full",row);
//        } else {
//            [availableMoves removeAllObjects];
//        }
//    }
//    
//    if ([winningRow count]) {
//        [self playWinningMoveFromAvailableMoves:availableMoves];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"I Win!"
//                                                        message:nil
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//    } else {
//        [self evaluateCurrentMove:cell];
//    }
//}
//
//- (void)playWinningMoveFromAvailableMoves:(NSArray *)cells
//{
//    for (SymbolCell *cell in cells) {
//        if ([cell isAvailable]) {
//            [self mark:cell];
//            break;
//        }
//    }
//    return;
//}
//
//- (void)playNextMoveFromAvailableMoves:(NSArray *)availableMoves forCurrentMove:(SymbolCell *)cell
//{
//    //respond to a center opening with a corner
//    if ([self.gameGrid isCenter:cell]) {
//        SymbolCell *potentialMove = [self firstAvailableCorner];
//        if ([potentialMove isAvailable]) {
//            [self mark:potentialMove];
//            return;
//        }
//        potentialMove = [self firstAvailableEdge];
//        if ([potentialMove isAvailable]) {
//            [self mark:potentialMove];
//            return;
//        }
//    }
//
//    //if the player plays corner; AI plays opposite corner
//    if ([self.gameGrid isCorner:cell]) {
//        SymbolCell *potentialMove = [self.gameGrid center];
//        if ([potentialMove isAvailable]) {
//            [self mark:potentialMove];
//            return;
//        }
//        potentialMove = [self.gameGrid oppositeCorner:cell];
//        if ([potentialMove isAvailable]) {
//            [self mark:potentialMove];
//            return;
//        } else if (potentialMove.currentSymbol == SymbolO) {
//            potentialMove = [self firstAvailableEdge];
//            if ([potentialMove isAvailable]) {
//                [self mark:potentialMove];
//                return;
//            }
//        }
//        potentialMove = [self firstAvailableCorner];
//        if ([potentialMove isAvailable]) {
//            [self mark:potentialMove];
//            return;
//        }
//    }
//
//    if ([self.gameGrid isEdge:cell]) {
//        SymbolCell *potentialMove = [self.gameGrid center];
//        if ([potentialMove isAvailable]) {
//            [self mark:potentialMove];
//            return;
//        }
//        potentialMove = [self availableNextCornerToCell:cell];
//        if (potentialMove) {
//            [self mark:potentialMove];
//            return;
//        }
//        potentialMove = [self.gameGrid oppositeEdge:cell];
//        if (potentialMove) {
//            [self mark:potentialMove];
//            return;
//        }
//    }
//}
//
//- (void)playBlockingMoveFromAvailableMoves:(NSArray *)cells forCurrentMove:(SymbolCell *)cell
//{
//    for (SymbolCell *cell in cells) {
//        if ([cell isAvailable]) {
//            [self mark:cell];
//            break;
//        }
//    }
//    return;
//}
//
//- (SymbolCell *)availableNextCornerToCell:(SymbolCell *)cell
//{
//    SymbolCell *potentialMove = [self.gameGrid topCornerToEdge:cell];
//    if ([potentialMove isAvailable]) {
//        return potentialMove;
//    }
//    potentialMove = [self.gameGrid leftCornerToEdge:cell];
//    if ([potentialMove isAvailable]) {
//        return potentialMove;
//    }
//    potentialMove = [self.gameGrid rightCornerToEdge:cell];
//    if ([potentialMove isAvailable]) {
//        return potentialMove;
//    }
//    potentialMove = [self.gameGrid bottomCornerToEdge:cell];
//    if ([potentialMove isAvailable]) {
//        return potentialMove;
//    }
//    return nil;
//}
//
//- (SymbolCell *)firstAvailableCorner
//{
//    SymbolCell *availableCorner = [self.gameGrid topLeftCorner];
//    if ([availableCorner isAvailable]) {
//        return availableCorner;
//    }
//    availableCorner = [self.gameGrid topRightCorner];
//    if ([availableCorner isAvailable]) {
//        return availableCorner;
//    }
//    availableCorner = [self.gameGrid bottomLeftCorner];
//    if ([availableCorner isAvailable]) {
//        return availableCorner;
//    }
//    availableCorner = [self.gameGrid bottomRightCorner];
//    if ([availableCorner isAvailable]) {
//        return availableCorner;
//    }
//    return nil;
//}
//
//- (SymbolCell *)firstAvailableEdge
//{
//    SymbolCell *availableEdge = [self.gameGrid topEdge];
//    if ([availableEdge isAvailable]) {
//        return availableEdge;
//    }
//    availableEdge = [self.gameGrid leftEdge];
//    if ([availableEdge isAvailable]) {
//        return availableEdge;
//    }
//    availableEdge = [self.gameGrid bottomEdge];
//    if ([availableEdge isAvailable]) {
//        return availableEdge;
//    }
//    availableEdge = [self.gameGrid rightEdge];
//    if ([availableEdge isAvailable]) {
//        return availableEdge;
//    }
//    return nil;
//}

- (void)markCell:(SymbolCell *)cell withSymbol:(Symbol)symbol
{
    [cell updateCellWithSymbol:symbol];
    
    if ([self.delegate respondsToSelector:@selector(boardDidChangeWithMove:)]) {
        [self.delegate boardDidChangeWithMove:cell];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SymbolCell *cell = (SymbolCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if ([self.delegate respondsToSelector:@selector(boardWillChangeWithMove:)]) {
        [self.delegate boardWillChangeWithMove:cell];
    }
//    if ([cell isAvailable] && !self.computerShouldPlay) {
//        [cell updateCellWithSymbol:SymbolO];
//        
//        self.computerShouldPlay = YES;
//        
//        [self attemptWiningMove:cell];
//
//    } else {
//        NSLog(@"Invalid Move");
//    }
//    
//    self.isFirstMove = NO;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger rowCount = 0;
    static NSInteger colCount = 0;
    
    SymbolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                 forIndexPath:indexPath];
    cell.tag = indexPath.item;
    
    colCount = (indexPath.item % [Board numberOfColumns]);
    
    [cell initWithLocation:location(rowCount,colCount)];
    
    BOOL shouldIncrementRowCount = (colCount == 2);
    if (shouldIncrementRowCount) {
        rowCount++;
    }

    NSLog(@"{Row: %ld----Section: %ld}",(long)cell.location.row,(long)cell.location.section);
    [self.allCellsArray addObject:cell];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [Board numberOfRows]*[Board numberOfColumns];
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath item] == [Board lastRowIndex]) {
        self.gameGrid = [[Grid alloc] initWithCells:self.allCellsArray];
        [self.gameGrid create];
    }
}

-(NSMutableArray *)allCellsArray
{
    if (_allCellsArray == nil) {
        _allCellsArray = [NSMutableArray array];
    }
    return _allCellsArray;
}

@end

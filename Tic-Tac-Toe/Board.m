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

@property (nonatomic)  NSMutableArray *rowsToCheck;

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
    [self.allCellsArray removeAllObjects];
    [self.rowsToCheck removeAllObjects];
    [self.boardView reloadData];
}

-(NSArray *)allCells
{
    return [self.allCellsArray copy];
}

- (NSInteger)numberOfRows
{
    return 3;
}

- (NSInteger)numberOfColumns
{
    return 3;
}

- (NSInteger)lastRowIndex
{
    return ([self numberOfColumns]*[self numberOfRows])-1;
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

- (void)markCell:(SymbolCell *)cell withSymbol:(Symbol)symbol
{
    if ([cell isAvailable]) {
        [cell updateCellWithSymbol:symbol];
        [self evaluateBoardForStatus];
        [self boardDidChangeWithMove:cell];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SymbolCell *cell = (SymbolCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self boardWillChangeWithMove:cell];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSInteger rowCount = 0;
    NSInteger colCount = 0;
    
    SymbolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                 forIndexPath:indexPath];
    cell.tag = indexPath.item;
    
    colCount = (indexPath.item % [self numberOfColumns]);
    
    [cell initWithLocation:location(rowCount,colCount)];
    
    BOOL shouldIncrementRowCount = (colCount == 2);
    if (shouldIncrementRowCount) {
        rowCount++;
    }
    
    if (indexPath.item == [self lastRowIndex]) {
        rowCount = 0;
    }

//    NSLog(@"{Row: %ld----Section: %ld}",(long)cell.location.row,(long)cell.location.section);
    [self.allCellsArray addObject:cell];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self numberOfRows]*[self numberOfColumns];
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath item] == [self lastRowIndex]) {
        self.gameGrid = [[Grid alloc] initWithCells:self.allCellsArray];
        [self.gameGrid create];
        self.rowsToCheck = [@[KeyRowTop,KeyRowMiddle,KeyRowBottom,
                             KeyRowLeft,KeyRowRight,KeyRowCenter,
                             KeyRowDiagonal1,KeyRowDiagonal2] mutableCopy];
    }
}

-(NSMutableArray *)allCellsArray
{
    if (_allCellsArray == nil) {
        _allCellsArray = [NSMutableArray array];
    }
    return _allCellsArray;
}

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
//            NSLog(@"%@ is full, removing it from the check",row);
            [completedRows addObject:row];
            if (markedCountO == 3) {
//                NSLog(@"SymbolO Wins");
                [self boardDidDetectWinInRow:row forSymbol:SymbolO];
                return;
            } else if (markedCountX == 3) {
//                NSLog(@"SymbolX Wins");
                [self boardDidDetectWinInRow:row forSymbol:SymbolX];
                return;
            }
        }
    }
    
    [self.rowsToCheck removeObjectsInArray:completedRows];
    
    if ([availableMoves count] == 0) {
        [self boardDidDetectDraw];
    }
    
    int winningRowsCountX = [winningRowsO count];
    int winningRowsCountO = [winningRowsX count];
    if (winningRowsCountO>0) {
//        NSLog(@"Fork detected for SymbolO");
        [self boardDidDetectBlockInRows:winningRowsO forSymbol:SymbolO];
        if (winningRowsCountO>1) {
            [self boardDidDetectForkInRows:winningRowsO forSymbol:SymbolO];
        }
    } else if (winningRowsCountX>0) {
//        NSLog(@"Fork detected for SymbolX");
        [self boardDidDetectBlockInRows:winningRowsX forSymbol:SymbolX];
        if (winningRowsCountX>1) {
            [self boardDidDetectForkInRows:winningRowsX forSymbol:SymbolX];
        }
    }
    [self boardDidCompleteCheckWithAvailableMoves:availableMoves];
}


#pragma mark BoardDelegate

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

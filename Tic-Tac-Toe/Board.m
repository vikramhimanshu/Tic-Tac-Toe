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
#import "Grid.h"
#import "RowKeys.h"

#import "Board+Grid.h"
#import "Board+CompletionStatus.h"
#import "Board+BoardDelegate.h"

#import "NSIndexPath+Compare.h"

@interface Board ()

@property (nonatomic, weak) BoardView *boardView;
@property (nonatomic)  NSMutableArray *allCellsArray;

//Board+Grid
@property (nonatomic, strong) Grid *gameGrid;
//Board+CompletionStatus
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

@end

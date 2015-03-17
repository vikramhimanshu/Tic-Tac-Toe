//
//  Board+Grid.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/17/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "Board+Grid.h"
#import "Grid.h"

@implementation Board (Grid)

@dynamic gameGrid;

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

@end

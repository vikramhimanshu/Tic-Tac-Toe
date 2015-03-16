//
//  Grid.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/14/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "Grid.h"
#import "SymbolCell.h"
#import "NSIndexPath+Compare.h"

NSString *const KeyRowTop       = @"KeyRowTop";
NSString *const KeyRowMiddle    = @"KeyRowMiddle";
NSString *const KeyRowBottom    = @"KeyRowBottom";
NSString *const KeyRowLeft      = @"KeyRowLeft";
NSString *const KeyRowCenter    = @"KeyRowCenter";
NSString *const KeyRowRight     = @"KeyRowRight";
NSString *const KeyRowDiagonal1 = @"KeyRowDiagonal1";
NSString *const KeyRowDiagonal2 = @"KeyRowDiagonal2";

@interface Grid ()

@property (nonatomic, readwrite)  NSArray *allCells;
@property (nonatomic)  NSMutableDictionary *cellsForRows;
@property (nonatomic)  NSMutableDictionary *rowsForCell;

@end

@implementation Grid

-(void)dealloc
{
    [self.cellsForRows removeAllObjects];
    [self.rowsForCell removeAllObjects];
    self.allCells = nil;
    self.cellsForRows = nil;
    self.rowsForCell = nil;
}

- (instancetype)initWithCells:(NSArray *)cellsArray
{
    self = [super init];
    if (self) {
        self.allCells = cellsArray;
    }
    return self;
}

- (void)create
{
    for (NSString *key in [[self rows] allKeys]) {
        [self.cellsForRows setObject:[self cellsForRows:key]
                              forKey:key];
    }
}

- (NSArray *)cellsForRows:(NSString *)rowKey
{
    NSMutableArray *cells = [NSMutableArray array];
    NSArray *topRowLocations = [[self rows] objectForKey:rowKey];
    for (NSIndexPath *loc in topRowLocations) {
        for (SymbolCell *cell in self.allCells) {
            if ([cell.location equal:loc]) {
                [cells addObject:cell];
                [self updateRowsArrayWith:rowKey forCell:cell];
            }
        }
    }
//    NSLog(@"Cells:%@ forRowKey:%@",cells,rowKey);
    return cells;
}

- (void)updateRowsArrayWith:(NSString *)rowsKey forCell:(SymbolCell *)cell
{
//    NSLog(@"%d",cell.tag);
    NSMutableArray *rowsArray = [self.rowsForCell objectForKey:[NSString stringWithFormat:@"%d",cell.tag]];
    if (rowsArray) {
        [rowsArray addObject:rowsKey];
    } else {
        rowsArray = [NSMutableArray arrayWithObject:rowsKey];
    }
    [self.rowsForCell setObject:rowsArray
                         forKey:[NSString stringWithFormat:@"%d",cell.tag]];
}

- (NSArray *)cellsForRow:(NSString *)rowKey
{
    return [self.cellsForRows objectForKey:rowKey];
}

- (NSArray *)rowsForCellAtIndex:(NSInteger)idx
{
    return [self.rowsForCell objectForKey:[NSString stringWithFormat:@"%d",idx]];
}

//corners
- (BOOL)isTopLeftCorner:(SymbolCell *)cell
{
    return [cell.location equal:location(0, 0)];
}

- (BOOL)isTopRightCorner:(SymbolCell *)cell
{
    return [cell.location equal:location(0, 2)];
}

- (BOOL)isBottomLeftCorner:(SymbolCell *)cell
{
    return [cell.location equal:location(2, 0)];
}

- (BOOL)isBottomRightCorner:(SymbolCell *)cell
{
    return [cell.location equal:location(2, 2)];
}

//edges
- (BOOL)isTopEdge:(SymbolCell *)cell
{
    return [cell.location equal:location(0, 1)];
}

- (BOOL)isBottomEdge:(SymbolCell *)cell
{
    return [cell.location equal:location(2, 1)];
}

- (BOOL)isLeftEdge:(SymbolCell *)cell
{
    return [cell.location equal:location(1, 0)];
}

- (BOOL)isRightEdge:(SymbolCell *)cell
{
    return [cell.location equal:location(1, 2)];
}

-(SymbolCell *)topLeftCorner
{
    NSArray *cells = [self cellsForRow:KeyRowTop];
    for (SymbolCell *cell in cells) {
        if ([self isTopLeftCorner:cell]) {
            return cell;
        }
    }
    return nil;
}

-(SymbolCell *)topRightCorner
{
    NSArray *cells = [self cellsForRow:KeyRowTop];
    for (SymbolCell *cell in cells) {
        if ([self isTopRightCorner:cell]) {
            return cell;
        }
    }
    return nil;
}

-(SymbolCell *)bottomLeftCorner
{
    NSArray *cells = [self cellsForRow:KeyRowBottom];
    for (SymbolCell *cell in cells) {
        if ([self isBottomLeftCorner:cell]) {
            return cell;
        }
    }
    return nil;
}

-(SymbolCell *)bottomRightCorner
{
    NSArray *cells = [self cellsForRow:KeyRowBottom];
    for (SymbolCell *cell in cells) {
        if ([self isBottomRightCorner:cell]) {
            return cell;
        }
    }
    return nil;
}

-(SymbolCell *)topEdge
{
    NSArray *cells = [self cellsForRow:KeyRowTop];
    for (SymbolCell *cell in cells) {
        if ([self isTopEdge:cell]) {
            return cell;
        }
    }
    return nil;
}

-(SymbolCell *)leftEdge
{
    NSArray *cells = [self cellsForRow:KeyRowLeft];
    for (SymbolCell *cell in cells) {
        if ([self isLeftEdge:cell]) {
            return cell;
        }
    }
    return nil;
}

-(SymbolCell *)rightEdge
{
    NSArray *cells = [self cellsForRow:KeyRowRight];
    for (SymbolCell *cell in cells) {
        if ([self isRightEdge:cell]) {
            return cell;
        }
    }
    return nil;
}

-(SymbolCell *)bottomEdge
{
    NSArray *cells = [self cellsForRow:KeyRowBottom];
    for (SymbolCell *cell in cells) {
        if ([self isBottomEdge:cell]) {
            return cell;
        }
    }
    return nil;
}

- (SymbolCell *)leftCornerToEdge:(SymbolCell *)cell
{
    if ([self isTopEdge:cell]) {
        return [self topLeftCorner];
    } else if ([self isBottomEdge:cell]) {
        return [self bottomLeftCorner];
    }
    return nil;
}

- (SymbolCell *)rightCornerToEdge:(SymbolCell *)cell
{
    if ([self isTopEdge:cell]) {
        return [self topRightCorner];
    } else if ([self isBottomEdge:cell]) {
        return [self bottomRightCorner];
    }
    return nil;
}

- (SymbolCell *)topCornerToEdge:(SymbolCell *)cell
{
    if ([self isLeftEdge:cell]) {
        return [self topLeftCorner];
    } else if ([self isRightEdge:cell]) {
        return [self topRightCorner];
    }
    return nil;
}

- (SymbolCell *)bottomCornerToEdge:(SymbolCell *)cell
{
    if ([self isLeftEdge:cell]) {
        return [self bottomLeftCorner];
    } else if ([self isRightEdge:cell]) {
        return [self bottomRightCorner];
    }
    return nil;
}

- (BOOL)isCenter:(SymbolCell *)cell
{
    return [cell.location equal:location(1, 1)];
}

- (BOOL)isCorner:(SymbolCell *)cell
{
    return ([cell.location equal:location(0, 0)] ||
            [cell.location equal:location(0, 2)] ||
            [cell.location equal:location(2, 0)] ||
            [cell.location equal:location(2, 2)]);
}

- (BOOL)isEdge:(SymbolCell *)cell
{
    return ([self isTopEdge:cell]    ||
            [self isBottomEdge:cell] ||
            [self isLeftEdge:cell]   ||
            [self isRightEdge:cell]);
}

-(SymbolCell *)center
{
    NSArray *cells = [self cellsForRow:KeyRowCenter];
    for (SymbolCell *cell in cells) {
        if ([self isCenter:cell]) {
            return cell;
        }
    }
    return nil;
}

- (SymbolCell *)oppositeCorner:(SymbolCell *)cell
{
    if ([self isTopLeftCorner:cell])
    {
        return [self bottomRightCorner];
    }
    else if ([self isTopRightCorner:cell])
    {
        return [self bottomLeftCorner];
    }
    else if ([self isBottomLeftCorner:cell])
    {
        return [self topRightCorner];
    }
    else if ([self isBottomRightCorner:cell])
    {
        return [self topLeftCorner];
    }
    return nil;
}

- (SymbolCell *)oppositeEdge:(SymbolCell *)cell
{
    if ([self isTopEdge:cell])
    {
        return [self bottomEdge];
    }
    else if ([self isBottomEdge:cell])
    {
        return [self topEdge];
    }
    else if ([self isLeftEdge:cell])
    {
        return [self rightEdge];
    }
    else if ([self isRightEdge:cell])
    {
        return [self leftEdge];
    }
    return nil;
}

#pragma mark Lazy Loading of properties
-(NSMutableDictionary *)cellsForRows
{
    if (_cellsForRows == nil) {
        _cellsForRows = [[NSMutableDictionary alloc] init];
    }
    return _cellsForRows;
}

-(NSMutableDictionary *)rowsForCell
{
    if (_rowsForCell == nil) {
        _rowsForCell = [[NSMutableDictionary alloc] init];
    }
    return _rowsForCell;
}

- (NSDictionary *)rows
{
    return @{
             KeyRowTop       : @[location(0,0),location(0,1),location(0,2)],
             KeyRowMiddle    : @[location(1,0),location(1,1),location(1,2)],
             KeyRowBottom    : @[location(2,0),location(2,1),location(2,2)],
             KeyRowDiagonal1 : @[location(0,0),location(1,1),location(2,2)],
             KeyRowDiagonal2 : @[location(0,2),location(1,1),location(2,0)],
             KeyRowLeft      : @[location(0,0),location(1,0),location(2,0)],
             KeyRowCenter    : @[location(0,1),location(1,1),location(2,1)],
             KeyRowRight     : @[location(0,2),location(1,2),location(2,2)]
             };
}


@end

//
//  SymbolCell.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Symbol.h"

@interface SymbolCell : UICollectionViewCell

@property (nonatomic,readonly) Symbol currentSymbol;
@property (nonatomic,readonly) NSIndexPath *location;

- (void)initWithLocation:(NSIndexPath *)loc;
- (void)updateCellWithSymbol:(Symbol)sym;
- (BOOL)isAvailable;

@end

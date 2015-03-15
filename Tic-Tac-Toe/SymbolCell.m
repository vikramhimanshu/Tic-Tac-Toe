//
//  SymbolCell.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "SymbolCell.h"

@interface SymbolCell ()

@property (nonatomic,weak) IBOutlet UILabel *symbolLbl;
@property (nonatomic,readwrite) Symbol currentSymbol;
@property (nonatomic,readwrite) NSIndexPath *location;

@end

@implementation SymbolCell

- (void)initWithLocation:(NSIndexPath *)loc;
{
    self.location = loc;
    [self updateCellWithSymbol:SymbolNone];
}

- (void)updateCellWithSymbol:(Symbol)sym
{
    if (sym == SymbolO) {
        self.symbolLbl.text = @"O";
    } else if (sym == SymbolX) {
        self.symbolLbl.text = @"X";
    } else {
        self.symbolLbl.text = @"";
    }
    self.currentSymbol = sym;
}

-(BOOL)isAvailable
{
    return (self.currentSymbol == SymbolNone);
}

@end

//
//  Board+CompletionStatus.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/17/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "Board.h"

@interface Board (CompletionStatus)

@property (nonatomic)  NSMutableArray *rowsToCheck;

- (void)evaluateBoardForStatus;

@end

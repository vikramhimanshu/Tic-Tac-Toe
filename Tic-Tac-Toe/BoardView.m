//
//  BoardView.m
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import "BoardView.h"

@implementation BoardView

-(CGSize)intrinsicContentSize
{
    return CGSizeMake(300, 300);
}

-(void)reloadDataWithCompletionBlock:(void(^)(void))completionBlock
{
    [super reloadData];
    completionBlock();
}

@end

//
//  BoardView.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoardView : UICollectionView

-(void)reloadDataWithCompletionBlock:(void(^)(void))completionBlock;

@end

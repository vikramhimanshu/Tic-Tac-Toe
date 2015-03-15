//
//  NSIndexPath+Compare.h
//  Tic-Tac-Toe
//
//  Created by Himanshu Vikram on 3/13/15.
//  Copyright (c) 2015 Himanshu Tantia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSIndexPath (Compare)

-(BOOL)equal:(NSIndexPath *)otherObject;

NSIndexPath * location(NSInteger row, NSInteger col);

@end

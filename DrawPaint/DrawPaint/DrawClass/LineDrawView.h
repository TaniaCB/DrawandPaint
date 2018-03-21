//
//  LineDrawView.h
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineDrawView : UIView{
    BOOL isPainting;
    BOOL isErasing;
    BOOL isMarking;
    
    NSMutableArray *lines;
    CGPoint lastPoint;
    
    float xFixed;
    float yFixed;
}

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineWidthDelete;
@property (nonatomic, assign) BOOL empty;

- (void) clear;
- (void) setIsPainting: (BOOL) painting;
- (void) setIsErasing: (BOOL) erasing;
- (void) setIsMarking: (BOOL) marking;

- (void) setColor: (UIColor *) color;
@end

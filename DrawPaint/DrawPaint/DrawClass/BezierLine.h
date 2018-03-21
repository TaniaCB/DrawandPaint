//
//  BezierLine.h
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface BezierLine : NSObject{
    float cpx;
    float cpy;
    CGPoint mid1;
    CGPoint mid2;
    UIColor *color;
    int width;
    BOOL isMarking;
}

- (id)initWithCpx:(float)cpx andCpy:(float)cpy andMid1:(CGPoint)m1 andMid2:(CGPoint) m2 andColor: (UIColor *) c andWidth: (int) w andIsMarking:(BOOL) isMark;

- (float) getCpx;
- (float) getCpy;
- (CGPoint) getMid1;
- (CGPoint) getMid2;
- (UIColor *) getColor;
- (int) getWidth;
- (BOOL) getIsMark;

@end

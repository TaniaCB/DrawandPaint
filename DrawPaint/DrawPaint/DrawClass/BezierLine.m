//
//  BezierLine.m
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//

#import "BezierLine.h"

@implementation BezierLine

- (id)initWithCpx:(float)pointcpx andCpy:(float)pointcpy andMid1:(CGPoint)m1 andMid2:(CGPoint) m2 andColor: (UIColor *) c andWidth: (int) w andIsMarking:(BOOL) isMark{
    if (self) {
        cpx = pointcpx;
        cpy = pointcpy;
        mid1 = m1;
        mid2 = m2;
        color = c;
        width = w;
        isMarking = isMark;
    }
    return self;
}

- (float) getCpx{
    return cpx;
}

- (float) getCpy{
    return cpy;
}

- (CGPoint) getMid1{
    return mid1;
}


- (CGPoint) getMid2{
    return mid2;
}

- (UIColor *) getColor{
    return color;
}

- (int) getWidth{
    return width;
}


- (BOOL) getIsMark{
    return isMarking;
}

@end

//
//  Line.m
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//

#import "Line.h"

@implementation Line

- (id)initWithStart:(CGPoint)s andEnd:(CGPoint)e andColor: (UIColor *) c andWidth:(int)w{
    if (self) {
        start = s;
        end = e;
        color = c;
        width = w;
    }
    return self;
}

- (CGFloat) getStartX{
    return start.x;
}

- (CGFloat) getStartY{
    return start.y;
}

- (CGFloat) getEndX{
    return end.x;
}


- (CGFloat) getEndY{
    return end.y;
}

- (UIColor *) getColor{
    return color;
}

- (int) getWidth{
    return width;
}


@end

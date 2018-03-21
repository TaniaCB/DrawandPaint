//
//  Line.h
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface Line : NSObject{
    CGPoint start;
    CGPoint end;
    UIColor *color;
    int width;
}

- (id)initWithStart:(CGPoint)s andEnd:(CGPoint)e andColor: (UIColor *) c andWidth: (int) w;

- (CGFloat) getStartX;
- (CGFloat) getStartY;
- (CGFloat) getEndX;
- (CGFloat) getEndY;
- (UIColor *) getColor;
- (int) getWidth;

@end

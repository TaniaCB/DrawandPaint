//
//  LineDrawView.m
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//

#import "LineDrawView.h"
#import <QuartzCore/QuartzCore.h>
#import "Line.h"

#define COLOR_BLACK                 [UIColor blackColor]
#define WIDTH_SMALL                 3.0f
#define WIDTH_MEDIUM                15.0f
#define WIDTH_DELETE                15.0f
#define DEFAULT_BACKGROUND_COLOR    [UIColor clearColor]

@implementation LineDrawView

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  
  if (self) {
    _lineWidth = WIDTH_SMALL;
    _lineColor = COLOR_BLACK;
    _empty = YES;
  }
  
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  
  if (self) {
      self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
      
      _lineWidth = WIDTH_SMALL;
      _lineColor = COLOR_BLACK;
      _lineWidthDelete = WIDTH_DELETE;
      _empty = YES;
      
      isPainting = NO;
      isErasing = NO;
      isMarking = NO;
      
      lines = [NSMutableArray array];
          
      [self setMultipleTouchEnabled:NO];
  }
  
  return self;
}

- (void) setIsPainting: (BOOL) painting{
    isPainting = painting;
    _lineWidth = WIDTH_SMALL;
}

- (void) setIsErasing: (BOOL) erasing{
    isErasing = erasing;
}

- (void) setIsMarking: (BOOL) marking{
    isMarking  = marking;
    _lineWidth = WIDTH_MEDIUM;
}

- (void) setColor: (UIColor *) color{
    _lineColor = color;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     if(isPainting || isErasing || isMarking){
        UITouch *touch = [touches anyObject];
         lastPoint = [touch locationInView:self];
         xFixed = lastPoint.x;
         yFixed = lastPoint.y;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(isPainting || isErasing || isMarking){
        UITouch *touch = [touches anyObject];
        CGPoint newPoint = [touch locationInView:self];
 
        if (isErasing) {
            [self checkIfErasingLines:newPoint];
        }else if(isMarking){
            float difX = abs((int)xFixed - (int)newPoint.x);
            float difY = abs((int)yFixed - (int)newPoint.y);
            
            if(difX<difY){
                newPoint.x  = xFixed;
            }else{
                newPoint.y  = yFixed;
            }
            
            Line *line = [[Line alloc] initWithStart:lastPoint andEnd:newPoint andColor: [_lineColor colorWithAlphaComponent:0.2]  andWidth:_lineWidth];
            [lines addObject:line];
        }else{
            Line *line = [[Line alloc] initWithStart:lastPoint andEnd:newPoint andColor: [_lineColor colorWithAlphaComponent:1] andWidth:_lineWidth];
            [lines addObject:line];
        }
        
        lastPoint = newPoint;
        [self setNeedsDisplay];
    }
}


- (void) checkIfErasingLines:(CGPoint) newPoint{
    float newPointX = newPoint.x;
    float newPointY = newPoint.y;
    
    NSMutableArray *toDelete = [NSMutableArray array];
    
    for (Line *line in lines){
        if (([line getStartX] <= newPointX+30) && ([line getStartY] <= newPointY+30) && (newPointX-[line getStartX] <= 30) && (newPointY-[line getStartY] <= 30)){            [toDelete addObject:line];
        }
    }
    [lines removeObjectsInArray:toDelete];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapButt);
    
    for(Line *line in lines){
        CGContextBeginPath(context);
        CGContextMoveToPoint(context,  [line getStartX], [line getStartY]);
        CGContextAddLineToPoint(context, [line getEndX], [line getEndY]);
        CGContextSetStrokeColorWithColor(context, [line getColor].CGColor);
        CGContextSetLineWidth(context, [line getWidth]);
        CGContextStrokePath(context);
        
        lastPoint = CGPointMake(line.getEndX, line.getEndY);
    }
}

#pragma mark interface

-(void)clear {
  [lines removeAllObjects];
  [self setNeedsDisplay];
}

@end


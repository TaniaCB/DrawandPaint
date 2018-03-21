//
//  BezierLineDrawView.m
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//
#import "BezierLineDrawView.h"
#import <QuartzCore/QuartzCore.h>
#import "BezierLine.h"

#define COLOR_BLACK                 [UIColor blackColor]
#define WIDTH_SMALL                 3.0f
#define WIDTH_MEDIUM                15.0f
#define WIDTH_DELETE                15.0f
#define DEFAULT_BACKGROUND_COLOR    [UIColor clearColor]

@interface BezierLineDrawView ()
    @property (nonatomic,assign) CGPoint currentPoint;
    @property (nonatomic,assign) CGPoint previousPoint;
    @property (nonatomic,assign) CGPoint previousPreviousPoint;

    CGPoint midPoint(CGPoint p1, CGPoint p2);
@end

@implementation BezierLineDrawView

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


#pragma mark private Helper function
CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(isPainting || isErasing || isMarking){
        UITouch *touch = [touches anyObject];
        
        // initializes our point records to current location
        self.previousPoint = [touch previousLocationInView:self];
        self.previousPreviousPoint = [touch previousLocationInView:self];
        self.currentPoint = [touch locationInView:self];
        xFixed = self.currentPoint.x;
        yFixed = self.currentPoint.y;
        
        // call touchesMoved:withEvent:, to possibly draw on zero movement
        [self touchesMoved:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if(isPainting || isErasing || isMarking){
        UITouch *touch = [touches anyObject];
        self.previousPreviousPoint = self.previousPoint;
        self.previousPoint = [touch previousLocationInView:self];
        self.currentPoint = [touch locationInView:self];
        
        CGPoint mid1 = midPoint(self.previousPoint, self.previousPreviousPoint);
        CGPoint mid2 = midPoint(self.currentPoint, self.previousPoint);
        
        if (isErasing) {
            [self checkIfErasingLines:self.currentPoint];
        }else if(isMarking){
            float difX = abs((int)xFixed - (int)self.currentPoint.x);
            float difY = abs((int)yFixed - (int)self.currentPoint.y);
            
            if(difX<difY){
                mid1.x = xFixed;
                mid2.x = xFixed;
            }else{
                mid1.y = yFixed;
                mid2.y = yFixed;
            }
            
            BezierLine *line = [[BezierLine alloc] initWithCpx:self.previousPoint.x andCpy:self.previousPoint.y andMid1:mid1 andMid2:mid2 andColor:[_lineColor colorWithAlphaComponent:0.2] andWidth:_lineWidth andIsMarking:YES];
            
            [lines addObject:line];
        }else{
            BezierLine *line = [[BezierLine alloc] initWithCpx:self.previousPoint.x andCpy:self.previousPoint.y andMid1:mid1 andMid2:mid2 andColor:[_lineColor colorWithAlphaComponent:1] andWidth:_lineWidth andIsMarking:NO];
            
            [lines addObject:line];
        }
        [self setNeedsDisplay];
    }
}


- (void) checkIfErasingLines:(CGPoint) newPoint{
    float newPointX = newPoint.x;
    float newPointY = newPoint.y;
    
    NSMutableArray *toDelete = [NSMutableArray array];
    
    for(BezierLine *line in lines){
        if (([line getMid1].x <= newPointX+30) && ([line getMid1].y <= newPointY+30) && (newPointX-[line getMid1].x <= 30) && (newPointY-[line getMid1].y <= 30)){
            [toDelete addObject:line];
        }
    }
    [lines removeObjectsInArray:toDelete];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapButt);
    
    for(BezierLine *line in lines){
        CGContextBeginPath(context);
        CGContextMoveToPoint(context,  [line getMid1].x, [line getMid1].y);
        if([line getIsMark]){
            CGContextAddLineToPoint(context,  [line getMid2].x, [line getMid2].y);
        }else{
            CGContextAddQuadCurveToPoint(context, [line getCpx], [line getCpy], [line getMid2].x, [line getMid2].y);
        }
        CGContextSetStrokeColorWithColor(context, [line getColor].CGColor);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        //CGContextSetLineJoin(context, kCGLineJoinBevel);
        CGContextSetLineWidth(context, [line getWidth]);
        CGContextStrokePath(context);
    }
}

#pragma mark interface

-(void)clear {
  [lines removeAllObjects];
  [self setNeedsDisplay];
}

@end


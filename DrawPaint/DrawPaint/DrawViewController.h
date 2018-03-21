//
//  ViewController.h
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineDrawView.h"
#import "BezierLineDrawView.h"

@interface DrawViewController : UIViewController{
    LineDrawView *lineDrawView;
    BezierLineDrawView *bezierLineDrawView;
    __weak IBOutlet UIView *barView;
    
    BOOL isPaintingPencil;
    BOOL isPaintingMarker;
    BOOL isErasing;
        
    __weak IBOutlet UIButton *drawButton;
    __weak IBOutlet UIButton *markerButton;
    __weak IBOutlet UIButton *eraserButton;
    __weak IBOutlet UIButton *selectorColorButton;
    __weak IBOutlet UIButton *selectorSizeButton;
    __weak IBOutlet UIButton *saveButton;
    __weak IBOutlet UIButton *clearButton;
}
- (IBAction)paintInView:(id)sender;
- (IBAction)markerInView:(id)sender;
- (IBAction)eraserInView:(id)sender;
- (IBAction)selectColor:(id)sender;
- (IBAction)selectSize:(id)sender;
- (IBAction)saveChanges:(id)sender;
- (IBAction)clearView:(id)sender;

@end


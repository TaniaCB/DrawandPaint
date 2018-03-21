//
//  ViewController.m
//  DrawPaint
//
//  Created by Tania on 8/11/17.
//  Copyright © 2017 TaniaCB. All rights reserved.
//

#import "DrawViewController.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Using Line simple to draw
    /*
    lineDrawView = [[LineDrawView alloc] initWithFrame:CGRectMake(0, 70.0f, self.view.frame.size.width, (self.view.frame.size.height-70.0f))];
    [self.view addSubview:lineDrawView];
     */
    
    //Using Bezier Line to draw (smooth the lines)
    bezierLineDrawView = [[BezierLineDrawView alloc] initWithFrame:CGRectMake(0, 70.0f, self.view.frame.size.width, (self.view.frame.size.height-70.0f))];
    [self.view addSubview:bezierLineDrawView];
        
    isPaintingPencil = NO;
    isPaintingMarker = NO;
    isErasing = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) resetView{
    isPaintingPencil = NO;
    isPaintingMarker = NO;
    isErasing = NO;
    
    markerButton.selected = NO;
    eraserButton.selected = NO;
    drawButton.selected = NO;
    
    [bezierLineDrawView setIsPainting:NO];
    [bezierLineDrawView setIsErasing:NO];
    [bezierLineDrawView setIsMarking:NO];
    
    [bezierLineDrawView clear];
}


- (IBAction)clearView:(id)sender{
    [self resetView];
}


- (IBAction)saveChanges:(id)sender{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Save image"
                                 message:@"Do you want to save the current image?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self saveImage];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];    
}

- (void) saveImage{
    barView.hidden = YES;
    
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, bezierLineDrawView.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    barView.hidden = NO;
    
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    if (error != NULL){
        // Error
    }else{
        // Image saved succesfully
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Good!"
                                     message:@"Image saved successfully"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        [self resetView];
                                    }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)paintInView:(id)sender{
    drawButton.selected = NO;
    markerButton.selected = NO;
    eraserButton.selected = NO;
    isErasing = NO;
    isPaintingMarker = NO;
    
    [bezierLineDrawView setIsErasing:NO];
    [bezierLineDrawView setIsMarking: NO];
    
    if(!isPaintingPencil){
        isPaintingPencil = YES;
        drawButton.selected = YES;
        [bezierLineDrawView setIsPainting:YES];
    }else{
        isPaintingPencil = NO;
        drawButton.selected = NO;
        [bezierLineDrawView setIsPainting:NO];
    }
}


- (IBAction)markerInView:(id)sender{
    markerButton.selected = NO;
    drawButton.selected = NO;
    eraserButton.selected = NO;
    isPaintingPencil = NO;
    isErasing = NO;
    
    [bezierLineDrawView setIsPainting:NO];
    [bezierLineDrawView setIsErasing:NO];
    
    if(!isPaintingMarker){
        isPaintingMarker = YES;
        markerButton.selected = YES;
        [bezierLineDrawView setIsMarking:YES];
    }else{
        isPaintingMarker = NO;
        markerButton.selected = NO;
        [bezierLineDrawView setIsMarking: NO];
    }
}

- (IBAction)eraserInView:(id)sender{
    eraserButton.selected = NO;
    markerButton.selected = NO;
    drawButton.selected = NO;
    isPaintingPencil = NO;
    isPaintingMarker = NO;
    
    [bezierLineDrawView setIsPainting:NO];
    [bezierLineDrawView setIsMarking: NO];
    
    if(!isErasing){
        isErasing = YES;
        eraserButton.selected = YES;
        [bezierLineDrawView setIsErasing:YES];
    }else{
        isErasing = NO;
        eraserButton.selected = NO;
        [bezierLineDrawView setIsErasing:NO];
    }
}

- (IBAction)selectColor:(id)sender{
    //[bezierLineDrawView setColor: [UIColor purpleColor]];
}

- (IBAction)selectSize:(id)sender{
    
}

@end

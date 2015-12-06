//
//  DQArrowView.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "DQArrowView.h"

static const CGFloat HEIGHTOFPOPUPTRIANGLE = 20.0f;
static const CGFloat WIDTHOFPOPUPTRIANGLE = 40.0f;
static const CGFloat borderRadius = 10.0f;
static const CGFloat strokeWidth = 2.0f;

@interface DQArrowView ()

@property (nonatomic) CGFloat positionArrow;

@end

@implementation DQArrowView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        _positionArrow = self.frame.size.width / 2.0f;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect currentFrame = self.bounds;
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, [[UIColor lightGrayColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    
    // Draw and fill the bubble
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, borderRadius + strokeWidth + 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f);
    
    CGContextAddLineToPoint(context, round(self.positionArrow - WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    
    CGContextAddLineToPoint(context, round(self.positionArrow) + 0.5f, strokeWidth + 0.5f);
    
    CGContextAddLineToPoint(context, round(self.positionArrow + WIDTHOFPOPUPTRIANGLE / 2.0f) + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f);
    
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, currentFrame.size.width - strokeWidth - 0.5f, currentFrame.size.height - strokeWidth - 0.5f, round(currentFrame.size.width / 2.0f + WIDTHOFPOPUPTRIANGLE / 2.0f) - strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, currentFrame.size.height - strokeWidth - 0.5f, strokeWidth + 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextAddArcToPoint(context, strokeWidth + 0.5f, strokeWidth + HEIGHTOFPOPUPTRIANGLE + 0.5f, currentFrame.size.width - strokeWidth - 0.5f, HEIGHTOFPOPUPTRIANGLE + strokeWidth + 0.5f, borderRadius - strokeWidth);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);


}

- (void)changePositionArrow:(CGFloat)position {
    self.positionArrow = position;
    [self setNeedsDisplay];
}

@end

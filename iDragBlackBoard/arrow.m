//
//  arrow.m
//  speed-view
//
//  Created by Max on 3/18/15.
//  Copyright (c) 2015 Max. All rights reserved.
//

#import "arrow.h"
#import <math.h>

@implementation arrow


-(void)setup{
    
    
    //[[UIImage imageNamed:@"speedBacground.png"] drawInRect:self.bounds];
   // self.contentMode =UIViewContentModeRedraw;
    
    // self.backgroundColor = [UIColor co ];
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
    //[self setup];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}




// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImage *img = [UIImage imageNamed:@"arrow.png"];
    [img drawInRect:self.bounds];
    
    
}


@end

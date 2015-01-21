//
//  MyCustomPin.m
//  runningCounter
//
//  Created by chiawei on 2015/1/21.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import "MyCustomPin.h"

@implementation MyCustomPin

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",reuseIdentifier]];
    
    NSLog(@"image:%@",image);
    
    self.frame = CGRectMake(25, 25, 10, 10);
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    [self addSubview:imageView];
    
    
    return self;
}


@end

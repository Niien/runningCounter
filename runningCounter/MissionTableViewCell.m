//
//  MissionTableViewCell.m
//  runningCounter
//
//  Created by ChingHua on 2015/1/24.
//  Copyright (c) 2015年 Longfatown. All rights reserved.
//

#import "MissionTableViewCell.h"

@implementation MissionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    float hight = 50 , wight = 50;
    
    CGRect timeLBFrame = CGRectMake(50 ,50, 50, 50);
    self.timeLabel.frame = timeLBFrame;
    [self addSubview:self.timeLabel];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end

//
//  AutoCell.h
//  A_TableView_AutoCell
//
//  Created by Zin_戦 on 17/1/9.
//  Copyright © 2017年 Zin_戦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelEntity.h"
@interface AutoCell : UITableViewCell

//返回cell的高度
//- (CGFloat)heightForCellWithModel:(ModelEntity *)model;
@property(nonatomic, strong) ModelEntity   *model;
@end

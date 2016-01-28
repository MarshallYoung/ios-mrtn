//
//  UITableView+Extension.m
//  yuchengapp
//
//  Created by Mac on 16/1/15.
//  Copyright © 2016年 YusysTechnologies. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

- (long)selectedIndexPathRow {
    
    NSIndexPath *path = self.indexPathForSelectedRow;
    if (path) {
        return (long)path.row;
    }
    return 0;
    
}


@end

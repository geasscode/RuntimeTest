//
//  TableViewDataSource.h
//  RuntimeTest
//
//  Created by desmond on 16/4/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "TCDataSource.h"

@interface TableViewDataSource : TCDataSource<
TCDataSourceable,
TCTableViewHeaderFooterViewibility,
TCTableViewEditable,
TCTableViewCollectionViewMovable
>


@end

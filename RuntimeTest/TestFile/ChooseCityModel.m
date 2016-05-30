//
//  ChooseCityModel.m
//  RuntimeTest
//
//  Created by desmond on 16/5/30.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "ChooseCityModel.h"

@implementation ChooseCityModel

+(NSMutableArray *)chooseCityDatas{
	
	return [ChooseCityModel mj_objectArrayWithFilename:@"city.plist"];
}


@end

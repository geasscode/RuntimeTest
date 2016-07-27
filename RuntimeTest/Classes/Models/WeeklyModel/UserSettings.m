//
//  UserSettings.m
//  RuntimeTest
//
//  Created by desmond on 16/7/25.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "UserSettings.h"

@implementation UserSettings



- (void)encodeWithCoder:(NSCoder *)aCoder {
	
	[aCoder encodeObject:self.name forKey:@"name"];
	
	[aCoder encodeObject:self.userDescription forKey:@"userDescription"];
	
	[aCoder encodeObject:self.gender forKey:@"gender"];
	
	[aCoder encodeObject:self.avatar_large forKey:@"avatar_large"];
	
	[aCoder encodeObject:@(self.id) forKey:@"id"];
	
	[aCoder encodeObject:@(self.hasLocalUser) forKey:@"hasLocalUser"];
	
	[aCoder encodeObject:self.password forKey:@"password"];
	
	[aCoder encodeObject:self.userID forKey:@"userID"];


	
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super init];
	
	if (self) {
		
		self.id = [[aDecoder decodeObjectForKey:@"id"] integerValue];
		
		self.name = [aDecoder decodeObjectForKey:@"name"];
		
		self.password = [aDecoder decodeObjectForKey:@"password"];

		
		self.userDescription = [aDecoder decodeObjectForKey:@"userDescription"];
		
		self.gender = [aDecoder decodeObjectForKey:@"gender"];
		
		self.avatar_large = [aDecoder decodeObjectForKey:@"avatar_large"];
		
		self.hasLocalUser = [[aDecoder decodeObjectForKey:@"hasLocalUser"] integerValue];
		
		self.userID = [aDecoder decodeObjectForKey:@"userID"];

	}
	return self;
}

@end

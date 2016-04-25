//
//  Photo.h
//  objc.io example project (issue #1)
//

#import <Foundation/Foundation.h>


@class MyUser;


@interface Photo : NSObject <NSCoding>

@property (nonatomic) int64_t identifier;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, strong) NSDate* creationDate;
@property (nonatomic) double rating;

@property (nonatomic, weak) MyUser* user;

- (NSString*)authorFullName;
- (double)adjustedRating;

@end

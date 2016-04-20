//
//  DynamicAddMethodViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/20.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DynamicAddMethodViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface DynamicAddMethodViewController ()

@property (weak, nonatomic) IBOutlet UITextField *address;
@property(nonatomic,strong)Person * person;

@end

@implementation DynamicAddMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.person  = [Person new];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dynamicAddMethod
{
  //Build Settings 中有一项 Undeclared Selector 设置为 NO。则下面的guess不会显示警告。debug的设为NO就行了。

	class_addMethod([self.person class], @selector(guess), (IMP)guessAnswer, "v@:");
	
	if ([self.person respondsToSelector:@selector(guess)]) {
		[self.person performSelector:@selector(guess)];
		
	} else{
		NSLog(@"Sorry,I don't know");
	}

	self.address.text = @"beijing";
}

void guessAnswer(id self,SEL _cmd){
	
	NSLog(@"i am from beijing");
	
}
- (IBAction)dynamicAddMethod:(id)sender {
	[self dynamicAddMethod];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

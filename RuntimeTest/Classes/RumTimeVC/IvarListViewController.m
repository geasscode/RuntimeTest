//
//  IvarListViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/20.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "IvarListViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface IvarListViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (nonatomic, strong) Person *person;
@end

@implementation IvarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.person = [Person new];
	_person.name = @"yongjie";
	NSLog(@"My first name is %@",self.person.name);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeName:(id)sender {
	
	[self newName];
}


- (void)newName
{
	unsigned int count = 0;
	Ivar *ivar = class_copyIvarList([self.person class], &count);
	for (int i = 0; i<count; i++) {
		Ivar var = ivar[i];
		const char *varName = ivar_getName(var);
		NSString *proname = [NSString stringWithUTF8String:varName];
		
		if ([proname isEqualToString:@"_name"]) {   //这里别忘了给属性加下划线
			object_setIvar(self.person, var, @"desmond");
			break;
		}
	}
	NSLog(@" change name  is %@",self.person.name);
	_textField.text = self.person.name;
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

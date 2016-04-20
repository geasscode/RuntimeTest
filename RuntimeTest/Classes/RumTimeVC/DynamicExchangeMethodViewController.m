//
//  DynamicExchangeMethodViewController.m
//  RuntimeTest
//
//  Created by desmond on 16/4/20.
//  Copyright © 2016年 geasscode. All rights reserved.
//

#import "DynamicExchangeMethodViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface DynamicExchangeMethodViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textView;
@property (strong,nonatomic) Person *person;

@end

@implementation DynamicExchangeMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	_person = [Person new];
	NSLog(@"交换前的姓名为:%@",_person.sayName);
	NSLog(@"交换后的性别%@",_person.saySex);
	
	//忍法：心转心之术
	Method m1 = class_getInstanceMethod([self.person class], @selector(sayName));
	Method m2 = class_getInstanceMethod([self.person class], @selector(saySex));
	method_exchangeImplementations(m1, m2);
	
    // Do any additional setup after loading the view.
}
- (IBAction)sayName:(id)sender {
	_textView.text = [_person sayName];
	
	NSLog(@"交换后的姓名变为:%@",_person.sayName);

}

- (IBAction)saySex:(id)sender {
	_textView.text = [_person saySex];
	NSLog(@"交换后的性别变为:%@",_person.sayName);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

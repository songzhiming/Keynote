//
//  ViewController.m
//  CrashDemo
//
//  Created by 宋志明 on 16/9/5.
//  Copyright © 2016年 宋志明. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"test"];
//    [self.view addSubview:imageView];
    id classObject = objc_getClass([@"UITableView" UTF8String]);
    unsigned int count ;
    
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList(classObject, &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //获取方法列表
    Method *methodList = class_copyMethodList(classObject, &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList(classObject, &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(classObject, &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onclickButton:(UIButton *)sender {
    SecondViewController *vc = [[SecondViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end

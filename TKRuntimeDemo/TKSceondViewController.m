//
//  TKSceondViewController.m
//  TKRuntimeDemo
//
//  Created by hp on 15/8/11.
//  Copyright (c) 2015年 hxp. All rights reserved.
//

#import "TKSceondViewController.h"
#import <objc/runtime.h>

float myFloat = 0.0f;

@interface TKSceondViewController ()

@end

@implementation TKSceondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self arrayInit];
    [self setupPopButton];
    
    [self testRT];
}

-(void)arrayInit
{
    ivarArray = [[NSMutableArray alloc] init];
    propertyArray = [[NSMutableArray alloc] init];
}

-(void)setupPopButton
{
    if (!_popButton) {
        self.popButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 100.0f, 50.0f, 20.0f)];
        [_popButton setTitle:@"prev" forState:UIControlStateNormal];
        [_popButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_popButton addTarget:self action:@selector(popButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_popButton];
    }
}

-(void)testRT
{
    Class nav = object_getClass(self);
    const char * className = class_getName(nav);
    
    unsigned int ivarCount;
    Ivar *tempIvar = class_copyIvarList(nav, &ivarCount);
    for (int i = 0; i < ivarCount; i ++) {
        const char *ivarName = ivar_getName(tempIvar[i]);
        [ivarArray addObject:[NSString stringWithUTF8String:ivarName]];
    }
    
    unsigned int proCount;
    objc_property_t *tempPro = class_copyPropertyList(nav, &proCount);
    for (int i = 0; i < proCount; i ++) {
        const char *propertyName = property_getName(tempPro[i]);
        [propertyArray addObject:[NSString stringWithUTF8String:propertyName]];
    }
    
    unsigned int methodCount;
    Method *tempMeth = class_copyMethodList(nav, &methodCount);
    for (int i = 0; i < methodCount; i ++) {
        SEL methName = method_getName(tempMeth[i]);
        NSLog(@"%s", sel_getName(methName));
    }
    
//    arc下这个方法不能用
//    NSArray *tempArray;
//    object_getInstanceVariable(self, "myFloat", (void*)&tempArray);
//    NSLog(@"%@", myFloatValue);
    
    Ivar ivarOb = class_getInstanceVariable([self class], "ivarArray");
    const char* ivarName = ivar_getName(ivarOb);
    const char* ivarType = ivar_getTypeEncoding(ivarOb);
    NSLog(@"ivarname = %s, ivarType = %s", ivarName, ivarType);
    
    id ob = object_getIvar(self, ivarOb);
    NSLog(@"ob = %@", ob);
    
    
    Method m1 = class_getInstanceMethod([self class], @selector(replaceMethod:));
    class_replaceMethod([self class], @selector(demoReplaceMethod:), method_getImplementation(m1), NULL);
    
    [self replaceMethod:@"hello world"];
    [self demoReplaceMethod:@"world heool"];
    
    SEL sel = @selector(methodByAddForStr);
    class_addMethod([self class], sel ,class_getMethodImplementation([self class], @selector(methodByAdd)), NULL);
    
    [self performSelector:sel];
    
    static char *assKey;
    NSString *strName = [NSString stringWithUTF8String:object_getClassName(self)];
    objc_setAssociatedObject(self, assKey, strName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    
    id assOb = objc_getAssociatedObject(self, assKey);
    NSLog(@"assob = %@", assOb);
    
    objc_setAssociatedObject(self, assKey, nil, OBJC_ASSOCIATION_ASSIGN);
    id assOb1 = objc_getAssociatedObject(self, assKey);
    NSLog(@"assob = %@", assOb1);
    
}

-(void)replaceMethod:(NSString *)str1
{
    NSLog(@"this is replaceMethod %@", str1);
}

-(void)demoReplaceMethod:(NSString *)str1
{
    NSLog(@"this is demoReplaceMethod %@", str1);
}

-(void)methodByAdd
{
    NSLog(@"this is methodByAdd ");
}

-(void)popButtonClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

// 添加一个观察者，用来观察通知
// 第一个参数为self,表示将self设为观察者来观察通知
// 第二个参数@selector(setData:)表示收到符合条件的通知后要执行方法setData:
// 第三个参数kNotificationMessage为指定的要观察的通知的名称
// 第四个参数为nil，表示任何对象发过来的通知都可以被观察到
[[NSNotificationCenter defaultCenter] removeObserver:self];
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doSomething:) name:@"test1" object:nil];
// 发送一个通知
// 第一个参数表示发出的通知的名称
// 第二个参数表示谁发出的通知
// 第三个参数表示通知所带的信息(NSDictionary)
[[NSNotificationCenter defaultCenter] postNotificationName:@"test1" object:self userInfo:dic];
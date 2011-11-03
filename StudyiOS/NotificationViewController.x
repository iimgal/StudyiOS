<span class = "green">// 添加一个观察者，用来观察通知</span>
<span class = "green">// 第一个参数为self,表示将self设为观察者来观察通知，</span>
<span class = "green">// 第二个参数@selector(setData:)表示收到符合条件的通知后要执行方法setData:</span>
<span class = "green">// 第三个参数kNotificationMessage为指定的要观察的通知的名称</span>
<span class = "green">// 第四个参数为nil，表示任何对象发过来的通知都可以被观察到</span>
[[<span class = "purple">NSNotificationCenter defaultCenter</span>] <span class = "purple">removeObserver</span>:<span class = "magenta">self</span>];
[[<span class = "purple">NSNotificationCenter defaultCenter</span>] <span class = "purple">addObserver</span>:<span class = "magenta">self</span> <span class = "purple">selector</span>:<span class = "magenta">@selector</span>(doSomething:) <span class = "purple">name</span>:<span class = "red">@"test1"</span> <span class = "purple">object</span>:<span class = "magenta">nil</span>];
<span class = "green">// 发送一个通知</span>
<span class = "green">// 第一个参数表示发出的通知的名称</span>
<span class = "green">// 第二个参数表示谁发出的通知</span>
<span class = "green">// 第三个参数表示通知所带的信息(NSDictionary)</span>
[[<span class = "purple">NSNotificationCenter defaultCenter</span>] <span class = "purple">postNotificationName</span>:<span class = "red">@"test1"</span> <span class = "purple">object</span>:<span class = "magenta">self</span> <span class = "purple">userInfo</span>:dic];
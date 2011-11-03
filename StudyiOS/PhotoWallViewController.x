<span class = "brown">#import</span> <span class = "red">"Three20/Three20.h"</span>
<span class = "brown">#import</span> <span class = "red">"MockPhotoSource.h"</span>
<span class = "green">// 需继承TTThumbsViewController</span>
<span class = "green">// 添加数据源</span>
<span class = "magenta">self</span>.<span class = "cyan">photoSource</span>= [[<span class = "cyan">MockPhotoSource</span> <span class = "purple">alloc</span>]
    <span class = "cyan">initWithType:MockPhotoSourceNormal</span>
    <span class = "cyan">title</span>:<span class = "red">@"Flickr Photos"</span>
    <span class = "cyan">photos</span>:[<span class = "purple">[NSArray alloc] initWithObjects</span>:
        [[<span class = "cyan">MockPhoto</span> <span class = "purple">alloc</span>]
        <span class = "cyan">initWithURL</span>:<span class = "red">@"http://flickr.com/1.jpg"</span>
        <span class = "cyan">smallURL</span>:<span class = "red">@"http://flickr.com/1.jpg"</span>
        <span class = "cyan">size</span>:<span class = "purple">CGSizeMake(960, 1280)</span>],
    <span class = "magenta">nil</span>];
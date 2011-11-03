<span class = "green">// 需实现UIImagePickerControllerDelegate委托</span>

<span class = "green">// 打开摄像头还是图片库</span>
<span class = "purple">UIImagePickerController</span> *picker = [<span class = "purple">[UIImagePickerController alloc] init</span>];
picker.<span class = "purple">sourceType</span> = <span class = "purple">UIImagePickerControllerSourceTypeCamera</span>;
picker.<span class = "purple">sourceType</span> = <span class = "purple">UIImagePickerControllerSourceTypePhotoLibrary</span>;

<span class = "green">// 选取照片或拍照后会触发以下方法</span>
- (<span class = "magenta">void</span>)imagePickerController:(<span class = "purple">UIImagePickerController</span> *)picker 
didFinishPickingMediaWithInfo:(<span class = "purple">NSDictionary</span> *)info {
    <span class = "green">// 得到图片</span>
    <span class = "purple">UIImage</span>*image = [info <span class = "purple">objectForKey:UIImagePickerControllerEditedImage</span>]; 
    <span class = "green">// 获得照片详细信息</span>
    <span class = "purple">NSDictionary</span>*media = [info <span class = "purple">objectForKey:UIImagePickerControllerMediaMetadata</span>];
}
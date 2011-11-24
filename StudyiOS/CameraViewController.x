// 需实现UIImagePickerControllerDelegate委托

// 打开摄像头还是图片库
UIImagePickerController *picker = [[UIImagePickerController alloc] init];
picker.sourceType = UIImagePickerControllerSourceTypeCamera;
picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

// 选取照片或拍照后会触发以下方法
- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage]; 
    // 获得照片详细信息
    NSDictionary *media = [info objectForKey:UIImagePickerControllerMediaMetadata];
}
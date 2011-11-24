#import "IIReflectionImage.h"

// 设置映射比例
NSUInteger height = self.imageView.bounds.size.height * 1.0;
// 得到映射图片
self.reflectView.image = 
    [IIReflectionImage reflectedImage:self.imageView withHeight:height];
    
// 设置边框得圆弧度
self.roundView.layer.cornerRadius = 10; 
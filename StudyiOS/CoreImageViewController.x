#import <CoreImage/CoreImage.h>

    // 得到图片路径创建CIImage对象
    CIImage *beginImage = [CIImage imageWithContentsOfURL:url];
    // 创建基于GPU的CIContext对象
    context = [CIContext contextWithOptions: nil];
    // 创建过滤器
    filter = [CIFilter filterWithName:@"CISepiaTone"];
    // 设置过滤器参数
    [filter setValue:beginImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:0.5] forKey:@"inputIntensity"];
    // 得到过滤后的图片
    CIImage *outputImage = [filter outputImage];
    // 转换图片
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
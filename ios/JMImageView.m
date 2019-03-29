//
//  JMimageView.m
//  RNJMaxBrowser
//
//  Created by jimi01 on 2019/3/29.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "JMImageView.h"

@implementation JMImageView
-(instancetype)initWithImage:(UIImage *)image{
    if (self = [super initWithImage:image]) {
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
-(void)configNetworkImageWithUrl:(NSString *)urlStr defaultImage:(UIImage *)defaultImage{
    self.image = defaultImage;
    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
    dispatch_async(globalQueue, ^{
        //NSString -> NSURL -> NSData -> UIImage
        NSString *imageStr = urlStr;
        NSURL *imageURL = [NSURL URLWithString:imageStr];
        //下载图片
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        //组合：主队列异步执行
        dispatch_async(dispatch_get_main_queue(), ^{
            //更新界面
            self.image = image;
        });
    });
}

@end
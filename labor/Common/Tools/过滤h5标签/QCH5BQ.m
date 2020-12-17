//
//  QCH5BQ.m
//  labor
//
//  Created by 狍子 on 2020/11/27.
//  Copyright © 2020 ZKWQY. All rights reserved.
//

#import "QCH5BQ.h"

@implementation QCH5BQ
+(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
//    NSString * regEx = @"<([^>]*)>";
//    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}
@end

//
//  DYHeroModel.h
//  点击cell查看大图
//
//  Created by xudingyang on 16/8/21.
//  Copyright © 2016年 xudingyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYHeroModel : NSObject

/** icon 英雄头像 */
@property (copy, nonatomic) NSString *icon;
/** intro 台词 */
@property (copy, nonatomic) NSString *intro;
/** name 姓名 */
@property (copy, nonatomic) NSString *name;

+ (instancetype)heroModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end

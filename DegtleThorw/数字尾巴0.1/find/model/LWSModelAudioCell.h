//
//  LWSModelAudioCell.h
//  数字尾巴0.1
//
//  Created by dllo on 16/3/12.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LWSBasicModel.h"

@interface LWSModelAudioCell : LWSBasicModel

@property (nonatomic , copy)NSString *sid;
@property (nonatomic , copy)NSString *title;

/**获得的key值：description需要重写set value for key */
@property (nonatomic , copy)NSString *summary;

@property (nonatomic , copy)NSString *cover;
@property (nonatomic , copy)NSString *mp4_url;
@property (nonatomic , copy)NSString *ptime;
/**不知道获取到的属性，现以nsnumber接受 */
@property (nonatomic , retain)NSNumber *playCount;

@end

//
//  UserInfoModel.m
//  BeikoCube
//
//  Created by Qingyang Xu on 2018/8/14.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

//将对象编码(即:序列化)
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_email forKey:@"email"];
    [aCoder encodeObject:_phone forKey:@"phone"];
    [aCoder encodeObject:_userName forKey:@"userName"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_status forKey:@"status"];
    [aCoder encodeObject:_token forKey:@"token"];
     [aCoder encodeObject:_str1 forKey:@"str1"];
     [aCoder encodeObject:_str2 forKey:@"str2"];
     [aCoder encodeObject:_str3 forKey:@"str3"];
    [aCoder encodeObject:_str4 forKey:@"str4"];
    [aCoder encodeObject:_str5 forKey:@"str5"];
    [aCoder encodeObject:_str6 forKey:@"str6"];
    [aCoder encodeObject:_isTrueName forKey:@"isTrueName"];
    [aCoder encodeObject:_isOperator forKey:@"isOperator"];
    [aCoder encodeObject:_isCard forKey:@"isCard"];
    [aCoder encodeObject:_isRelation forKey:@"isRelation"];
}

//将对象解码(反序列化)
-(id) initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init])
    {
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.str1 = [aDecoder decodeObjectForKey:@"str1"];
        self.str2 = [aDecoder decodeObjectForKey:@"str2"];
        self.str3 = [aDecoder decodeObjectForKey:@"str3"];
        self.str4 = [aDecoder decodeObjectForKey:@"str4"];
        self.str5 = [aDecoder decodeObjectForKey:@"str5"];
        self.str6 = [aDecoder decodeObjectForKey:@"str6"];
        self.isTrueName = [aDecoder decodeObjectForKey:@"isTrueName"];
        self.isOperator = [aDecoder decodeObjectForKey:@"isOperator"];
        self.isCard = [aDecoder decodeObjectForKey:@"isCard"];
        self.isRelation = [aDecoder decodeObjectForKey:@"isRelation"];
    }
    
    return (self);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

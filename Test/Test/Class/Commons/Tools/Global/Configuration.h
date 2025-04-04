//
//  Configuration.h
//  TestDemo
//
//  Created by 孙若淮 on 14/03/2018.
//  Copyright © 2018 Monster. All rights reserved.
//

#ifndef Configuration_h
#define Configuration_h

#endif /* Configuration_h */
//IM 相关
#define KNOTIFICATION_onConnected_Success       @"IM_onConnected_success" //连接成功
#define KNOTIFICATION_onConnected_Connecting    @"IM_onConnected_Connecting" //正在连接
#define KNOTIFICATION_onConnected_Failed        @"IM_onConnected_Failed" //连接失败
#define KNOTIFICATION_ReceiveMessage            @"IM_ReceiveMessage" //接收到IM消息


#define KEY_TOKEN               @"token"//登录时返回的token
#define KEY_USER_DATA           @"user_data"//用户信息
#define KEY_USER_TYPE           @"user_type"//0求职 1企业

#define JUDGE_NUll(obj)       (obj == nil || [obj isMemberOfClass:[NSNull class]]) ? @"" : obj
#define JUDGE_NUll_DEF(obj,default)       (obj == nil || [obj isMemberOfClass:[NSNull class]]) ? default : obj
#define NSStringFromInteger(value)      [NSString stringWithFormat:@"%ld",(long)value]

#define DefaultsSetObject(value,key)  [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define DefaultsGetObject(key)        [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define DefaultsSetInteger(value,key) [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key]
#define DefaultsGetInteger(key)       [[NSUserDefaults standardUserDefaults] integerForKey:key]
#define DefaultsSetBool(value,key)    [[NSUserDefaults standardUserDefaults]setBool:value forKey:key]
#define DefaultsGetBool(key)          [[NSUserDefaults standardUserDefaults] boolForKey:key]


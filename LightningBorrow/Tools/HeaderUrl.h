//
//  HeaderUrl.h
//  CookBook
//
//  Created by Qingyang Xu on 2018/8/24.
//  Copyright © 2018年 puxu. All rights reserved.
//

#ifndef HeaderUrl_h
#define HeaderUrl_h

//#define Base_URL                          @"http://test.jienihua100.com/api"

#define Base_URL                          @"http://shxd.jienihua100.com/api"

//登录接口
#define LoginUrl                          @"/user/register"
//注册接口
#define RegistUrl                         @""
//卡列表
#define CardList                          @"/cardm/index"
//卡列表
#define CreditCardList                    @"/cardm/cardlimit"
//产品列表
#define ProductList                       @"/pro/index"
//产品详情
#define ProductDetail                     @"/product/details"
//消息列表
#define MessageList                       @"/push/message"
//删除消息
#define DeleMessageList                   @"/push/mesdel"
//设置消息是否读
#define SetMessageRead                    @"/push/mesonof"
//删除未读消息
#define DeleNoReadMes                     @"/push/mesdelall"
//点击卡
#define ClickCard                         @"/cardm/statis"
//渠道开关
#define SwitchChannel                     @"/shuing/pformchannel"
//平台开关
#define SwitchPform                       @"/shuing/pformswitch"
//分类列表
#define TypeList                          @"/shuing/menulist"
//申请
#define ApplyList                         @"/user/apption"
//获取验证码
#define GetCode                           @"/user/getcode"
//关于我们
#define AboutUS                           @"/news/home"
//点击卡
#define ClickCard                         @"/cardm/statis"

#endif /* HeaderUrl_h */

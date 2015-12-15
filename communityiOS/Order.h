//
//  Order.h
//  AlixPayDemo
//
//  Created by 方彬 on 11/2/13.
//
//

#import <Foundation/Foundation.h>

@interface Order : NSObject

@property(nonatomic, copy) NSString * partner;//注册支付宝的商家 wangyao
@property(nonatomic, copy) NSString * seller;//转给谁钱
@property(nonatomic, copy) NSString * tradeNO;//交易唯一编号
@property(nonatomic, copy) NSString * productName;//商品名称
@property(nonatomic, copy) NSString * productDescription;//商品描述
@property(nonatomic, copy) NSString * amount;//总花费
@property(nonatomic, copy) NSString * notifyURL;//ali通知服务器的地址

@property(nonatomic, copy) NSString * service;
@property(nonatomic, copy) NSString * paymentType;
@property(nonatomic, copy) NSString * inputCharset;
@property(nonatomic, copy) NSString * itBPay;
@property(nonatomic, copy) NSString * showUrl;


@property(nonatomic, copy) NSString * rsaDate;//可选
@property(nonatomic, copy) NSString * appID;//可选

@property(nonatomic, readonly) NSMutableDictionary * extraParams;


@end

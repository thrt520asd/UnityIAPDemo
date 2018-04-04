//
//  IAPHelper.h
//  iaptest
//
//  Created by xq on 2018/4/2.
//  Copyright © 2018年 xq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
@interface IAPHelper : NSObject<SKProductsRequestDelegate , SKPaymentTransactionObserver>{
    SKProductsRequest *request;
    SKProduct *product;
    NSString *mCallBackObjectName;
}
-(BOOL)canBuy;
-(void)purchase:(NSString*)productId :(NSString*)callBackObjectName;
-(void)checkPayInventory;
-(void)completeTransactionByIdentifier:(NSString*) transactionIdentifier;
@end

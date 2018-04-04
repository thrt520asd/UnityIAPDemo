//
//  IAPHelper.m
//  iaptest
//
//  Created by xq on 2018/4/2.
//  Copyright © 2018年 xq. All rights reserved.
//

#import "IAPHelper.h"

@implementation IAPHelper{
}

-(BOOL) canBuy{
    return [SKPaymentQueue canMakePayments];
}

-(void) purchase:(NSString *)productId :(NSString*)callBackObjectName
{
    mCallBackObjectName = callBackObjectName;
    [self requestProductData:productId];
}

-(void) requestProductData:(NSString*) productId
{
    NSSet *set = [NSSet setWithObject:productId];
    request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self ;
    [request start];
}

-(void)checkPayInventory{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

-(void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    if(response.products.count > 0){
//        NSLog(@"有效id%ul" , response.products.count);
        SKPayment *payment = [SKPayment paymentWithProduct:response.products[0]];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }else{
        NSLog(@"无效id%@",response.invalidProductIdentifiers [0]);
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(nonnull NSArray<SKPaymentTransaction *> *)transactions
{
    for(SKPaymentTransaction *tran in transactions){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:tran];
                NSLog(@"交易完成");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"正在交易");
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已购买过");
                break;
            default:
                NSLog(@"Unexpected transaction state %@" , @(tran.transactionState));
                break;
        }
    }
}

///向服务器确认receipt数据
-(void)verifyPurchaseWithPaymentTransaction:(SKPaymentTransaction*) transaction{
    NSString *content = [NSString stringWithFormat:@"%@:%@" , transaction.transactionReceipt , transaction.transactionIdentifier];
    NSString *name = mCallBackObjectName ;
    UnitySendMessage(name.UTF8String, "verifyPruchase", content.UTF8String);
    NSLog(@"向服务器确认凭证");
}

//移除完成订单
-(void)completeTransactionByIdentifier:(NSString*) transactionIdentifier{
    NSArray<SKPaymentTransaction*>* transactions = [[SKPaymentQueue defaultQueue] transactions];
    for (SKPaymentTransaction *transaction in  transactions) {
        BOOL result = [transaction.transactionIdentifier compare:transactionIdentifier];
        if(result){
            [self completeTransaction:transaction];
        }
    }
}

-(void) completeTransaction:(SKPaymentTransaction*)transaction{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    NSLog(@"移除完成订单");
}

-(void) dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end

#import "IAPHelper.h"
#if defined(__cplusplus)
extern "C"{
#endif
    bool CanPurchase(){
        return [SKPaymentQueue canMakePayments];
    }
    IAPHelper *iapHelper = nil ;
    void Purchase(char* productId , char*callBackObjectName){
        if(!iapHelper){
            iapHelper = [[IAPHelper alloc]init];
        }
        [iapHelper purchase:[NSString stringWithUTF8String:productId] :[NSString stringWithUTF8String:callBackObjectName]];
    }
    
    void CheckPayInventory(){
        if(!iapHelper){
            iapHelper = [[IAPHelper alloc]init];
        }
        [iapHelper checkPayInventory];
    }

    void CompleteTransactionByIdentifier(char* transactionIndentifier){
        if(!iapHelper){
            iapHelper = [[IAPHelper alloc]init];
        }
        [iapHelper completeTransactionByIdentifier : [NSString stringWithUTF8String:transactionIndentifier]];
    }
#if defined(__cplusplus)
}
#endif

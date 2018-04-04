# UnityIAPDemo
Unity接入AppStore内购Demo ，服务器验证为自己模拟
### 流程图
``` flow 
st=>start: productId
suc=>end
fail=>end: failed
productData=>operation: GetProductData
addToSkPayMent=>operation: AddToSKPayMentQueue
updateTransactions=>operation: UpdateTransactions
productValid=>condition: ProductIDValid?
transactionState=>condition: TransactionState
AssertReveiptWithServer=>condition: AssertReveiptWithServer
RemoveFinishTransaction=>operation: RemoveFinishTransaction
Success=>operation: Success

st->productData->productValid
productValid(yes)->addToSkPayMent->updateTransactions->transactionState
productValid(no)->fail
transactionState(yes)->AssertReveiptWithServer
transactionState(no)->fail
AssertReveiptWithServer(yes)->RemoveFinishTransaction->Success
AssertReveiptWithServer(no)->fail
```
### 继承接口
>>SKProductsRequestDelegate 
>>SKPaymentTransactionObserver 
### 注意
添加StoreKit库
包名一致
财务信息完整
防止丢单
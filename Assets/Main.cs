using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Main : MonoBehaviour {
	void Start(){
		#if UNITY_IOS
		IOSBridge.CheckPayInventory();
		#endif
	}


	string itemId = "";
	// Use this for initialization
	void OnGUI(){
		if(GUI.Button(new Rect(0, 0 , 200 , 60) , "buy")){
			Debug.Log("purchse item") ;
			//  AppPayTools.BuyItem(itemId) ;
			// AppPayTools._test("asdfasdf") ;
			if(IOSBridge.CanPurchase()){
				IOSBridge.Purchase("item_test_01" , this.name);
			}else{
				Debug.Log("can purchase");
			}
		}
	}
	
	void verifyPruchase(string str){
		///模拟校验支付凭证
		string[] strs = str.Split(':');
		string receipt = strs[0];
		string inden = strs[1];
		IOSBridge.CompleteTransactionByIdentifier(inden);
	}
	
	
}

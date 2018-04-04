using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;
public class IOSBridge  {
	[DllImport("__Internal")]
	public static extern bool CanPurchase();
	
	[DllImport("__Internal")]
	public static extern void Purchase(string productId , string callBackObjName);

	[DllImport("__Internal")]
	public static extern void CheckPayInventory();

	[DllImport("__Internal")]
	public static extern void CompleteTransactionByIdentifier(string transactionIndentifier);

}

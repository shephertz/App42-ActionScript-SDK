package com.shephertz.app42.paas.sdk.as3.storage
{
	import com.shephertz.app42.paas.sdk.as3.App42Exception;
	import com.shephertz.app42.paas.sdk.as3.util.Util;
	
	public class QueryBuilder
	{
		public static function build( key:String,  value:Object , op:String):Query {
			var jsonArray:Array = new Array();
			var query:Query = null;
			try {
				if(value is Date){
					var date:Date  = value as Date;
					var dateValue:String = Util.getUTCFormattedTimestampWithUserInputDate(date);
					value = dateValue;
				}
				var jsonObj:Object  = new Object;
				jsonObj.key =  key;
				jsonObj.value = value;
				jsonObj.operator=  op;
				jsonArray.push(jsonObj);
				query = new Query(jsonArray);
				
			} catch (ex:Error) {
				new App42Exception(ex+"",0,0);
			}
			return query;
			
		}
		
		
		/**
		 * @param op
		 * @return
		 */
		public static function compoundOperator(q1:Query , op:String, q2:Query):Query  {
			var jsonArrayInQuery:Array = new Array;
			var jsonArray:Array = new Array;
			var object:Object = new Object();
			object.compoundOpt = op;
			var query:Query = new Query(jsonArrayInQuery);
			try {
				if (q1.getType() is Array){
					jsonArrayInQuery.push(q1.getType()[0]);
				}
				
				jsonArrayInQuery.push(object);
				
				if (q2.getType() is Array){
					jsonArrayInQuery.push(q2.getType()[0]);
				}
			}
			catch (ex:Error) {
				throw new App42Exception(ex+"",0,0);
			}
			return query;
		}
	}	
}
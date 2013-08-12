package com.shephertz.app42.paas.sdk.as3.storage
{
	import com.hurlant.util.der.Integer;
	
	public class GeoTag
	{
		private var lat:Integer;
		private var lng:Integer
		
		
		public function GeoTag(lat:Integer, lng:Integer) {
			this.lat = lat;
			this.lng = lng;
			
		}
		
		/**
		 * Sets the lat point for Geo.
		 * 
		 * @param lat
		 *            - lat point for Geo.
		 * 
		 */
		public function setLat(lat:Integer):void {
			this.lat = lat;
			
		}
		
		/**
		 * Returns the lat point for Geo.
		 * 
		 * @return the lat point for Geo.
		 */
		public function getLat():Integer {
			return lat;
		}
		
		/**
		 * Sets the lng point for Geo.
		 * 
		 * @param lng
		 *            - lng point for Geo.
		 * 
		 */
		public function setLng(lng:Integer):void {
			this.lng = lng;
			
		}
		
		/**
		 * Returns the lng point for Geo.
		 * 
		 * @return the lng point for Geo.
		 */
		public function getLng():Integer {
			return lng;
		}
		
		/**
		 * Values coming from response are converted into JSON format.
		 * @return JSON Response
		 * @throws JSONException
		 */
		
		public function getJSONObject():Object {
			var obj:Object = new Object;
			
			obj.lat = this.lat;
			obj.lng = this.lng;
			
			return obj;
		}
	}
}
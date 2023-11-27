
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   ______   _____    ______    //
	// /\  ___\ /\  == \ /\  ___\ /\  __-. /\  ___\   //
	// \ \ \____\ \  __< \ \  __\ \ \ \/\ \\ \___  \  //
	//  \ \_____\\ \_\ \_\\ \_____\\ \____- \/\_____\ //
	//   \/_____/ \/_/ /_/ \/_____/ \/____/  \/_____/ //
	//                                                //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	function PlayerCredentials() constructor {
		
		// public
		static initialize  = function() {};
		static cleanup	   = function() {};
		static serialize   = function() {};
		static deserialize = function() {};
		
		// private
		__ = {};
		with (__) {
			username	   = "";
			password	   = "";
			email		   = "";
			steam_username = "";
		};
		
	};
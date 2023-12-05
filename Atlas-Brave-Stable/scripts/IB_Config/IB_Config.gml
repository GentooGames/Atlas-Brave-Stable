
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __   ______  __   ______    //
	// /\  ___\ /\  __ \ /\ "-.\ \ /\  ___\/\ \ /\  ___\   //
	// \ \ \____\ \ \/\ \\ \ \-.  \\ \  __\\ \ \\ \ \__ \  //
	//  \ \_____\\ \_____\\ \_\\"\_\\ \_\   \ \_\\ \_____\ //
	//   \/_____/ \/_____/ \/_/ \/_/ \/_/    \/_/ \/_____/ //
	//                                                     //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	enum IB_LOG_FLAG {
		NONE		 = 1 << 0,
		ALL			 = 1 << 1,
		INSTANCES	 = 1 << 2,
		OBJECTS		 = 1 << 3,
		CONSTRUCTORS = 1 << 4,
		INPUT		 = 1 << 5,
		STATE		 = 1 << 6,
		GAME		 = 1 << 7,
		CAMERA		 = 1 << 8,
		PLAYER		 = 1 << 9,
		RADIO		 = 1 << 10,
		CHARACTER	 = 1 << 11,
	};
	
	global.iceberg_config = {
		meta:	{
			version: "0.4.0",
			// move this out of here
		},
		log:	{
			level: IB_LOG_FLAG.ALL,
		},
		player: {
			max_count: 4,
		},
	};

	#macro iceberg		obj_iceberg
	#macro IB_CONFIG	global.iceberg_config
	#macro IB_LOG_LEVEL IB_CONFIG.log.level
	
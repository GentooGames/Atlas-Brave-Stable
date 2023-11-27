
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   ______   __   __ ______   ______    //
	// /\  ___\ /\  __ \ /\ \ / //\  ___\ /\  == \   //
	// \ \___  \\ \  __ \\ \ \'/ \ \  __\ \ \  __<   //
	//  \/\_____\\ \_\ \_\\ \__|  \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_/\/_/ \/_/    \/_____/ \/_/ /_/ //
	//                                               //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	enum IB_DATA_PACK_FLAG {
		NONE	 = 1 << 1,
		ENCODE   = 2 << 1,
		COMPRESS = 3 << 1,
	};
	
	function IB_AsyncSaver(_config = {}) constructor {
		
		// public
		static request			   = function(_buffer, _filename, _on_success = undefined, _on_fail = undefined) {
			
			_filename  = __generate_path(_filename);
			__.running = true;
			
			// store callbacks
			__.on_success = _on_success;
			__.on_fail	  = _on_fail;
			
			// do async saving
			var _size	  = buffer_get_size(_buffer);
			__.request_id = buffer_save_async(_buffer, _filename, 0, _size);
			
			return __.request_id;
		};
		static response			   = function(_async_load) {
			if (_async_load[? "id"] == __.request_id) {
				
				__.response_data   = _async_load;
				__.response_status = _async_load[? "status"];
				__.running		   =  false;
				
				switch (__.response_status) {
					case true:	__on_success(); break;
					case false: __on_fail();	break;
				};
			}
		};
		static pack_data		   = function(_struct, _pack_flags = IB_DATA_PACK_FLAG.ENCODE & IB_DATA_PACK_FLAG.COMPRESS) {
			var _data_string = json_stringify(_struct);
			var _buffer		 = iceberg.buffer.from_string(_data_string);
			
			// encode buffer?
			if (_pack_flags & IB_DATA_PACK_FLAG.ENCODE) {
				_buffer = iceberg.buffer.encode(_buffer);
			}
			
			// compress buffer?
			if (_pack_flags & IB_DATA_PACK_FLAG.COMPRESS) {
				_buffer = iceberg.buffer.compress(_buffer);
			}
			
			return _buffer;
		};
		static get_request_id	   = function() {
			return __.request_id;
		};
		static get_response_data   = function() {
			return __.response_data;	
		};
		static get_response_status = function() {
			return __.response_status
		};
		static get_running		   = function() {
			return __.running;	
		};
		
		// private
		__ = {};
		with (__) {
			static __generate_path = function(_filename) {
				return __.file_path + _filename + __.file_type;
			};
			static __on_success    = function() {
				if (__.on_success != undefined) {
					__.on_success();	
				}
			};
			static __on_fail	   = function() {
				if (__.on_fail != undefined) {
					__.on_fail();	
				}
			};
			
			file_path		= _config[$ "file_path"] ?? "";
			file_type		= _config[$ "file_type"] ?? ".buf";
			running			=  false;
			request_id		=  undefined;	
			response_data	=  undefined;
			response_status =  undefined;
			on_success		=  undefined;
			on_fail			=  undefined;
		};
	};
	
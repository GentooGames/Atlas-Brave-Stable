
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __       ______   ______   _____    ______   ______    //
	// /\ \     /\  __ \ /\  __ \ /\  __-. /\  ___\ /\  == \   //
	// \ \ \____\ \ \/\ \\ \  __ \\ \ \/\ \\ \  __\ \ \  __<   //
	//  \ \_____\\ \_____\\ \_\ \_\\ \____- \ \_____\\ \_\ \_\ //
	//   \/_____/ \/_____/ \/_/\/_/ \/____/  \/_____/ \/_/ /_/ //
	//                                                         //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	enum IB_DATA_UNPACK_FLAG {
		NONE	   = 1 << 1,
		DECODE     = 2 << 1,
		DECOMPRESS = 3 << 1,
	};
	
	function IB_AsyncLoader(_config = {}) constructor {
		
		// public
		static request			   = function(_filename = "", _on_success = undefined, _on_fail = undefined) {
			
			_filename  = __generate_path(_filename);
			__.running = true;
			
			// store callbacks
			__.on_success = _on_success;
			__.on_fail	  = _on_fail;
			
			// do async loading
			buffer_resize(__.load_buffer, 1);
			buffer_seek  (__.load_buffer, buffer_seek_start, 0);
			__.request_id = buffer_load_async(__.load_buffer, _filename, 0, -1);
			
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
		static get_buffer		   = function(_unpack_flags = IB_DATA_UNPACK_FLAG.DECODE & IB_DATA_UNPACK_FLAG.DECOMPRESS) {
			
			var _buffer = __.load_buffer;
			
			// decompress buffer?
			if (_unpack_flags & IB_DATA_UNPACK_FLAG.DECOMPRESS) {
				_buffer = iceberg.buffer.decompress(_buffer);
			}
			
			// decode buffer?
			if (_unpack_flags & IB_DATA_UNPACK_FLAG.DECODE) {
				_buffer = iceberg.buffer.decode(_buffer);
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
			load_buffer		=  buffer_create(1, buffer_grow, 1);
			running			=  false;
			request_id		=  undefined;	
			response_data	=  undefined;
			response_status =  undefined;
			on_success		=  undefined;
			on_fail			=  undefined;
		};
		
		// events
		static cleanup = function() {
			if (__.load_buffer != undefined
			&&	buffer_exists(__.load_buffer)
			) {
				buffer_delete(__.load_buffer);
			}
		};
	};
	
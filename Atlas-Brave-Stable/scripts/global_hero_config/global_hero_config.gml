	
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  __  __   ______   ______   ______    //
	// /\ \_\ \ /\  ___\ /\  == \ /\  __ \   //
	// \ \  __ \\ \  __\ \ \  __< \ \ \/\ \  //
	//  \ \_\ \_\\ \_____\\ \_\ \_\\ \_____\ //
	//   \/_/\/_/ \/_____/ \/_/ /_/ \/_____/ //
	//                                       //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// global_hero_config //
	
	global.hero_config = {
		Abel:	new ICharacterConfig({
            meta:   {
                uid:  "Abel",
                name: "Abel",
                desc: "...",
            },
            sprite: {
                full:      spr_Abel_high_res,
                portrait:  spr_Abel_portrait,
                nameplate: spr_Abel_nameplate,
				mask:	   spr_Abel_collision,
				hurtbox:   spr_Abel_hurtbox,
            },    
            audio:  {
                vocal: {
                    rate:  0.6,
                    voice: [
                        sfx_Abel_Attack_voice_1,
                        sfx_Abel_Attack_voice_2,
                        sfx_Abel_Attack_voice_3,
                    ],
                    hurt:  [
                        sfx_Abel_Hurt_voice_1,
                        sfx_Abel_Hurt_voice_2,
                    ],
                },
                death: [],
            },
        }),
	};
	
	global.hero_data_order = [
		"Abel",
	];
	global.hero_count	   = array_length(global.hero_data_order);
	
	#macro HERO_CONFIG	global.hero_config
	#macro HERO_DATA	global.hero_data
	#macro HERO_COUNT	global.hero_count
	
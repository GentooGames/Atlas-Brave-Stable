	
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
        Arthur: new ICharacterConfig({
            meta:   {
                uid:  "Arthur",
                name: "Arthur",
                desc: "...",
            },
            sprite: {
                full:      spr_Arthur_high_res,
                portrait:  spr_Arthur_portrait,
                nameplate: spr_Arthur_nameplate,
				mask:	   spr_Arthur_collision,
				hurtbox:   spr_Arthur_hurtbox,
            },    
            audio:  {
                vocal: {
                    rate:  0.6,
                    voice: [
                        sfx_Arthur_Attack_voice_1,
                        sfx_Arthur_Attack_voice_2,
                        sfx_Arthur_Attack_voice_3,
                    ],
                    hurt:  [
                        sfx_Arthur_Hurt_voice_1,
                        sfx_Arthur_Hurt_voice_2,
                    ],
                },
                death: [],
            },
        }),
		
        Enzo: new ICharacterConfig({
            meta:   {
                uid:  "Enzo",
                name: "Enzo",
                desc: "...",
            },
            sprite: {
                full:      spr_Enzo_high_res,
                portrait:  spr_Enzo_portrait,
                nameplate: spr_Enzo_nameplate,
				mask:	   spr_Enzo_collision,
				hurtbox:   spr_Enzo_hurtbox,
            },    
            audio:  {
                vocal: {
                    rate:  0.6,
                    voice: [
                        sfx_Enzo_Attack_charge_voice,
                    ],
                    hurt:  [
                        sfx_Enzo_Hurt_voice_1,
                        sfx_Enzo_Hurt_voice_2,
                    ],
                },
                death: [],
            },
        }),	
		
	    kai: new ICharacterConfig({
            meta:   {
                type: "kai",
                name: "Kai",
                desc: "...",
            },
            sprite: {
                full:      spr_Kai_high_res,
                portrait:  spr_Kai_portrait,
                nameplate: spr_Kai_nameplate,
				mask:	   spr_Kai_collision,
				hurtbox:   spr_Kai_hurtbox,
            },    
            audio:  {
                vocal: {
                    rate:  0.6,
                    voice: [
                        sfx_Kai_Attack_voice_1,
                        sfx_Kai_Attack_voice_2,
                        sfx_Kai_Attack_voice_3,
                    ],
                    hurt:  [
                        sfx_Kai_Hurt_voice_1,
                        sfx_Kai_Hurt_voice_2,
                    ],
                },
                death: [],
            },
        }),	
		
		
	};
	

	
	global.hero_data_order = [
		"Abel","Arthur","Enzo","Kai"
	];
	global.hero_count	   = array_length(global.hero_data_order);
	
	#macro HERO_CONFIG	global.hero_config
	#macro HERO_DATA	global.hero_data
	#macro HERO_COUNT	global.hero_count
	
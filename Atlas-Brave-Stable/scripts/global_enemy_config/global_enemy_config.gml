
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	//  ______   __   __   ______   __    __   __  __    //
	// /\  ___\ /\ "-.\ \ /\  ___\ /\ "-./  \ /\ \_\ \   //
	// \ \  __\ \ \ \-.  \\ \  __\ \ \ \-./\ \\ \____ \  //
	//  \ \_____\\ \_\\"\_\\ \_____\\ \_\ \ \_\\/\_____\ //
	//   \/_____/ \/_/ \/_/ \/_____/ \/_/  \/_/ \/_____/ //
	//                                                   //
	// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
	// global_enemy_config //

	global.enemy_config = {
		giblin: new ICharacterConfig({
            meta:   {
                type: "giblin",
                name: "Giblin",
                desc: "...",
            },
            sprite: {
                full:      undefined,
                portrait:  undefined,
                nameplate: undefined,
            },    
			size:	{
				height: 14,	
			},
            audio:  {
                vocal: {
                    rate:  0.6,    
                    voice: [
                        sfx_Giblin_voice_1,
                    ],
                    hurt:  [
                        sfx_Giblin_Hurt_voice_1,
                    ],
                },
                death: [
                    sfx_enemy_death_1,
                    sfx_enemy_death_2,
                ],
            },
            combat: {
                hurtbox: "giblin",    
            },
        }),
        viper:	new ICharacterConfig({
            meta:   {
                type: "viper",
                name: "Viper",
                desc: "...",
            },
            sprite: {
                full:      undefined,
                portrait:  undefined,
                nameplate: undefined,
            },    
			size:	{
				height: 11,	
			},
            audio:  {
                vocal: {
                    rate:  0.6,    
                    voice: [],
                    hurt:  [
                        sfx_Viper_Attack_windup_1,
                    ],
                },
                death: [
                    sfx_enemy_death_1,
                    sfx_enemy_death_2,
                ],
            },
            combat: {
                hurtbox: "viper",    
            },
        })
	};
	
	#macro ENEMY_CONFIG	global.enemy_config
	#macro ENEMY_DATA	global.enemy_data
	
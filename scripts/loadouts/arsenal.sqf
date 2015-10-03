if (isServer) then {

	[missionNamespace,[
		//radios
		"clf_prc117g_ap_multi",
		"clf_nicecomm2_multi",
		"clf_nicecomm2_coy",
		"clf_nicecomm2_prc117g_multi",
		"clf_nicecomm2_prc117g_coy",
		"clf_trc9110",
		"tf_anarc210",
		"tf_rt1523g",

		"B_ons_Carryall_MEdical",
		"B_ons_Carryall_MEdical_AR",
		"B_ons_Carryall",
		"B_ons_Carryall_AR",
		"B_ons_AssaultPack_AR",
		"B_ons_AssaultPack_TW",
		"B_AssaultPack_mcamo",
		"B_Kitbag_cbr",
		"B_Kitbag_mcamo",
		"B_Bergen_mcamo",
		"B_AssaultPack_blk",
		"B_AssaultPack_rgr",
		"B_Kitbag_rgr",
		"B_TacticalPack_rgr",
		"B_OutdoorPack_tan",
		"B_Kitbag_mcamo"
	],true] call BIS_fnc_addVirtualBackpackCargo;

	[missionNamespace,[

		//pistols
		"RH_p226",

		//rifles
	    "ONS_C7A2",
	    "ONS_C7A2_M203",
	    "ons_c9a2",
	    "caf_c6gpmg",
		"ONS_C8A2",
		"ONS_C8A2_AR",
		"ONS_C8A2_M203",
		"ONS_C8A2_M203_AR",
		"ONS_C8A3",
	    "ONS_C8A3_M203",
	    "ONS_C8A3_CQB",
        "RH_mk12mod1",

	    //launchers
	    "caf_m72a6",
	    "CAF_M2CG"
	],true] call BIS_fnc_addVirtualWeaponCargo;

	[missionNamespace,[
		//silencers
		"muzzle_snds_M",
		"muzzle_snds_B",
		"RH_spr_mbs",

		//radios
	    "tf_anprc152",

	    //uniforms
	    "U_ons_uniform1_cadpatAR",
	    "U_ons_uniform1_cadpatTW",
	    "U_ons_uniform2_cadpatAR",
	    "U_ons_uniform2_cadpatTW",
	    "U_C_Journalist",

	    //vests
		"ONS_V_TacVest01_AR",
		"ONS_V_TacVest01_TW",
		"ONS_V_TacVest02_AR",
		"ONS_V_TacVest02_TW",
		"V_TacVest_oli",
		"V_RebreatherB",
		"V_Press_F",

	    //helmets
	    "ONS_Helmet_AR_B",
	    "ONS_Helmet_TW_B",
	    "H_CrewHelmetHeli_B",
	    "H_PilotHelmetHeli_B",
	    "H_PilotHelmetFighter_B",
	    "H_Cap_oli",
	    "H_Cap_tan",
	    "H_Beret_grn",
	    "H_HelmetCrew_B",
	    "H_Beret_blk",
	    "H_Beret_brn_SF",
	    "H_Beret_grn_SF",
	    "H_Beret_red",
	    "H_Beret_02",
		"H_ons_Boonie_AR",
	    "H_Booniehat_khk",
	    "H_Booniehat_khk_hs",
	    "H_Booniehat_tan",
	    "H_Booniehat_dirty",
	    "H_Booniehat_grn",
		"H_Watchcap_blk",
		"H_Watchcap_khk",
		"H_Watchcap_camo",
		"H_Watchcap_sgg",

	    //goggles
	    "G_Combat",
	    "G_Lowprofile",
	    "G_Aviator",
	    "G_Shades_Black",
	    "G_Shades_Blue",
	    "G_Shades_Green",
	    "G_Shades_Red",
	    "G_Spectacles",
	    "G_Spectacles_Tinted",
	    "G_Squares",
	    "G_Squares_Tinted",
	    "G_Sport_Blackred",
	    "G_Sport_BlackWhite",
	    "G_Sport_Blackyellow",
	    "G_Sport_Greenblack",
	    "G_Sport_Checkered",
	    "G_Sport_Red",
	    "G_Tactical_Black",
	    "G_Tactical_Clear",
	    "G_Diving",

	    //masks
		"Mask_M40",
		"Mask_M40_OD",
		"Mask_M50",
		"Balaclava_Black",
		"Balaclava_GRY",
		"Balaclava_OD",
		"L_shemagh_white",
		"L_Shemagh_OD",
		"L_Shemagh_Tan",
		"L_Shemagh_Red",
		"L_Shemagh_Gry",
		"LCG_Shemagh_Tan",
		"LBG_Shemagh_Tan",
		"LOG_Shemagh_Tan",
		"LCG_Shemagh_OD",
		"LBG_Shemagh_OD",
		"LOD_Shemagh_OD",
		"LCG_Shemagh_White",
		"LOG_Shemagh_White",
		"LBG_Shemagh_White",
		"LOG_Shemagh_Gry",
		"LCG_Shemagh_Gry",
		"LBG_Shemagh_Gry",
		"NeckTight_Gry",
		"NeckTight",
		"NeckTight_Red",
		"NeckTight_Tan",
		"PU_shemagh_White",
		"PU_shemagh_OD",
		"PU_shemagh_Tan",
		"SAS_Shemagh_Tan",
		"SAS_Shemagh_White",
		"SAS_Shemagh_OD",
		"Head_Wrap",
		"Head_WrapTAN",
		"Shemagh_Face",
		"shemagh_faceD",
		"Shemagh_FaceTan",
		"Shemagh_FaceRed",
		"Shemagh_FaceGry",
		"Shemagh_FaceOD",
		"shemagh_neckD",
		"shemagh_neckOD",
		"Tact_HoodTAN",
		"Tact_HoodMC",
		"Tact_HoodMAR",
		"Tact_HoodACU",
		"Tact_HoodOD",
		"H_Shemag_khk",
		"H_Shemag_tan",
		"H_Shemag_olive",
		"H_Shemag_olive_hs",
		"H_ShemagOpen_khk",
		"H_ShemagOpen_tan"
	],true] call BIS_fnc_addVirtualItemCargo;
};

_this addaction ["Fashion statement",{["Open",false] call BIS_fnc_arsenal}];
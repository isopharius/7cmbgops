_gear = [];
_headgear = headgear player;
_back_pack = backpack player;
_back_pack_items = getItemCargo (unitBackpack player);
_back_pack_weap = getWeaponCargo (unitBackpack player);
_back_pack_maga = getMagazineCargo (unitBackpack player);

_gear =
[
	_headgear,
	_back_pack,
	_back_pack_items,
	_back_pack_weap,
	_back_pack_maga
];
_gear
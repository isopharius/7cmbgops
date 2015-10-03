_v = _this select 0;

_center=_v modelToWorld (_v selectionPosition "CargoAttach");

{
	if(not([_x] in attachedObjects _v))then{
		_p = _v worldToModel [getPosATL _x select 0, getPosATL _x select 1,(getPosATL _x select 2)-((_x worldToModel (getposatl _x)) select 2)];
		_x attachTo [_v,_p];
	};
}foreach (nearestObjects [_center, ["ReammoBox","ReammoBox_F","Car","Tank","Ship","Submarine"], 7]);

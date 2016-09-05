[] spawn
{
	if ( !(isDedicated) ) then
	{
		while {true} do
		{
			waitUntil {sleep 1; alive player};

			if (288520 in (getDLCs 2)) then
			{
				player addaction
				[
					'<t color="#ff0000">Get in Kart</t>', 
					{
						player moveindriver cursortarget
					},
					this,
					1,
					true,
					true,
					'',
					'
						(cursortarget isKindOf "Kart_01_Base_F")
						&& (player distance cursortarget < 10)
						&& (vehicle player == player)
						&& ((cursortarget emptyPositions "driver") > 0)
					'
				];
			};

			player addaction
			[
				'<t color="#ff0000">Flip Kart</t>', 
				{
					vehicle player setpos
					[
						getposATL vehicle player select 0,
						getposATL vehicle player select 1,
						(getposATL vehicle player select 2 + 0.5)
					]
				},
				this,
				1,
				true,
				true,
				'',
				'
					(vehicle player isKindOf "Kart_01_Base_F")
					&& (vehicle player != player)
					&& (vectorup vehicle player select 2 < (-0.7) )
				'
			];

			waitUntil {sleep 1; !alive player};
			sleep 1;
        };
    };
};
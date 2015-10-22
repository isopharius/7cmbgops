PXS_SatelliteCamera camPrepareTarget
[
	((getPosworld PXS_SatelliteTarget) select 0) - 1,
	((getPosworld PXS_SatelliteTarget) select 1) + 1,
	(getPosworld PXS_SatelliteTarget) select 2
];
PXS_SatelliteCamera camSetPos
[
	(getPosworld PXS_SatelliteTarget) select 0,
	(getPosworld PXS_SatelliteTarget) select 1,
	((getPosworld PXS_SatelliteTarget) select 2) + PXS_SatelliteInitialHeight
];
PXS_SatelliteCamera camPrepareFov PXS_SatelliteFOV;
PXS_SatelliteCamera camCommitPrepared 0;
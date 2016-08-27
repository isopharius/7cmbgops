private _hour = (daytime - (daytime % 1));
private _minute = ((daytime % 1) * 60) - ((daytime % 1) * 60) % 1;
private _second = (((daytime % 1) * 3600) - ((daytime % 1) * 3600) % 1) - (_minute * 60);

private _hourHour = "";
if (_hour < 10) then {_hourHour = "0"};

private _minuteMinute = "";
if (_minute < 10) then {_minuteMinute = "0"};

private _secondSecond = "";
if (_second < 10) then {_secondSecond = "0"};

private _playtimeHMS = format ["%1%2:%3%4:%5%6",_hourHour,_hour,_minuteMinute,_minute,_secondSecond,_second];

_playtimeHMS;
//broadcast to clients that the target needs to be cleared
hintSilent "Target cleared";
(_this select 0) setVariable ["WALKTARGETPUBVAR", true, true];
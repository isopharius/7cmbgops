	private "_animationAMemoriser";
	_animationAMemoriser = switch (_this) do {
	     // a genou
	     case "amovpknlmstpsraswrfldnon";
	     case "amovpknlmstpslowwrfldnon";
	     // vertical dans l'eau
	     case "asdvpercmstpsnonwrfldnon";
	     case "asdvpercmstpsnonwnondnon";
		// vertical au sol
		case "amovpercmstpsnonwnondnon";
	     case "amovpercmrunslowwrfldf";
	     case "amovpercmstpslowwrfldnon";
	     case "amovpercmstpsraswrfldnon";
	     case "advepercmstpsnonwnondnon";
	     case "advepercmstpsnonwrfldnon";
	     case "aswmpercmstpsnonwnondnon" : {"vertical";};

		// couche
		case "amovppnemstpsraswrfldnon";
		case "amovppnemsprslowwrfldf";
	     // Free Fall
	     case "halofreefall_non";
	     // Plongeur (nage) horizontal sac dessous
	     case "abdvpercmwlksnonwrfldf";
	     case "asdvpercmwlksnonwrfldf";
	     case "abdvpercmstpsnonwrfldnon";
	     case "advepercmwlksnonwnondf";
	     case "advepercmwlksnonwrfldf";
	     case "aswmpercmwlksnonwnondf" : {"horizontallower";};

		// Plongeur (nage sur le dos) horizontal sac dessus
		case "abdvpercmwlksnonwnondb";
	     case "abdvpercmwlksnonwrfldb";
	     case "advepercmwlksnonwrfldb";
	     case "asdvpercmwlksnonwrfldb" : {"horizontalupper";};

	     // vide par d?faut
	     default {"";};
    };
	_animationAMemoriser
"SPACESHIP for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

<ROOM HOLD
      (LOC ROOMS)
      (DESC "Hold")
      (SOUTH TO STABLE)
      (SW TO LONG-CORRIDOR)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL WINDOW BATTLESHIP PASSENGER-SHIP ;"through viewport")
      (ACTION HOLD-F)>

<GLOBAL SPACESHIP-SCENE-STATUS 0> ;"0 = opening status
				    1 = passenger ship departed
				    2 = Thorbast killed
				    3 = monster carried Elysia away"

<ROUTINE HOLD-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,HERE ,TOUCHBIT>>>
		<QUEUE I-PASSENGER-SHIP-DEPARTS 12>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the cargo hold of a giant spaceship. ">
		<COND (<EQUAL? ,SIDEKICK-EXPLODED 1>
		       <SPLATTERED-DESC>
		       <TELL " ">)>
		<TELL
"A tiny viewport is set into the curving steel hull, and arched passageways
lead in directions that we will arbitrarily call south and southwest.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <EQUAL? ,SIDEKICK-EXPLODED 0>>
		<TELL
"   A radium-powered grenade clatters against the deck! You glimpse a
shadowy figure, dressed in black, slipping away. ">
		<COND (<IN? ,SIDEKICK ,HERE>
		       <SETG FOLLOW-FLAG 12>
		       <QUEUE I-FOLLOW 2>
		       <SETG SIDEKICK-EXPLODED 1>
		       <REMOVE ,SIDEKICK>
		       <MOVE ,SPLATTERED-SIDEKICK ,HERE>
		       <TELL D ,SIDEKICK " yells to hit the deck, and hurls ">
		       <HIM-HER>
		       <TELL
"self onto the grenade!|
   A sickening explosion splatters " D ,SIDEKICK " all around the room!
As you struggle to control your shock and nausea">
		       <MEMORIAM>)
		      (T
		       <JIGS-UP
"The resulting explosion makes you go all to pieces.">)>)>>

<ROUTINE SPLATTERED-DESC ()
	 <TELL
"Little " D ,SPLATTERED-SIDEKICK " cover all the walls, the floor,
and the ceiling.">>

<OBJECT SPLATTERED-SIDEKICK
	(SDESC "")
	(SYNONYM BITS TRENT TIFFANY TIFF)
	(ADJECTIVE SMALL SPLATTERED)
	(FLAGS NDESCBIT NARTICLEBIT PLURALBIT)
	(GENERIC GENERIC-SIDEKICK-F)
	(ACTION SPLATTERED-SIDEKICK-F)>

<ROUTINE SPLATTERED-SIDEKICK-F ()
	 <COND (<VERB? EAT LICK TASTE>
		<TELL ,YECHH>)>>

<OBJECT SWORD
	(LOC HOLD)
	(SDESC "sword")
	(FDESC
"One item in the hold is a sword, a potent weapon with a long, hard
blade of glistening steel.")
	(SYNONYM SWORD SWORDS BLADE)
	(ADJECTIVE GLISTENING MY YOUR)
	(FLAGS TAKEBIT)>

<ROOM STABLE
      (LOC ROOMS)
      (DESC "Stable")
      (NORTH PER HOLD-ENTER-F)
      (WEST PER LONG-CORRIDOR-ENTER-F)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL BATTLESHIP)
      (ACTION STABLE-F)>

<ROUTINE STABLE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This must be the flagship for " 'LGOP ,ATTACK-FLEET ", since this
stable contains " 'LGOP ,ATTACK-FLEET " Cavalry Mounts. ">
		<COND (<FSET? ,STALLION ,NDESCBIT>
		       <TELL
"The most striking horse is a magnificent white stallion. ">)>
		<TELL "There are exits to the \"north\" and \"west.\"">)>>

<ROUTINE HOLD-ENTER-F ()
	 <COND (<OR <IN? ,PROTAGONIST ,STALLION>
		    <FSET? ,STALLION ,MUNGBIT> ;"you're leading the horse">
		<TELL ,HORSE-CANT-FIT>
		<RFALSE>)
	       (T
		,HOLD)>>

<OBJECT STALLION
	(LOC STABLE)
	(DESC "stallion")
	(SYNONYM MOUNT STALLION HORSE STUD)
	(ADJECTIVE MAGNIFICENT WHITE)
	(FLAGS VEHBIT CONTBIT OPENBIT SEARCHBIT NDESCBIT)
	(ACTION STALLION-F)>

<ROUTINE STALLION-F ()
	 <COND (<EQUAL? ,STALLION ,WINNER>
		<COND (<AND <VERB? WALK>
			    <IN? ,PROTAGONIST ,STALLION>>
		       <SETG WINNER ,PROTAGONIST>
		       <DO-WALK ,PRSO>
		       <SETG WINNER ,STALLION>)
		      (<VERB? GIDDYAP>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?KICK ,STALLION>
		       <SETG WINNER ,STALLION>
		       <RTRUE>)
		      (T
		       <TELL "\"Neighhh!!!\"" CR>)>)
	       (<AND <VERB? DISEMBARK>
		     <IN? ,PROTAGONIST ,STALLION>>
		<MOVE ,PROTAGONIST ,HERE>
		<SETG OHERE <>>
		<TELL "You">
		<AND-SIDEKICK ,HERE>
		<TELL " dismount." CR>)
	       (<VERB? BOARD>
                <FCLEAR ,STALLION ,NDESCBIT>
		<RFALSE>)
	       (<AND <VERB? PUSH-DIR>
		     <PRSI? ,INTDIR>>
		<FSET ,STALLION ,MUNGBIT> ;"for exit functions"
		<DO-WALK ,P-DIRECTION>
		<FCLEAR ,STALLION ,MUNGBIT>
		<FCLEAR ,STALLION ,NDESCBIT>
		<MOVE ,STALLION ,HERE>)
	       (<AND <VERB? BOARD-DIR>
		     <EQUAL? ,P-PRSA-WORD ,W?RIDE>
		     <PRSI? ,INTDIR>>
		<PERFORM ,V?BOARD ,INTDIR>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The stallion is a magnificent white stud." CR>)
	       (<VERB? FUCK>
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <PERFORM-PRSA ,MALE-GORILLA>
		       <RTRUE>)
		      (T
		       <TELL "You and Catherine the Great." CR>)>)
	       (<VERB? KICK>
		<TELL "The horse gallops around in a circle." CR>)>>

<ROOM LONG-CORRIDOR
      (LOC ROOMS)
      (DESC "Long Corridor")
      (EAST PER LONG-CORRIDOR-MOVEMENT-F)
      (WEST PER LONG-CORRIDOR-MOVEMENT-F)
      (NE PER LONG-CORRIDOR-EXIT-F)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL HOLE BATTLESHIP LIGHT)
      ;(HOLE-DESTINATION GERONIMO)
      (ACTION LONG-CORRIDOR-F)
      ;(THINGS <PSEUDO (<> LIGHT UNIMPORTANT-THING-F)>)>

<ROUTINE LONG-CORRIDOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are partway along an \"east-west\" hall of mind-numbing length. Rings of
light pulsate along the corridor in rhythm with the ship's throbbing engines">
		<COND (<EQUAL? ,LONG-CORRIDOR-LOC 3>
		       <TELL ". A tiny alcove contains" A ,HOLE>)
		      (<EQUAL? ,LONG-CORRIDOR-LOC 1>
		       <TELL ". Openings lead \"east\" and \"northeast\"">)>
		<TELL ".">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,STALLION ,HERE>>
		<TELL "   The stallion whinnies then gallops ">
		<COND (<EQUAL? ,LONG-CORRIDOR-LOC 1>
		       <MOVE ,STALLION ,STABLE>
		       <TELL "ea">)
		      (T
		       <MOVE ,STALLION ,AT-MAIN-HATCH>
		       <TELL "we">)>
		<TELL "st." CR>)>>

<GLOBAL LONG-CORRIDOR-LOC 1>

<ROUTINE LONG-CORRIDOR-EXIT-F ()
	 <COND (<EQUAL? ,LONG-CORRIDOR-LOC 1>
		<COND (<OR <IN? ,PROTAGONIST ,STALLION>
			   <FSET? ,STALLION ,MUNGBIT> ;"leading the horse">
		       <TELL ,HORSE-CANT-FIT>
		       <RFALSE>)
		      (T
		       ,HOLD)>)
	       (T
		<TELL ,CANT-GO>
		<RFALSE>)>>

<ROUTINE LONG-CORRIDOR-MOVEMENT-F ()
	 <COND (<IN? ,PROTAGONIST ,STALLION>
		<RETURN <LONG-CORRIDOR-ENTER-F T>>)
	       (<PRSO? ,P?EAST>
		<COND (<EQUAL? ,LONG-CORRIDOR-LOC 1>
		       <RETURN ,STABLE>)
		      (T
		       <SETG LONG-CORRIDOR-LOC <- ,LONG-CORRIDOR-LOC 1>>)>)
	       (<EQUAL? ,LONG-CORRIDOR-LOC 10>
		<RETURN ,AT-MAIN-HATCH>)
	       (T
		<SETG LONG-CORRIDOR-LOC <+ ,LONG-CORRIDOR-LOC 1>>)>
	 <DESCRIBE-ROOM>
	 <COND (<IN? ,SIDEKICK ,HERE>
		<SIDEKICK-FOLLOWS-YOU>)>
	 ;"next kludge keeps V-WALK from doing an RFATAL"
	 <RETURN ,ROOMS>>

<ROOM AT-MAIN-HATCH
      (LOC ROOMS)
      (DESC "At Main Hatch")
      (EAST PER LONG-CORRIDOR-ENTER-F)
      (NORTH PER HATCH-ENTER-F)
      (OUT PER HATCH-ENTER-F)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL HATCH BATTLESHIP)
      (ACTION AT-MAIN-HATCH-F)>

<ROUTINE AT-MAIN-HATCH-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER> ;"blow chance for sex scene"
		<FSET ,PRIVATE-CABIN-DOOR ,LOCKEDBIT>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "To the \"north,\" the main hatch of the flagship is ">
		<OPEN-CLOSED ,HATCH>
		<TELL ". A long corridor leads \"east.\"">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <OR <ULTIMATELY-IN? ,THORBAST-SWORD>
			 <EQUAL? ,SPACESHIP-SCENE-STATUS 3>>
		     <NOT <EQUAL? ,SPACESHIP-SCENE-STATUS 1>>>
		<I-PASSENGER-SHIP-DEPARTS>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <FSET? ,SPACE-YACHT ,TOUCHBIT>
		     <EQUAL? ,SIDEKICK-EXPLODED 1>>
		<SETG SIDEKICK-EXPLODED 2>
		<MOVE ,SIDEKICK ,HERE>
		<REMOVE ,SPLATTERED-SIDEKICK>
		<TELL
"   You hear panting as " D ,SIDEKICK " dashes up behind you, somewhat out of
breath. \"Good, you're still here! Thank God that time traveller who wandered
by the hold had a matter reconstituter!\"" CR>)>>

<ROUTINE LONG-CORRIDOR-ENTER-F ("OPTIONAL" (ON-HORSE-IN-LONG-CORRIDOR <>))
	 <COND (<IN? ,PROTAGONIST ,STALLION>
		<TELL
"Kicking your proud mount forcefully in the flank, you gallop down a long
corridor pulsing with light. Above the echoes of the hoofbeats, you can
hear, almost feel, the throbbing of mighty engines. After a minute of
wild riding" ,ELLIPSIS>
		<COND (.ON-HORSE-IN-LONG-CORRIDOR
		       <COND (<PRSO? ,P?EAST>
			      <SETG HERE ,AT-MAIN-HATCH>)
			     (T
			      <SETG HERE ,STABLE>)>)>
		<COND (<EQUAL? ,HERE ,AT-MAIN-HATCH>
		       <SETG LONG-CORRIDOR-LOC 1>
		       <MOVE ,STALLION ,STABLE>)
		      (T
		       <SETG LONG-CORRIDOR-LOC 10>
		       <MOVE ,STALLION ,AT-MAIN-HATCH>)>
		,STALLION) ;"GOTO handles vehicles as well as rooms"
	       (T
		,LONG-CORRIDOR)>>

<ROUTINE HATCH-ENTER-F ()
	 <COND (<NOT <FSET? ,HATCH ,OPENBIT>>
		<DO-FIRST "open" ,HATCH>
		<THIS-IS-IT ,HATCH>
		<RFALSE>)
	       (<OR <IN? ,PROTAGONIST ,STALLION>
		    <FSET? ,STALLION ,MUNGBIT> ;"you're leading the horse">
		<TELL ,HORSE-CANT-FIT>
		<RFALSE>)
	       (T
		,IN-SPACE)>>

<OBJECT WHITE-SUIT
	(LOC AT-MAIN-HATCH)
	(DESC "white suit")
	(NO-T-DESC "whie sui")
	(FDESC
"Hanging by the hatch is a white, form-fitting therma suit.")
	(SYNONYM SUIT SUI THERMA)
	(ADJECTIVE THERMA WHITE WHIE)
	(FLAGS WEARBIT TAKEBIT)
	(ACTION WHITE-SUIT-F)>

<ROUTINE WHITE-SUIT-F ()
	 <COND (<AND <VERB? TAKE-OFF>
		     <EQUAL? ,HERE ,IN-SPACE>>
		<QUEUE I-CHILL -1>
		<RFALSE>)
	       (<AND <VERB? PUT-ON>
		     <FSET? ,PRSI ,ACTORBIT>>
		<WASTES>)>>

<OBJECT HATCH
	(LOC LOCAL-GLOBALS)
	(DESC "hatch")
	(SYNONYM HATCH HATCHWAY DOOR)
	(FLAGS DOORBIT)>

<ROOM IN-SPACE
      (LOC ROOMS)
      (DESC "In Space")
      (SOUTH TO AT-MAIN-HATCH IF HATCH IS OPEN)
      (NORTH PER SPACE-YACHT-ENTER-F)
      (FLAGS ONBIT)
      (GLOBAL HATCH ODOR BATTLESHIP PASSENGER-SHIP)
      (ODOR "garlic")
      (ODOR-NUMBER 5)
      (ACTION IN-SPACE-F)
      ;(THINGS <PSEUDO (THORBAST SUIT THORBAST-SUIT-F)
		      (BLACK SUIT THORBAST-SUIT-F)>)>

<OBJECT THORBAST-SUIT
      (LOC IN-SPACE) 
      (DESC "black suit")
      (SYNONYM SUIT)
      (ADJECTIVE BLACK THORBAST THORBALA)
      (FLAGS NDESCBIT)
      (ACTION THORBAST-SUIT-F)>

<ROUTINE SPACE-YACHT-ENTER-F ()
	  <COND (<IN? ,THORBAST ,HERE>
		 <DO-FIRST "get past your opponent">
		 <RFALSE>)
		(<EQUAL? ,SPACESHIP-SCENE-STATUS 1>
		 <TELL ,CANT-GO>
		 <RFALSE>)
		(T
		 ,SPACE-YACHT)>>

<ROUTINE IN-SPACE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<DEQUEUE I-PASSENGER-SHIP-DEPARTS>
		<SETG CHILL-COUNTER 0>
		<QUEUE I-CHILL -1>
		<THIS-IS-IT ,YOUNG-WOMAN>
		<THIS-IS-IT ,BEM>
		<THIS-IS-IT ,THORBAST>
		<COND (<EQUAL? ,SPACESHIP-SCENE-STATUS 0>
		       <REMOVE ,BEM>
		       <REMOVE ,YOUNG-WOMAN> ;"so she's not described"
		       <REMOVE ,THORBAST> ;"ditto"
		       <SETG THORBAST-ATTACKED <>>
		       <SETG FIGHT-COUNTER 0>
		       <SETG DISARM-PROB 0>
		       <SETG FREE-MOVE-COUNTER 0>
		       <FSET ,SWORD ,NARTICLEBIT>
		       <FCLEAR ,IN-SPACE ,MUNGBIT>
		       <PUTP ,SWORD ,P?SDESC "your sword">
		       <QUEUE I-FIGHT -1>
		       <SETG BEM-COUNTER 0>
		       <QUEUE I-BEM -1>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are floating in outer space near a " 'BATTLESHIP " (to the \"south\")">
		<COND (<NOT <EQUAL? ,SPACESHIP-SCENE-STATUS 1>>
		       <TELL " and" A ,PASSENGER-SHIP " (to the \"north\")">)>
		<TELL
". " ,BATTLESHIP-DESC " Saturn looms above (below?) you, her rings
sparkling in the sunlight.">)
	       (<EQUAL? .RARG ,M-SMELL>
		<TELL
"The rumors that " D ,THORBAST " enjoys munching on hunks of raw garlic
seem to be true. Let's hope ">
		<HE-SHE>
		<TELL " doesn't talk anymore.">)>>

<OBJECT BATTLESHIP
	(LOC LOCAL-GLOBALS)
	(DESC "battleship")
	(SYNONYM BATTLE SPACESHIP FLAGSHIP SHIP)
	(ADJECTIVE BATTLE LONG LARGE SPACE FLAG)
	(GENERIC GENERIC-SHIP-F)
	(ACTION BATTLESHIP-F)>

<ROUTINE BATTLESHIP-F ()
	 <COND (<VERB? EXAMINE>
		<TELL ,BATTLESHIP-DESC>
		<CRLF>)
	       (<VERB? ENTER BOARD WALK-TO>
		<COND (<EQUAL? ,HERE ,IN-SPACE>
		       <DO-WALK ,P?SOUTH>)
		      (<GLOBAL-IN? ,BATTLESHIP ,HERE>
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,AT-MAIN-HATCH>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,IN-SPACE>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <TELL ,CANT-FROM-HERE>)>)>>

<OBJECT PASSENGER-SHIP
	(LOC LOCAL-GLOBALS)
	(DESC "small passenger spaceship")
	(SYNONYM SPACESHIP SHIP YACHT)
	(ADJECTIVE SPACE PASSENGER SMALL)
	(GENERIC GENERIC-SHIP-F)
	(ACTION PASSENGER-SHIP-F)>

<ROUTINE PASSENGER-SHIP-F ()
	 <COND (<EQUAL? ,SPACESHIP-SCENE-STATUS 1>
		<CANT-SEE ,PASSENGER-SHIP>)
	       (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,IN-SPACE>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,SPACE-YACHT>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <TELL ,CANT-FROM-HERE>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,SPACE-YACHT>
		       <DO-WALK ,P?SOUTH>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)>>

<ROUTINE GENERIC-SHIP-F ()
	 <COND (<EQUAL? ,SPACESHIP-SCENE-STATUS 1>
		<RETURN ,BATTLESHIP>)
	       (T
		<RFALSE>)>>

<ROUTINE I-CHILL ()
	 <SETG CHILL-COUNTER <+ ,CHILL-COUNTER 1>>
	 <COND (<OR <NOT <EQUAL? ,HERE ,IN-SPACE>>
		    <FSET? ,WHITE-SUIT ,WORNBIT>>
		<SETG CHILL-COUNTER 0>
		<DEQUEUE I-CHILL>
		<RFALSE>)>
	 <TELL "   ">
	 <COND (<EQUAL? ,CHILL-COUNTER 1>
		<TELL "It sure gets chilly this far from the sun!" CR>)
	       (<EQUAL? ,CHILL-COUNTER 2 3>
		<TELL "You're becoming frigid." CR>)
	       (T
		<JIGS-UP "Oops! You've frozen to death!">)>>

<GLOBAL CHILL-COUNTER 0>

<GLOBAL THORBAST-ATTACKED <>>

<GLOBAL FIGHT-COUNTER 0>

<GLOBAL FREE-MOVE-COUNTER 0>

<GLOBAL DISARM-PROB 0>

<GLOBAL BEM-COUNTER 0>

<ROUTINE I-BEM ()
	 <SETG BEM-COUNTER <+ ,BEM-COUNTER 1>> 
	 <COND (<NOT <EQUAL? ,HERE ,IN-SPACE>>
		<COND (<EQUAL? ,BEM-COUNTER 12>
		       <SETG SPACESHIP-SCENE-STATUS 3>
		       <DEQUEUE I-BEM>
		       <REMOVE ,BEM>
		       <REMOVE ,YOUNG-WOMAN>)>
		<RFALSE>)
	       (<EQUAL? ,BEM-COUNTER 1>
		<RFALSE>)>
	 <TELL "   ">
	 <COND (<EQUAL? ,BEM-COUNTER 2>
		<MOVE ,BEM ,HERE>
		<TELL
"A " 'BEM ", sort of a cross between a space squid and a humanoid tree, swims
into view. Its hideous \"bark\" is covered with squirmy little suckers, and its
branches wave about like tentacles. It takes one look around and heads straight
towards the defenseless " D ,YOUNG-WOMAN ,PERIOD-CR>)
	       (<EQUAL? ,BEM-COUNTER 3>
		<TELL
"The alien monstrosity reaches the " D ,YOUNG-WOMAN ", and its tentacles
begin undulating toward ">
		<HER-HIS>
		<TELL " clothing." CR>)
	       (<EQUAL? ,BEM-COUNTER 12>
		<SETG FOLLOW-FLAG 4>
		<QUEUE I-FOLLOW 2>
		<REMOVE ,BEM>
		<REMOVE ,YOUNG-WOMAN>
		<DEQUEUE I-BEM>
		<SETG SPACESHIP-SCENE-STATUS 3>
		<TELL
"The tree-squid finishes disrobing and untying the frenzied " D ,YOUNG-WOMAN
". Wrapping a suckered tentacle around ">
		<HER-HIS>
		<TELL
" midsection, it swims away. You hear a shriek from the void,
which slowly fades." CR>)
	       (T
		<TELL "The monster ">
		<BEGIN-CONTINUE>
		<TELL "undress the poor " D ,YOUNG-WOMAN ", who ">
		<BEGIN-CONTINUE>
		<TELL "shriek in terror." CR>)>>

<ROUTINE BEGIN-CONTINUE ()
	 <COND (<EQUAL? ,BEM-COUNTER 4>
		<TELL "begin">)
	       (T
		<TELL "continue">)>
	 <TELL "s to ">>

<ROUTINE I-FIGHT ()
	 <SETG FIGHT-COUNTER <+ ,FIGHT-COUNTER 1>>
	 <COND (<NOT <EQUAL? ,HERE ,IN-SPACE>>
		<QUEUE I-PASSENGER-SHIP-DEPARTS 6>
		<DEQUEUE I-FIGHT>
		<RFALSE>)
	       (<FSET? ,THORBAST ,MUNGBIT>
		<DEQUEUE I-FIGHT>
		<RFALSE>)>
	 <TELL "   ">
	 <COND (<EQUAL? ,FIGHT-COUNTER 1>
		<MOVE ,THORBAST ,HERE>
		<MOVE ,YOUNG-WOMAN ,HERE>
		<TELL
"A figure in black, doubtless the same person who tossed the grenade into
the hold, is near the smaller ship. Given ">
		<HIS-HER>
		<TELL
" mean expression and characteristic black outfit, it must be " D ,THORBAST
", the Chief Assassin for " 'LGOP ".|
   " D ,THORBAST " is struggling with a " D ,YOUNG-WOMAN " of wealthy garb
and demeanor. Noticing you, ">
		<HE-SHE>
		<TELL " straps the ">
		<COND (,MALE
		       <TELL "wo">)>
		<TELL
"man to the hull of" T ,PASSENGER-SHIP " and jumps toward you, stopping just
a few feet away.|
   With a chillingly evil grin, ">
		<HE-SHE>
		<TELL " draws a long, pointed sword.">
		<COND (<NOT <FSET? ,THORBAST ,TOUCHBIT>>
		       <FSET ,THORBAST ,TOUCHBIT>
		       <TELL
" \"Ah, the escaped prisoner. Disposing of you will be a
small but enjoyable feather in my cap.\"">
		       <COND (<NOT <FSET? ,NOSE ,MUNGBIT>>
			      <TELL " As ">
			      <HE-SHE>
			      <TELL
" speaks, a foul odor wafts toward you.">)>)>
		<CRLF>)
	       (<NOT <IN? ,THORBAST-SWORD ,THORBAST>>
		<SETG FIGHT-COUNTER <- ,FIGHT-COUNTER 1>>
		<TELL D ,THORBAST " eyes you warily." CR>)
	       (<AND <G? ,FIGHT-COUNTER 1>
		     <NOT ,THORBAST-ATTACKED>>
		<TELL D ,THORBAST " takes advantage of your inactivity and ">
		<COND (<EQUAL? ,FREE-MOVE-COUNTER 2>
		       <SHISHKABOB>)
		      (T
		       <SETG FREE-MOVE-COUNTER <+ ,FREE-MOVE-COUNTER 1>>
		       <TELL
"launches a fierce attack. You dodge, avoiding the blade more by luck
than by skill." CR>)>)
	       (<PROB ,DISARM-PROB>
		<SETG DISARM-PROB 0>
		<MOVE ,THORBAST-SWORD ,HERE>
		<FSET ,THORBAST-SWORD ,TAKEBIT>
		<FCLEAR ,THORBAST-SWORD ,NDESCBIT>
		<THIS-IS-IT ,THORBAST-SWORD>
		<TELL
D ,THORBAST " feints backward and then launches a blow straight at your neck!
Moving with a speed rarely associated with anything besides self-preservation,
you parry, knocking the sword out of " D ,THORBAST "'s hands! It drifts toward
you, spinning slowly." CR>)
	       (<G? ,FIGHT-COUNTER 24>
		<TELL
"Fatigue overcomes you. " D ,THORBAST ", exhibiting more stamina, ">
		<SHISHKABOB>)
	       (T
		<COND (<EQUAL? ,FIGHT-COUNTER 6 12 18>
		       <TELL "Your strength ">
		       <COND (<NOT <FSET? ,IN-SPACE ,MUNGBIT>>
			      <FSET ,IN-SPACE ,MUNGBIT>
			      <TELL "begin">)
			     (T
			      <TELL "continue">)>
		       <TELL "s to ebb. ">)>
		<SETG DISARM-PROB <+ ,DISARM-PROB 12>>
		<COND (<PROB 33>
		       <TELL
D ,THORBAST "'s blade whirls invisibly toward you. Ducking, you feel
the blade whiz by an inch above " 'HEAD "!">)
		      (<PROB 50>
		       <TELL 
"You fend off a volley of powerful blows, leaving you dizzy.">)
		      (T
		       <TELL 
D ,THORBAST " lunges at your chest, but your own blade knocks ">
		       <HIS-HER>
		       <TELL " away in the nick of time.">)>
		<CRLF>)>
	 <SETG THORBAST-ATTACKED <>>
	 <RTRUE>>

<ROUTINE SHISHKABOB ()
	 <JIGS-UP "turns you into a human shish kabob.">>

<OBJECT THORBAST
	(SDESC "")
	(DESCFCN THORBAST-F)
	(SYNONYM THORBAST THORBALA ASSASSIN FIGURE)
	(ADJECTIVE CHIEF SHADOWY)
	(FLAGS ACTORBIT CONTBIT SEARCHBIT OPENBIT NARTICLEBIT)
	(ACTION THORBAST-F)>

<ROUTINE THORBAST-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<COND (<NOT <VERB? EXAMINE>>
		       <TELL "   ">)>
		<TELL "Chief Assassin " D ,THORBAST " floats before you, ">
		<HIS-HER>
		<TELL
" black-garbed body almost invisible against the backdrop of space. ">
		<HE-SHE T>
		<TELL " is ">
		<COND (<IN? ,THORBAST-SWORD ,THORBAST>
		       <TELL "brandishing a deadly looking sword.">)
		      (T
		       <TELL
"tensed, as though ready to strike like a snake.">)>)
	       (<EQUAL? ,THORBAST ,WINNER>
		<COND (<OR <AND <VERB? WHAT>
				<PRSO? ,LGOP>>
			   <AND <VERB? TELL-ABOUT>
				<PRSO? ,ME>
				<PRSI? ,LGOP>>>
		       <TELL
"\"Just the name is enough to psych out a wimp like you. In fact,
they simply liked the initials L.G.O.P. and " 'LGOP " was the
first thing they thought of.\"" CR>)
		      (T
		       <TELL D ,THORBAST " ignores you, although ">
		       <HIS-HER>
		       <TELL " evil grin widens a bit." CR>
		       <STOP>)>)
	       (<VERB? FOLLOW>
		<COND (<EQUAL? ,FOLLOW-FLAG 7>
		       <TELL ,DONT-WANT-TO>)
		      (<EQUAL? ,FOLLOW-FLAG 12>
		       <DO-WALK ,P?SW>)>)
	       (<VERB? WALK-AROUND LEAP>
		<TELL
D ,THORBAST ", who's nobody's fool, keeps you in front of ">
		<HIM-HER>
		<TELL ,PERIOD-CR>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,SWORD>>
		<TELL D ,THORBAST>
		<TELL ", delighted by your gift, ">
		<SHISHKABOB>)
	       (<VERB? KILL CUT>
		<COND (<PLAYER-CANT-SEE>
		       <RTRUE>)
		      (<NOT ,PRSI>
		       <COND (<OR <IN? ,SWORD ,PROTAGONIST>
				  <IN? ,THORBAST-SWORD ,PROTAGONIST>>
			      <SETG PRSI ,SWORD>
			      <TELL "[with the sword]" CR>)
			     (T
			      <SETG PRSI ,HANDS>)>)>
		<COND (<PRSI? ,SWORD ,THORBAST-SWORD>
		       <MOVE ,PRSI ,PROTAGONIST>
		       <SETG THORBAST-ATTACKED T>
		       <COND (<IN? ,THORBAST-SWORD ,THORBAST>
			      <COND (<PROB 25>
				     <TELL
"Your sword misses " D ,THORBAST " by inches!">)
				    (<PROB 33>
				     <TELL 
"You nick " D ,THORBAST " on the arm, drawing blood!">)
				    (<PROB 50>
				     <TELL 
"With a clang of steel, your sword smashes against " D ,THORBAST "'s!">)
				    (T
				     <TELL 
"A mighty swing, but " D ,THORBAST " easily dodges in this light gravity.">)>
			      <CRLF>)
			     (T
			      <TELL
D ,THORBAST " somersaults in a neat circle, easily avoiding your thrust and
ending up back in front of you. Further proof of " D ,THORBAST "'s uncanny ">
			      <COND (<VISIBLE? ,THORBAST-SWORD>
				     <TELL "agility">)
				    (T
				     <TELL "legerdemain">)>
			      <MOVE ,THORBAST-SWORD ,THORBAST>
			      <FSET ,THORBAST-SWORD ,NDESCBIT>
			      <FCLEAR ,THORBAST-SWORD ,TAKEBIT>
			      <TELL ": ">
			      <HE-SHE>
			      <TELL " is again holding" TR ,THORBAST-SWORD>)>)
		      (T
		       <TELL ,YOU-CANT "expect to kill a tough g">
		       <COND (,MALE
			      <TELL "uy">)
			     (T
			      <TELL "al">)>
		       <TELL " like " D ,THORBAST " with" AR ,PRSI>)>)
	       (<AND <VERB? GIVE>
		     <PRSO? ,THORBAST-SWORD>>
		<SETG SPACESHIP-SCENE-STATUS 2>
		<REMOVE ,THORBAST>
		<REMOVE ,THORBAST-SWORD>
		<SETG FOLLOW-FLAG 7>
		<QUEUE I-FOLLOW 2>
		<DEQUEUE I-FIGHT>
		<FSET ,THORBAST ,MUNGBIT>
		<TELL "As " D ,THORBAST " accepts the sword, ">
		<INCREMENT-SCORE 5 15>
		<HE-SHE>
		<TELL
" realizes that such a gesture is the final proof that you are the
good guy, and therefore ">
		<HE-SHE>
		<TELL
" hasn't got a chance of winning. Being a practical person, " D ,THORBAST
" saves both of you a lot of time and aggravation by goring ">
		<HIM-HER>
		<TELL "self on ">
		<HIS-HER>
		<TELL " own blade. Spewing droplets of blood, ">
		<HIS-HER>
		<TELL " body drifts away into the blackness of space." CR>
		<RFATAL> ;"prevents GIVE ALL TO THORBAST bug")
	       (<VERB? SMELL>
		<PERFORM-PRSA ,ODOR>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<THORBAST-F ,M-OBJDESC>
		<CRLF>)>>

<ROUTINE THORBAST-SUIT-F ()
	 <COND (<VERB? TAKE TAKE-OFF>
		<IMPOSSIBLES>)>>

<OBJECT THORBAST-SWORD
	(LOC THORBAST)
	(SDESC "")
	(SYNONYM SWORD SWORDS BLADE)
	(ADJECTIVE THORBAST THORBALA ASSASSIN HIS HER LONG POINTED)
	(FLAGS NARTICLEBIT NDESCBIT)
	(ACTION THORBAST-SWORD-F)>

<ROUTINE THORBAST-SWORD-F ()
	 <COND (<AND <VERB? RETURN>
		     <NOT ,PRSI>
		     <IN? ,THORBAST ,HERE>>
		<PERFORM ,V?GIVE ,THORBAST-SWORD ,THORBAST>
		<RTRUE>)>>

<OBJECT YOUNG-WOMAN
	(SDESC "")
	(DESCFCN YOUNG-WOMAN-F)
	(SYNONYM WOMAN MAN ELYSIA ELYSIUM)
	(ADJECTIVE YOUNG)
	(FLAGS ACTORBIT)
	(ACTION YOUNG-WOMAN-F)>

<ROUTINE YOUNG-WOMAN-F (OARG)
	 <COND (.OARG
		<COND (<EQUAL? ,HERE ,IN-SPACE>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL "   A " D ,YOUNG-WOMAN " of refined bearing">
		       <DESCRIBE-YOUNG-WOMAN>)
		      (T
		       <RFALSE>)>)
	       (<OR <AND ,MALE
			 <NOUN-USED ,W?MAN ,YOUNG-WOMAN>>
		    <AND <NOT ,MALE>
			 <NOUN-USED ,W?WOMAN ,YOUNG-WOMAN>>>
		<COND (<PRSO? ,YOUNG-WOMAN>
		       <PERFORM-PRSA ,MAN-WOMAN ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM-PRSA ,PRSO ,MAN-WOMAN>
		       <RTRUE>)>)
	       (<EQUAL? ,YOUNG-WOMAN ,WINNER>
		<COND (<AND <IN? ,BEM ,HERE>
			    <VERB? SHUT-UP>
			    <PRSO? ,ROOMS>>
		       <TELL
"You might as well tell the stars not to shine." CR>)
		      (<IN? ,BEM ,HERE>
		       <TELL
"The " D ,YOUNG-WOMAN " is too busy screaming to reply." CR>)
		      (<OR <AND <VERB? WHAT>
				<PRSO? ,LGOP>>
			   <AND <VERB? TELL-ABOUT>
				<PRSO? ,ME>
				<PRSI? ,LGOP>>>
		       <TELL
"\"They've built up a real interplanetary rep for debauchery, but actually
they're just plain Kansas girls -- a group of sisters from Wichita, the
daughters of Gus and Elmira Leather.\"" CR>)
		      (T
		       <TELL
"The "D ,YOUNG-WOMAN " blinks shyly, but says nothing." CR>)>
		<STOP>)
	       (<AND <TOUCHING? ,YOUNG-WOMAN>
		     <IN? ,THORBAST ,HERE>>
		<PERFORM ,V?KILL ,BEM>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,IN-SPACE>>
		<TELL "The " D ,YOUNG-WOMAN>
		<DESCRIBE-YOUNG-WOMAN>
		<CRLF>)
	       (<VERB? FOLLOW>
		<COND (<EQUAL? ,FOLLOW-FLAG 4>
		       <TELL ,DONT-WANT-TO>)
		      (<EQUAL? ,FOLLOW-FLAG 5>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,FOLLOW-FLAG 6>
		       <DO-WALK ,P?EAST>)>)
	       (<AND <VERB? SAVE-SOMETHING>
		     <EQUAL? ,HERE ,IN-SPACE>>
		<TELL "Psst! ">
		<COND (<IN? ,BEM ,HERE>
		       <TELL "Kill" TR ,BEM>)
		      (T
		       <TELL "Untie" TR ,YOUNG-WOMAN>)>)
	       (<AND <VERB? UNTIE>
		     <EQUAL? ,HERE ,IN-SPACE>>
		<COND (<IN? ,THORBAST ,HERE>
		       <PERFORM ,V?TOUCH ,YOUNG-WOMAN>
		       <RTRUE>)
		      (<IN? ,BEM ,HERE>
		       <DO-FIRST "get past the monster">)
		      (T
		       <MOVE ,YOUNG-WOMAN ,SPACE-YACHT>
		       <SETG FOLLOW-FLAG 5>
		       <QUEUE I-FOLLOW 2>
		       <TELL
"You untie" T ,YOUNG-WOMAN " who, beckoning you to follow, enters"
TR ,PASSENGER-SHIP>)>)
	       (<AND <VERB? TOUCH FUCK KISS EAT>
		     <EQUAL? ,HERE ,IN-SPACE>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<V-RAPE>)>>

<ROUTINE DESCRIBE-YOUNG-WOMAN ()
	 <TELL " is tied to the hull of the " 'PASSENGER-SHIP ". ">
	 <HER-HIS T>
	 <TELL
" elegantly expensive tunic is torn, exposing delicate white skin.">
	 <COND (<IN? ,BEM ,HERE>
		<TELL
" A " 'BEM " is attacking" T ,YOUNG-WOMAN ", who is understandably
screaming at the top of ">
		<HER-HIS>
		<TELL " lungs.">)>
	 <RTRUE>>

<OBJECT BEM
	(DESC "bug-eyed monster")
	(SYNONYM MONSTER TREE TREE-SQUID TREE-MONSTER SQUID)
	(ADJECTIVE BUG EYED BUG-EYED HUMANOID ALIEN TENTACLED)
	(FLAGS NDESCBIT)
	(ACTION BEM-F)>

<ROUTINE BEM-F ()
	 <COND (<TOUCHING? ,BEM>
		<COND (<IN? ,THORBAST ,HERE>
		       <DO-WALK ,P?NORTH>)
		      (T
		       <REMOVE ,BEM>
		       <DEQUEUE I-BEM>
		       <SETG FOLLOW-FLAG 4>
		       <QUEUE I-FOLLOW 2>
		       <SETG BEM-COUNTER 12>
		       <TELL
"The tree-monster squawks and flees, proving that its bark is worse
than its bite." CR>)>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 4>>
		<TELL ,DONT-WANT-TO>)>>

<ROUTINE I-PASSENGER-SHIP-DEPARTS ()
	 <COND (<EQUAL? ,SPACESHIP-SCENE-STATUS 1>
		<RFALSE>)>
	 <SETG SPACESHIP-SCENE-STATUS 1>
	 <REMOVE ,THORBAST>
	 <REMOVE ,BEM>
	 <REMOVE ,YOUNG-WOMAN>
	 <DEQUEUE I-BEM>
	 <COND (<IN? ,THORBAST-SWORD ,IN-SPACE>
		<REMOVE ,THORBAST-SWORD>)>
	 <COND (<NOT <IN-SPACE?>>
		<RFALSE>)>
	 <TELL
"   A rumbling from outside the ship sends shivers running through the deck.">
	 <COND (<OR <EQUAL? ,HERE ,HOLD>
		    <AND <EQUAL? ,HERE ,AT-MAIN-HATCH>
			 <FSET? ,HATCH ,OPENBIT>>>
		<TELL " Through the ">
		<COND (<EQUAL? ,HERE ,HOLD>
		       <TELL "viewport">)
		      (T
		       <TELL "hatchway">)>
		<TELL
", you see" T ,PASSENGER-SHIP " roaring away on a tail of ion flame!">)>
	 <CRLF>>

<ROOM SPACE-YACHT
      (LOC ROOMS)
      (DESC "Space Yacht")
      (LDESC
"This is the main cabin of a fashionable passenger ship, with exits to the
\"east\" and \"south.\"")
      (SOUTH TO IN-SPACE)
      (OUT TO IN-SPACE)
      (EAST PER PRIVATE-CABIN-ENTER-F)
      (IN PER PRIVATE-CABIN-ENTER-F)
      (FLAGS ONBIT RLANDBIT INDOORSBIT)
      (GLOBAL PASSENGER-SHIP)
      (ACTION SPACE-YACHT-F)>

<ROUTINE SPACE-YACHT-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,YOUNG-WOMAN ,HERE>>
		<SETG FOLLOW-FLAG 6>
		<QUEUE I-FOLLOW 2>
		<REMOVE ,YOUNG-WOMAN>
		<FCLEAR ,PRIVATE-CABIN-DOOR ,LOCKEDBIT>
		<MOVE ,PHOTO ,PROTAGONIST>
		<INCREMENT-SCORE 17 13 T>
		<TELL
"   The " D ,YOUNG-WOMAN " turns to you. \"I am called Elysi">
		<COND (,MALE
		       <TELL "a">)
		      (T
		       <TELL "um">)>
		<TELL "; my ">
		<COND (,MALE
		       <TELL "fa">)
		      (T
		       <TELL "mo">)>
		<TELL "ther is the wealthiest ">
		<COND (<NOT ,MALE>
		       <TELL "wo">)>
		<TELL
"man in the system. You will be grandly rewarded for saving me from
that horrid kidnapper.\"|
   ">
		<SHE-HE T>
		<TELL 
" grabs a photo off the wall, scribbles on the back of it, and hands
it to you. \"Here is ">
		<COND (,MALE
		       <TELL "fa">)
		      (T
		       <TELL "mo">)>
		<TELL "ther's address; see ">
		<HIM-HER>
		<TELL
" the next time you're on Ganymede, and you will be handsomely repaid. But
now, I must retire to my cabin to recover from this hideous ordeal.\" ">
		<COND (,MALE
		       <TELL "She curtsie">)
		      (T
		       <TELL "He bow">)>
		<TELL
"s, a bit unsteadily, and exits to the east, closing the door behind ">
		<HER-HIM>
		<TELL ,PERIOD-CR>)>>

<OBJECT PRIVATE-CABIN-DOOR
	(LOC SPACE-YACHT)
	(DESC "door")
	(SYNONYM DOOR)
	(FLAGS NDESCBIT DOORBIT LOCKEDBIT)
	(ACTION PRIVATE-CABIN-DOOR-F)>

<ROUTINE PRIVATE-CABIN-DOOR-F ()
	 <COND (<AND <VERB? KNOCK>
		     <NOT <IN? ,YOUNG-WOMAN ,IN-SPACE>>
		     <NOT <EQUAL? ,SPACESHIP-SCENE-STATUS 3>>>
		<TELL "\"Please leave me to rest!\"">
		<COND (<NOT <FSET? ,PRIVATE-CABIN-DOOR ,LOCKEDBIT>>
		       <FSET ,PRIVATE-CABIN-DOOR ,LOCKEDBIT>
		       <COND (<FSET? ,PRIVATE-CABIN-DOOR ,OPENBIT>
			      <FCLEAR ,PRIVATE-CABIN-DOOR ,OPENBIT>
			      <TELL " The door closes and y">)
			     (T
			      <TELL " Y">)>
		       <TELL "ou hear a click as the door is locked.">)>
		<CRLF>)>>

<ROUTINE PRIVATE-CABIN-ENTER-F ()
	 <COND (<FSET? ,PRIVATE-CABIN-DOOR ,OPENBIT>
		<FCLEAR ,PRIVATE-CABIN-DOOR ,OPENBIT>
		<FSET ,PRIVATE-CABIN-DOOR ,LOCKEDBIT>
		<TELL
"Private Cabin|
   You have entered a plush sleeping cabin. The " D ,YOUNG-WOMAN
" is standing in the center of the cabin, clutching ">
		<HER-HIS>
		<TELL " clothes, looking shocked to see you.">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL
" Naturally, you apologize and beat a hasty retreat.">)
		      (T
		       <TELL CR
"   \"How dare you come in here without knocking! Am I to be allowed
no privacy at all? Will my horror never end? Will...\" ">
		       <SHE-HE T>
		       <TELL
" trails off and, as the multiple shocks of the day
set in, begins sobbing. Moved, you take ">
		       <HER-HIM>
		       <TELL " in your arms.">
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 1>
			      <TELL " One thing leads to another...">)
			     (T
			      <TELL CR "   You dry ">
			      <HER-HIS>
			      <TELL
" tears, and as your bodies press closer, hysteria slowly turns
to lust. You tenderly lead Elysi">
			      <COND (,MALE
				     <TELL "a">)
				    (T
				     <TELL "um">)>
			      <TELL
" to the bed, and within seconds, your bodies lock together in slow rhythm.|
   After a series of spectacular climaxes, Elysi">
			      <COND (,MALE
				     <TELL "a">)
				    (T
				     <TELL "um">)>
			      <TELL
" is struck with an idea. \"Would ... would you like to tie me up?
It really turns me on...\"">)>
		       <TELL CR "   Much, much later, making sure that Elysi">
		       <COND (,MALE
			      <TELL "a">)
			     (T
			      <TELL "um">)>
		       <TELL
" is sleeping peacefully, you tiptoe out of the cabin, closing the door.">)>
		<CRLF> <CRLF>
		<DESCRIBE-ROOM>
		;"next bit is no longer possible"
		;<COND (<AND <IN? ,SIDEKICK ,HERE>
			    <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		       <TELL
"   " D ,SIDEKICK ", napping in the corner, leaps to ">
		       <HIS-HER>
		       <SETG AWAITING-REPLY 2>
		       <QUEUE I-REPLY 2>
		       <TELL " feet. \"Have I been asleep long?\"" CR>)>)
	       (T
		<THIS-IS-IT ,PRIVATE-CABIN-DOOR>
		<DO-FIRST "open" ,PRIVATE-CABIN-DOOR>)>
	 <RFALSE>>

<OBJECT PHOTO
	(SDESC "")
	(NO-T-DESC "phoo")
	(SYNONYM PHOTO PICTURE HARLOW FAIRBANKS)
	(ADJECTIVE JEAN DOUGLAS PHOO ADDRESS) ;"sigh, no synonyms left" 
	(FLAGS TAKEBIT BURNBIT READBIT)
	(SIZE 3)
	(ACTION PHOTO-F)>

<ROUTINE PHOTO-F ()
	 <COND (<FSET? ,PHOTO ,UNTEEDBIT>
		<RFALSE>)
	       (<VERB? READ>
		<TELL "  \"Elysi">
		<COND (,MALE
		       <TELL "a's Dadd">)
		      (T
		       <TELL "um's Momm">)>
		<TELL "y|
   The Big House With All The Windows|
   Ganymede\"" CR>)
	       (<VERB? EXAMINE>
		<TELL "It is a " D ,PHOTO " with writing on the back:" CR>
		<PERFORM ,V?READ ,PHOTO>
		<RTRUE>)>>
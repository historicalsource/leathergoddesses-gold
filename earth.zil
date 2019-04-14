"EARTH for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

<ROOM JOES-BAR
      (LOC ROOMS)
      (DESC "Joe's Bar")
      (NW PER MENS-ROOM-ENTER-F)
      (NE PER LADIES-ROOM-ENTER-F)
      (SOUTH SORRY "A gust of wind blows you back into the bar.")
      (OUT SORRY "A gust of wind blows you back into the bar.")
      (FLAGS ONBIT RLANDBIT INDOORSBIT NARTICLEBIT)
      (GLOBAL MENS-ROOM-OBJECT LADIES-ROOM-OBJECT WINDOW DULL-DUST)
      (ACTION JOES-BAR-F)
      ;(THINGS <PSEUDO (<> DUST UNIMPORTANT-THING-F)
		      (FRONT DOOR BAR-DOOR-F)
		      (<> BAR BAR-F)>)>

<OBJECT BAR-DOOR
      (LOC JOES-BAR)
      (DESC "front door")
      (SYNONYM DOOR)
      (ADJECTIVE FRONT)
      (FLAGS NDESCBIT)
      (ACTION BAR-DOOR-F)>

<OBJECT BAR-OBJECT
      (LOC JOES-BAR)
      (DESC "bar")
      (SYNONYM BAR)
      (ADJECTIVE JOES JOE\'S)
      (FLAGS NDESCBIT)
      (ACTION BAR-F)>

<ROUTINE JOES-BAR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"An undistinguished bar, yet the social center of Upper Sandusky. The front
door is almost lost amidst the hazy maze of neon that shrouds the grimy glass
of the south wall. " ,DOORS-MARKED>)>>

<CONSTANT DOORS-MARKED
"Doors marked \"Ladies\" and \"Gents\" lead, respectively,
northeast and northwest.">

<ROUTINE BAR-DOOR-F ()
	 <COND (<VERB? ENTER>
		<DO-WALK ,P?SOUTH>)
	       (<VERB? OPEN CLOSE>
		<TELL "It's a swinging door." CR>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM-PRSA ,WINDOW>
		<RTRUE>)>>

<ROUTINE BAR-F ()
	 <COND (<VERB? LEAVE EXIT DISEMBARK>
		<DO-WALK ,P?SOUTH>)
	       (<VERB? ENTER WALK-TO BOARD>
		<TELL ,LOOK-AROUND>)
	       (<VERB? EXAMINE>
		<V-LOOK>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)>>

<OBJECT JOE
	(LOC JOES-BAR)
	(DESC "Joe")
	(SYNONYM JOE BARTENDER)
	(FLAGS ACTORBIT NDESCBIT NARTICLEBIT)
	(ACTION JOE-F)>

<ROUTINE JOE-F ()
	 <COND (<OR <VERB? TELL>
		    <AND <VERB? ASK-FOR>
			 <PRSI? ,BEER>>>
		<TELL "\"You've had enough.\"" CR>
		<STOP>)
	       (<VERB? EXAMINE>
		<TELL "Joe is bartending." CR>)>>

<OBJECT BEER
	(DESC "mug of beer")
	(SYNONYM DRINK MUG BEER)
	(ACTION BEER-F)>

<ROUTINE BEER-F ()
	 <COND (<AND <VERB? BUY>
		     <EQUAL? ,HERE ,JOES-BAR>>
		<TELL "The bartender">
		<COND (<RUNNING? ,I-URGE>
		       <TELL ", a keen judge of bladders,">)>
		<TELL " says, ">
		<PERFORM ,V?TELL ,JOE>
		<RTRUE>)>>

<OBJECT GARMENT
	(LOC PROTAGONIST)
	(SDESC "your overalls")
	(SYNONYM OVERALLS CLOTHES LOINCLOTH BIKINI)
	(ADJECTIVE MY YOUR BRASS TIGHT)
	(FLAGS TAKEBIT WEARBIT WORNBIT VOWELBIT NARTICLEBIT PLURALBIT)
	(ACTION GARMENT-F)>

<ROUTINE GARMENT-F ()
	 <COND (<WRONG-SEX-WORD ,GARMENT ,W?LOINCLOTH ,W?BIKINI>
		<STOP>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,CELL ,TOUCHBIT>>
		<TELL
"The " D ,GARMENT ", tight but comfy,
covers only the \"bare essentials.\"" CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"1. You|
2. A " D ,COMIC-BOOK CR>)
	       ;(<AND <VERB? TAKE TAKE-OFF>
		     ,GONE-APE>
		<TELL ;"victim of shrinking"
"In an odd way, this seems to fall in the category of exposing yourself." CR>)
	       (<OR <VERB? TAKE-OFF>
		    <AND <VERB? TAKE>
			 ,GONE-APE>>
		;<COND (<EQUAL? ,HERE ,JOES-BAR>
		       <TELL ;"victim of shrinking"
"You instantly become a legend in the annals of Joe's Bar history. As the
town policeman leads you away, wrapped in a blanket, you notice a flash of
green light and wild screams from inside the bar. When the earth is invaded
three weeks later, you wonder...">)>
		<TELL "But" T ,GARMENT>
		<COND (<FSET? ,GARMENT ,PLURALBIT>
		       <TELL " are">)
		      (T
		       <TELL " is">)>
		<TELL " so becoming!" CR>)>>

<OBJECT POCKET
	(LOC GLOBAL-OBJECTS)
	(DESC "pocket")
	(SYNONYM POCKET)
	(ADJECTIVE ;POCKET BACK) ;"why was POCKET also an adjective?"
	(ACTION POCKET-F)>

<ROUTINE POCKET-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "There's" A ,COMIC-BOOK " there." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,POCKET>>
		<TELL "There's no room. ">
		<PERFORM ,V?LOOK-INSIDE ,POCKET>
		<RTRUE>)>>

<OBJECT COMIC-BOOK
	(LOC PROTAGONIST)
	(SDESC "comic book")
	(SYNONYM BOOK RULES)
	(ADJECTIVE RULE COMIC 3-D)
	(FLAGS READBIT TAKEBIT)
	(ACTION COMIC-BOOK-F)>

<ROUTINE COMIC-BOOK-F ()
	 <COND (<AND <VERB? REMOVE TAKE BURN> ;"TAKE possible as gorilla"
		     <PRSO? ,COMIC-BOOK>>
		<TELL
"You change your mind and" ,STICK-IT-IN-POCKET " instead." CR>)
	       (<VERB? READ LOOK-INSIDE OPEN>
		<COND (<FSET? ,CELL ,TOUCHBIT>
		       <TELL
"\"Hello, Prisoner!|
   You are a captive of " 'LGOP ". As an experimental subject, your unspeakably
painful death will help our effort to enslave humanity and turn the Earth into
our private pleasure world. Consider this to be a great honor, human.\"|
   The remainder of the book covers the exacting rules of behavior expected
of a prisoner of " 'LGOP ". For example, it mentions that escapees will be
killed immediately and painfully by crack Leckbandi guards.">)
		      (T
		       <IN-YOUR-PACKAGE "3-D comic book">)>
		<TELL
" After reading it, you" ,STICK-IT-IN-POCKET ,PERIOD-CR>)>>

<OBJECT FLASHLIGHT
	(LOC PROTAGONIST)
	(DESC "flashlight")
	(SYNONYM FLASHLIGHT LIGHT)
	(ADJECTIVE FLASH)
	(FLAGS TAKEBIT LIGHTBIT)
	(ACTION FLASHLIGHT-F)>

<ROUTINE FLASHLIGHT-F ()
	 <COND (<VERB? OPEN LOOK-INSIDE>
		<TELL "The " 'FLASHLIGHT " has rusted shut." CR>)
	       (<AND <VERB? POINT>
		     <FSET? ,FLASHLIGHT ,ONBIT>
		     ,PRSI>
		<TELL ,NOTHING-NEW>)>>

<ROOM MENS-ROOM
      (LOC ROOMS)
      (DESC "Gents' Room")
      (SE TO JOES-BAR)
      (OUT TO JOES-BAR)
      (FLAGS ONBIT RLANDBIT INDOORSBIT)
      (GLOBAL TOILET ODOR WATER MENS-ROOM-OBJECT SINK)
      (ODOR "pizza")
      (ODOR-NUMBER 1)
      (ACTION BATHROOM-F)
      ;(THINGS <PSEUDO (<> SINK SINK-F)>)>

<ROOM LADIES-ROOM
      (LOC ROOMS)
      (DESC "Ladies' Room")
      (SW TO JOES-BAR)
      (OUT TO JOES-BAR)
      (FLAGS ONBIT RLANDBIT INDOORSBIT)
      (GLOBAL TOILET ODOR WATER LADIES-ROOM-OBJECT SINK)
      (ODOR "pizza")
      (ODOR-NUMBER 1)
      (ACTION BATHROOM-F)
      ;(THINGS <PSEUDO (<> SINK SINK-F)>)>

<OBJECT SINK
      (LOC LOCAL-GLOBALS)
      (DESC "sink")
      (SYNONYM SINK)
      (ADJECTIVE BATHROOM)
      (FLAGS NDESCBIT)
      (ACTION SINK-F)>

<ROUTINE MENS-ROOM-ENTER-F ()
	 <COND (<NOT ,SEX-CHOSEN>
		<SETG SEX-CHOSEN T>
		<SETG MALE T>
		<MOVE ,STOOL ,MENS-ROOM>
		<FSET ,SULTANS-WIFE ,FEMALEBIT>
		<FSET ,HAREM-GUARD ,FEMALEBIT>
		<FSET ,YOUNG-WOMAN ,FEMALEBIT>
		<PUTP ,SIDEKICK ,P?SDESC "Trent">
		<PUTP ,SIDEKICKS-BODY ,P?SDESC "Trent's body">
		<PUTP ,SPLATTERED-SIDEKICK ,P?SDESC "bits of splattered Trent">
		<PUTP ,THORBAST ,P?SDESC "Thorbast">
		<PUTP ,THORBAST-SWORD ,P?SDESC "his sword">
		<PUTP ,SULTAN ,P?SDESC "Sultan">
		<PUTP ,YOUNG-WOMAN ,P?SDESC "young woman">
		<PUTP ,PHOTO ,P?SDESC "photo of Jean Harlow">
		<PUTP ,HAREM ,P?ODOR "perfume">
		,MENS-ROOM)
	       (,MALE
		,MENS-ROOM)
	       (T
		<PRINTD ,MENS-ROOM>
		<WRONG-BATHROOM
"burly man in a partial state of undress unleashes a torrent of lewd remarks">
		<RFALSE>)>>

<ROUTINE LADIES-ROOM-ENTER-F ()
	 <COND (<NOT ,SEX-CHOSEN>
		<SETG SEX-CHOSEN T>
		<MOVE ,STOOL ,LADIES-ROOM>
		<FSET ,ME ,FEMALEBIT>
		<FSET ,SULTAN ,FEMALEBIT>
		<FSET ,SIDEKICK ,FEMALEBIT>
		<FSET ,THORBAST ,FEMALEBIT>
		<PUTP ,SIDEKICK ,P?SDESC "Tiffany">
		<PUTP ,SIDEKICKS-BODY ,P?SDESC "Tiffany's body">
		<PUTP ,SPLATTERED-SIDEKICK ,P?SDESC
		      "bits of splattered Tiffany">
		<PUTP ,THORBAST ,P?SDESC "Thorbala">
		<PUTP ,THORBAST-SWORD ,P?SDESC "her sword">
		<PUTP ,SULTAN ,P?SDESC "Sultaness">
		<PUTP ,YOUNG-WOMAN ,P?SDESC "young man">
		<PUTP ,PHOTO ,P?SDESC "photo of Douglas Fairbanks">
		<PUTP ,HAREM ,P?ODOR "cologne">
		,LADIES-ROOM)
	       (,MALE
		<PRINTD ,LADIES-ROOM>
		<WRONG-BATHROOM
"female patron begins pummelling you with a purse that must
surely contain concrete">
		<RFALSE>)
	       (T
		,LADIES-ROOM)>>

<ROUTINE WRONG-BATHROOM (STRING)
	 <TELL
"|   As you enter the wrong bathroom, a " .STRING ". You hustle out.||">
	 <DESCRIBE-ROOM>>

<ROUTINE BATHROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This filthy bathroom belies the existence of disinfectant. A single toilet and
sink are the only fixtures. More breathable air can be found to the south">
		<COND (<EQUAL? ,HERE ,MENS-ROOM>
		       <TELL "ea">)
		      (T
		       <TELL "we">)>
		<TELL "st.">)
	       (<EQUAL? .RARG ,M-SMELL>
		<THIS-IS-IT ,PIZZA>
		<MOVE ,PIZZA ,HERE>
		<TELL
"You trace the smell to" A ,PIZZA ", crumpled in the corner. [Incidentally,
we had some pretty putrid scents available, all of which would've seemed right
at home in a filthy restroom. In the end, we were too kind to use them --
but we were sorely tempted!]">)>>

<OBJECT MENS-ROOM-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "gents' restroom")
	(SYNONYM BATHROOM RESTROOM ROOM)
	(ADJECTIVE MEN\'S GENTS\' GENT\'S MENS GENTS FILTHY)
	(GENERIC GENERIC-RESTROOM-F)
	(ACTION MENS-ROOM-OBJECT-F)>

<ROUTINE MENS-ROOM-OBJECT-F ()
	 <COND (<VERB? FIND ENTER>
		<COND (<EQUAL? ,HERE ,JOES-BAR>
		       <DO-WALK ,P?NW>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? WALK-TO>
		<COND (<EQUAL? ,HERE ,JOES-BAR>
		       <DO-WALK ,P?NW>)
		      (<EQUAL? ,HERE ,MENS-ROOM>
		       <V-PEE>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,MENS-ROOM>
		       <DO-WALK ,P?SE>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,MENS-ROOM>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <TELL ,CANT-FROM-HERE>)>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)
	       (<VERB? USE>
		<COND (<EQUAL? ,HERE ,JOES-BAR>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <V-PEE>)>)
	       (<VERB? EXAMINE>
		<TELL "Filthy." CR>)>>

<OBJECT LADIES-ROOM-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "ladies' restroom")
	(SYNONYM BATHROOM RESTROOM ROOM)
	(ADJECTIVE LADIES LADIES\' WOMEN\'S WOMENS FILTHY)
	(GENERIC GENERIC-RESTROOM-F)
	(ACTION LADIES-ROOM-OBJECT-F)>

<ROUTINE LADIES-ROOM-OBJECT-F ()
	 <COND (<VERB? FIND ENTER>
		<COND (<EQUAL? ,HERE ,JOES-BAR>
		       <DO-WALK ,P?NE>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? WALK-TO>
		<COND (<EQUAL? ,HERE ,JOES-BAR>
		       <DO-WALK ,P?NE>)
		      (<EQUAL? ,HERE ,LADIES-ROOM>
		       <V-PEE>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,LADIES-ROOM>
		       <DO-WALK ,P?SW>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,LADIES-ROOM>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <TELL ,CANT-FROM-HERE>)>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)
	       (<VERB? USE EXAMINE>
		<PERFORM-PRSA ,MENS-ROOM-OBJECT>
		<RTRUE>)>>

<ROUTINE GENERIC-RESTROOM-F ()
	 <COND (<AND <VERB? WALK-TO FIND ENTER>
		     <EQUAL? ,HERE ,JOES-BAR>>
		<TELL ,DOORS-MARKED CR>
		<RETURN ,NOT-HERE-OBJECT>)
	       (<VERB? WALK-TO>
		<V-PEE>
		<RETURN ,NOT-HERE-OBJECT>)
	       (,SEX-CHOSEN
		<COND (,MALE
		       <RETURN ,MENS-ROOM-OBJECT>)
		      (T
		       <RETURN ,LADIES-ROOM-OBJECT>)>)
	       (T
		<RFALSE>)>>

<OBJECT TOILET
	(LOC LOCAL-GLOBALS)
	(DESC "toilet")
	(SYNONYM TOILET)
	(FLAGS VEHBIT CONTBIT OPENBIT)
	(CAPACITY 2)
	(ACTION TOILET-F)>

<ROUTINE TOILET-F ()
	 <COND (<VERB? PEE-IN USE>
		<V-PEE>)
	       (<VERB? CLOSE>
		<NO-LID>)
	       (<VERB? FLUSH>
		<TELL
"Probably the first fresh water to enter this john in a month." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL ,YECHH>)>>

<ROUTINE SINK-F ()
	 <COND (<VERB? LOOK-INSIDE EXAMINE>
		<PERFORM ,V?EXAMINE ,TOILET>
		<RTRUE>)>>

<OBJECT STOOL
	(DESC "stool")
	(NO-T-DESC "sool")
	(SYNONYM STOOL SOOL)
	(ADJECTIVE SMALL WOODEN)
	(SIZE 50)
	(CAPACITY 20)
	(FLAGS TAKEBIT VEHBIT SURFACEBIT CONTBIT OPENBIT SEARCHBIT BURNBIT)
	(ACTION STOOL-F)>

<ROUTINE STOOL-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <NOT <FSET? ,STOOL ,TOUCHBIT>>>
		<TELL "It's safe to take, if you receive my meaning." CR>)
	       (<VERB? BOARD CLIMB>
		<COND (<FIRST? ,STOOL>
		       <DO-FIRST "clear off" ,STOOL>)
		      (<IN? ,PROTAGONIST ,TREE-HOLE>
		       <MOVE ,PROTAGONIST ,HERE>
		       <SETG OHERE <>>
		       <TELL "Using the stool, you">
		       <AND-SIDEKICK ,HERE>
		       <TELL " climb out of the hole." CR>)>)>>

<GLOBAL MALE <>> ;"...is main character male? T =  male, <> = female."

<GLOBAL SEX-CHOSEN <>>

<GLOBAL URGE-COUNTER 0>

<ROUTINE I-URGE ()
	 <QUEUE I-URGE -1>
	 <SETG URGE-COUNTER <+ ,URGE-COUNTER 1>>
	 <TELL "   ">
	 <COND (<EQUAL? ,URGE-COUNTER 1>
		<TELL "You feel an urge." CR>)
	       (<EQUAL? ,URGE-COUNTER 2>
		<TELL "You trace the urge to the region of your bladder." CR>)
	       (<EQUAL? ,URGE-COUNTER 3>
		<TELL
"Though operating at far below normal speed, your mind begins to conclude
that it would be best at this point to ">
		<COND (<EQUAL? ,HERE ,MENS-ROOM ,LADIES-ROOM>
		       <TELL "use the">)
		      (T
		       <TELL "find a">)>
		<TELL " bathroom." CR>)
	       (<EQUAL? ,URGE-COUNTER 4>
		<TELL
"Even if you don't care about your clothes, imagine the embarrassment!" CR>)
	       (T
		<TELL ,YOU-CANT "wait another second. ">
		<COND (<EQUAL? ,HERE ,MENS-ROOM ,LADIES-ROOM>
		       <QUEUE I-KIDNAPPING 3>
		       <DEQUEUE I-URGE>
		       <MOVE ,PROTAGONIST ,HERE>
		       <SETG OHERE <>>
		       <TELL
"Fortunately, you've stumbled upon a bathroom. A moment later, you are feeling
much better, although your thigh muscles are still quivering a tad.">
		       <NOTICE-PIZZA-ODOR>)
		      (T
		       <TELL
"Without going into embarrassing detail, you've made a mess. A moment later,
before even half the people in Joe's have begun tittering, a flash of green
light precedes the arrival of two VERY odd patrons. They rotate their bellies
to get a better look at you. As their mouth stalks open you find that, despite
an evolution that occurred dozens of astronomical units from Upper Sandusky,
these fellows speak in perfect midwestern English.|
   \"This one?\"|
   \"A pitiful specimen ... can't even control simple bodily functions ...
the tests would be worthless...\"|
   \"Agreed. Must've been a screw-up somewhere. Let's take this one instead.\"|
   They grab a blonde woman, whose scream is cut short by another green flash.
Three weeks later, when the Earth is invaded and everyone is enslaved by "
'LGOP ", you wonder if there was a connection." CR>
		       <FINISH>)>)>>

<OBJECT PIZZA
	(DESC "dubious slice of pizza")
	(SYNONYM SLICE PIZZA)
	(ADJECTIVE DUBIOUS AGING CRUMPLED)
	(FLAGS TRYTAKEBIT)
	(ACTION PIZZA-F)>

<ROUTINE PIZZA-F ()
	 <COND (<VERB? EAT TASTE TAKE>
		<FSET ,PIZZA ,TOUCHBIT> ;"for V-VOMIT"
		<TELL "The very thought is enough to make stronger ">
		<COND (<NOT ,MALE>
		       <TELL "wo">)>
		<TELL "men than yourself ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL "become quite ill">)
		      (<EQUAL? ,NAUGHTY-LEVEL 1>
		       <TELL "vomit">)
		      (T
		       <TELL "puke their guts out">)>
		<TELL ,PERIOD-CR>)>>

<ROUTINE NOTICE-PIZZA-ODOR ()
	 <COND (<NOT <FSET? ,NOSE ,MUNGBIT>>
		<THIS-IS-IT ,ODOR>
		<TELL CR
"   Now that the \"crisis\" has passed, you notice a strong and familiar
odor pervading the room." CR>)>>

<ROUTINE I-KIDNAPPING ()
	 <COND (<IN? ,PROTAGONIST ,STOOL>
		<MOVE ,STOOL ,CELL>)>
	 <MOVE ,PROTAGONIST ,HERE>
	 <SETG OHERE <>>
	 <COND (,MALE
		<PUTP ,GARMENT ,P?SDESC "brass loincloth">)
	       (T
		<PUTP ,GARMENT ,P?SDESC "brass bikini">)>
	 <PUTP ,COMIC-BOOK ,P?SDESC "rule book">
	 <FCLEAR ,GARMENT ,NARTICLEBIT>
	 <FCLEAR ,GARMENT ,VOWELBIT>
	 <FCLEAR ,GARMENT ,PLURALBIT>
	 <ROB ,PROTAGONIST ,CELL> ;"drop everything you have but..."
	 <MOVE ,GARMENT ,PROTAGONIST> ;"...your clothes..."
	 <MOVE ,COMIC-BOOK ,PROTAGONIST> ;"...and the rule book"
	 <INCREMENT-SCORE 1 7>
	 <COND (<NOT <EQUAL? ,VERBOSITY 0>>
		<TELL
"   A brilliant flash of green light seems less unusual when followed by the
appearance of tentacled aliens, as is the case with the current flash of green
light. The tentacles wrap roughly around you as you faint.|
   After an unknown amount of time... Well, let's ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL "be frank">)
		      (T
		       <TELL "cut the ">
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 1>
			      <TELL "crap">)
			     (T
			      <TELL "bullshit">)>)>
		<TELL
". 7.3 hours later, you wake. Your head feels as if it's been run over by
several locomotives, or at least one very large locomotive, and your clothes
are now unrecognizable" ,ELLIPSIS>)>
	 <GOTO ,CELL>
	 <CELL-F ,M-END>>
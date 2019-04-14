"VENUS for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

<OBJECT VENUS
	(LOC LOCAL-GLOBALS)
	(DESC "Venus")
	(SYNONYM VENUS)
	(FLAGS NARTICLEBIT)
	(ACTION VENUS-F)>

<ROUTINE VENUS-F ()
	 <COND (<VERB? EXAMINE>
		<V-LOOK>)
	       (<VERB? LEAVE DISEMBARK EXIT>
		<TELL "How?" CR>)>>

<ROOM JUNGLE
      (LOC ROOMS)
      (DESC "Jungle")
      (EAST TO FORK-OF-SORTS)
      (WEST PER PASS-FLYTRAP-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE VENUS)
      (ACTION JUNGLE-F)>

<ROUTINE JUNGLE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,FLYTRAP ,HERE>>
		<QUEUE I-FLYTRAP -1>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are surrounded by hot, steamy, primitive rain forest. Judging by the
overpowering heat, the excessive humidity, and ">
		<COND (<IN? ,FLYTRAP ,HERE>
		       <TELL
"especially by the gigantic " 'FLYTRAP " sidling your way, ">)
		      (T
		       <TELL "the odd flora, ">)>
		<TELL
"you must be in the death-clogged jungles of Venus.|
   A path runs east-west through the jungle">
		<COND (<IN? ,FLYTRAP ,HERE>
		       <TELL
", but don't even think about going west unless you love
wading into four tons of ">
		       <COND (<NOT ,MALE>
			      <TELL "wo">)>
		       <TELL "man-eating lettuce">)>
		<TELL ".">)>>

<ROUTINE PASS-FLYTRAP-F ()
	 <COND (<IN? ,FLYTRAP ,HERE>
		<TELL
"Despite being warned, you walk right into the orifice of the " 'FLYTRAP ". ">
		<FLYTRAP-DEATH>)
	       (<EQUAL? ,HERE ,JUNGLE>
		,SPAWNING-GROUND)
	       (T
		,JUNGLE)>>

<ROUTINE FLYTRAP-DEATH ()
	 <TELL
"A little known fact about " 'FLYTRAP "s: they secrete an enzyme which
stimulates the pleasure centers of their victim. Hence, you experience ">
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<TELL
"a feeling similar to eating a really good hot fudge sundae">)
	       (T
		<TELL "multiple orgasms">)>
	 <JIGS-UP
" as your flesh is quietly dissolved away. What a way to go.">>

<OBJECT FLYTRAP
	(LOC JUNGLE)
	(DESC "Venus flytrap")
	(SYNONYM FLYTRAP LETTUCE)
	(ADJECTIVE VENUS LARGE)
	(FLAGS NDESCBIT)
	(ACTION FLYTRAP-F)>

<ROUTINE FLYTRAP-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It looks just like the Terrestrial variety -- except that " 'FLYTRAP "s on
Earth" ,EVOLVED "n ounce, and Venusian " 'FLYTRAP "s" ,EVOLVED " ton. Oh, one
other thing. Terrestrial " 'FLYTRAP "s don't usually stalk their prey." CR>)
	       (<VERB? FOLLOW>
		<COND (<EQUAL? ,FOLLOW-FLAG 9>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,FOLLOW-FLAG 10>
		       <PERFORM ,V?DISEMBARK ,TREE-HOLE>
		       <RTRUE>)
		      (<EQUAL? ,FOLLOW-FLAG 11>
		       <PERFORM ,V?ENTER ,TREE-HOLE>
		       <RTRUE>)>)
	       (<TOUCHING? ,FLYTRAP>
		<TELL
"You don't want to get that close to the flytrap -- and it has nothing
to do with its breath." CR>)>>

<GLOBAL FLYTRAP-COUNTER 0>

<GLOBAL TOO-LATE <>>

<ROUTINE I-FLYTRAP ()
	 <SETG FLYTRAP-COUNTER <+ ,FLYTRAP-COUNTER 1>>
	 <TELL "   ">
	 <COND (<NOT <IN? ,FLYTRAP ,HERE>>
		<SETG FLYTRAP-COUNTER 0>
		<COND (<EQUAL? ,HERE ,CLEARING>
		       <COND (<AND ,LEAVES-PLACED
				   <NOT ,TOO-LATE>>
			      <TRAP-FLYTRAP>
			      <TELL "You hear a crash from the west">)
			     (T
		       	      <MOVE ,FLYTRAP ,JUNGLE>
		       	      <SETG TOO-LATE <>>
		       	      <DEQUEUE I-FLYTRAP>
			      <SETG FOLLOW-FLAG 9>
			      <QUEUE I-FOLLOW 2>
		       	      <TELL
"Holy tropism! The " 'FLYTRAP " loses interest in you and crawls away">)>
		       <TELL ,PERIOD-CR>)
		      (T
		       <MOVE ,FLYTRAP ,HERE>
		       <COND (<NOT ,LEAVES-PLACED>
			      <SETG TOO-LATE T>)>
		       <TELL
"As" T ,FLYTRAP " scurries along, you dash to the eastern side of the hole
in order to be as far from it as possible." CR>)>)
	       (<IN? ,PROTAGONIST ,TREE-HOLE>
		<MOVE ,FLYTRAP ,JUNGLE>
		<SETG FOLLOW-FLAG 10>
		<QUEUE I-FOLLOW 2>
		<SETG TOO-LATE <>>
		<SETG FLYTRAP-COUNTER 0>
		<DEQUEUE I-FLYTRAP>
		<TELL
"The " 'FLYTRAP " peers down, decides that it's not worth getting trapped
for such a measly scrap of meat, and shuffles away." CR>)
	       (<AND <EQUAL? ,FLYTRAP-COUNTER 1>
		     <FSET? ,FLYTRAP ,TOUCHBIT>
		     <EQUAL? ,HERE ,JUNGLE>>
		<TELL
"Flies must be in short supply, because the " 'FLYTRAP " nearby expectantly
rustles a few stalks and begins creeping in your direction." CR>)
	       (<L? ,FLYTRAP-COUNTER 4>
		<FSET ,FLYTRAP ,TOUCHBIT>
		<TELL "The " 'FLYTRAP " sidles ">
		<COND (<AND <EQUAL? ,HERE ,FORK-OF-SORTS>
			    <OR <NOT ,LEAVES-PLACED>
				,TOO-LATE>>
		       <TELL "around the hole toward you." CR>)
		      (T
		       <TELL "closer." CR>)>)
	       (<AND <EQUAL? ,HERE ,FORK-OF-SORTS>
		     ,LEAVES-PLACED
		     <NOT ,TOO-LATE>>
		<TRAP-FLYTRAP>
		<TELL
"Never before has splintering wood sounded so sweet or tossed salad looked
so lovely. The amazing flying flytrap tumbles into your flytrap trap, covered
with leaves and bits of shattered trellis, giving the plant the amusing
appearance of a tar-and-feather victim." CR>)
	       (T
		<FLYTRAP-DEATH>)>>

<ROUTINE TRAP-FLYTRAP ()
	 <FSET ,FLYTRAP ,MUNGBIT>
	 <INCREMENT-SCORE 2 15>
	 <MOVE ,FLYTRAP ,TREE-HOLE>
	 <SETG FOLLOW-FLAG 11>
	 <QUEUE I-FOLLOW 2>
	 <ROB ,TRELLIS ,TREE-HOLE>
	 <REMOVE ,TRELLIS>
	 <FCLEAR ,FLYTRAP ,NDESCBIT>
	 <UNDO-TRAP>
	 <DEQUEUE I-FLYTRAP>>

<ROOM SPAWNING-GROUND
      (LOC ROOMS)
      (DESC "Spawning Ground")
      (EAST TO JUNGLE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HOLE VENUS)
      (HOLE-DESTINATION HOLD)
      (ACTION SPAWNING-GROUND-F)>

<ROUTINE SPAWNING-GROUND-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"As if this hasn't already been a rough enough day, you have stumbled upon a
spawning ground for Venusian slime beasts. " ,OOZY-WITH-SLIME " Fortunately,
these beasts are still in the earliest (and least deadly) stage. Only one
spot is free of slime:" T ,HOLE " near the path to the east.">)>>

<OBJECT CREAM
	(LOC SPAWNING-GROUND)
	(SDESC "jar of untangling cream")
	(NO-T-DESC "jar of unangling cream")
	(FDESC
"Inexplicably, sitting next to the circle, untouched by time or slime,
is a jar of ointment.")
	(SYNONYM JAR OINTMENT LOTION CREAM)
	(ADJECTIVE UNTANGLING UNANGLING)
	(FLAGS TAKEBIT READBIT)
	(SIZE 4)
	(ACTION CREAM-F)>

<ROUTINE CREAM-F ()
	 <COND (<VERB? EXAMINE LOOK-INSIDE>
		<EXAMINE-CREAM-AND-STAIN>)
	       (<VERB? READ>
		<TELL "The jar is marked \"Un">
		<COND (<NOT <FSET? ,CREAM ,UNTEEDBIT>>
		       <TELL "t">)>
		<TELL "angling cream.\"" CR>)
	       (<AND <VERB? EMPTY>
		     <PRSO? ,CREAM>>
		<COND (<NOT ,PRSI>
		       <PUT ,P-NAMW 1 <>>
		       <SETG PRSI ,GROUND>)>
		<COND (<FSET? ,CREAM ,MUNGBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <PUT ,P-NAMW 0 ,W?CREAM> ;"because PUT-ON checks it"
		       <PERFORM ,V?PUT-ON ,CREAM ,PRSI>
                       <RTRUE>)>)
	       (<VERB? OPEN CLOSE>
		<NO-LID>)
	       (<VERB? EAT>
		<TELL ,YECHH>)
	       (<AND <VERB? POUR PUT-ON RUB>
		     <PRSO? ,CREAM>
		     <NOT <EQUAL? <GET ,P-NAMW 0> ,W?JAR <> ;"false for ALL">>>
		<COND (<FSET? ,CREAM ,MUNGBIT>
		       <EXAMINE-CREAM-AND-STAIN>
		       <RTRUE>)>
		<MOVE ,CREAM ,PROTAGONIST>
		<FSET ,CREAM ,MUNGBIT>
		<TELL "As the lotion soaks in,">
		<COND (<AND <FSET? ,CREAM ,UNTEEDBIT>
			    <PRSI? ,THETA>>
		       <MOVE ,EIGHTY-TWO-DEGREE-ANGLE ,THRONE-ROOM>
		       <FCLEAR ,THETA ,MUNGBIT>
		       <FCLEAR ,THETA ,NDESCBIT>
		       <FSET ,THETA ,ACTORBIT>
		       <FSET ,THETA ,FEMALEBIT>
		       <FSET ,THETA ,NARTICLEBIT>
		       <PUTP ,THETA ,P?SDESC "Princess Theta">
		       <INCREMENT-SCORE 16 10 T>
		       <TELL
" the angle slowly transforms into a beautiful princess. Mitre, gushing tears
of happiness, cries, \"You have restored my beloved Theta to me!\" He reveals
a perfect " D ,EIGHTY-TWO-DEGREE-ANGLE ". \"I only brushed against it,\"
explains the King. \"Please accept it, along with my thanks.\" He reaches out
to shake " 'HANDS ,PERIOD-CR>)
		      (<AND <PRSI? ,PILE-OF-ANGLES>
			    <FSET? ,CREAM ,UNTEEDBIT>>
		       <JIGS-UP
" the angles return to their former forms: a golden chariot,
a velvet tapestry, various fruits, some handcuffs, a flock of
ducks ... and a huge hungry tiger.">)
		      (<PRSI? ,ME>
		       <TELL " your skin tingles a bit." CR>)
		      (T
		       <TELL T ,PRSI " seem">
		       <COND (<NOT <FSET? ,PRSI ,PLURALBIT>>
			      <TELL "s">)>
		       <TELL " unchanged. ">
		       <COND (<AND <PRSI? ,MITRE>
				   <FSET? ,CREAM ,UNTEEDBIT>>
			      <TELL
"(Like fighting a forest fire with a water pistol.)" CR>)
			     (T
			      <TELL "I guess ">
		       	      <COND (<FSET? ,PRSI ,PLURALBIT>
				     <TELL "they were">)
				    (T
				     <COND (<FSET? ,PRSI ,FEMALEBIT>
			      	     	    <TELL "she">)
			     	    	   (<FSET? ,PRSI ,ACTORBIT>
			      	     	    <TELL "he">)
			     	    	   (T
			      	     	    <TELL "it">)>
				     <TELL " was">)>
			      <TELL "n't very ">
		       	      <COND (<NOT <FSET? ,CREAM ,UNTEEDBIT>>
			             <TELL "t">)>
		       	      <TELL "angled." CR>)>)>)>>

<ROOM FORK-OF-SORTS
      (LOC ROOMS)
      (DESC "Fork, Of Sorts")
      (WEST PER PASS-FLYTRAP-F)
      (EAST TO CLEARING)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE VENUS)
      (ACTION FORK-OF-SORTS-F)>

<ROUTINE FORK-OF-SORTS-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,HERE ,TOUCHBIT>>
		     <NOT <EQUAL? ,VERBOSITY 0>>>
		<TELL
"A mighty tree rises before you in the center of the path. Suddenly and without
warning (as is the nature of the jungle) it dies. Within seconds, the tree is
consumed by Venusian hypertermites, which then move off in search of other
dead trees, leaving a massive hole in the ground." CR CR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This jungle path once split here, went around a mighty tree, and rejoined
off to the east. Now, it splits here, goes around a ">
		<COND (,LEAVES-PLACED
		       <PRINTD ,LEAVES>)
		      (T
		       <TELL "mighty hole">)>
		<TELL ", and rejoins off to the east.">)>>

<GLOBAL LEAVES-PLACED <>>

<OBJECT TREE-HOLE
	(LOC FORK-OF-SORTS)
	(DESC "tree hole")
	(SYNONYM HOLE)
	(ADJECTIVE TREE LARGE)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT OPENBIT VEHBIT INBIT)
	(CAPACITY 200)
	(ACTION TREE-HOLE-F)>

<ROUTINE TREE-HOLE-F ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL ,HUH>)
	       (<AND <VERB? DISEMBARK>
		     <IN? ,PROTAGONIST ,TREE-HOLE>>
		<TELL ,YOU-CANT "climb out. You're trapped." CR>)
	       (<AND <VERB? REACH-IN>
		     <IN? ,FLYTRAP ,TREE-HOLE>>
		<TELL "The " 'FLYTRAP " pulls you in. ">
		<FLYTRAP-DEATH>)
	       (<VERB? BOARD>
		<COND (<FSET? ,TRELLIS ,MUNGBIT>
		       <TELL "The hole's covered." CR>)
		      (<ULTIMATELY-IN? ,TRELLIS>
		       <TELL ,TRELLIS-TOO-WIDE>)
		      (<IN? ,FLYTRAP ,TREE-HOLE>
		       <TELL "Hey! There's a big, hungry, angry " 'FLYTRAP>
		       <JIGS-UP " down here also!">)>)
	       (<VERB? MEASURE>
		<TELL "The hole is about six feet across." CR>)
	       (<VERB? WALK-AROUND>
		<COND (<IN? ,FLYTRAP ,HERE>
		       <TELL
"You circle the hole completely, with" T ,FLYTRAP " in hot pursuit." CR>)
		      (T
		       <WEE>)>)
	       (<AND <VERB? LOOK-INSIDE>
		     ,LEAVES-PLACED>
		<PERFORM ,V?BOARD ,TREE-HOLE>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,LEAVES>
		     <FSET? ,TRELLIS ,MUNGBIT>>
		<PERFORM-PRSA ,LEAVES ,TRELLIS>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,TRELLIS ,MUNGBIT>>
		<DESCRIBE-TRELLIS-ON-HOLE>
		<CRLF>)
	       (<AND <VERB? UNCOVER>
		     <FSET? ,TRELLIS ,MUNGBIT>>
		<PERFORM ,V?MOVE ,TRELLIS>
		<RTRUE>)
	       (<AND <VERB? HIDE>
		     <IN? ,FLYTRAP ,HERE>>
		<PERFORM ,V?WALK-AROUND ,TREE-HOLE>
		<RTRUE>)>>

<ROOM CLEARING
      (LOC ROOMS)
      (DESC "Clearing")
      (NW PER CLEARING-EXIT-F)
      (NE PER CLEARING-EXIT-F)
      (EAST PER CLEARING-EXIT-F)
      (SOUTH PER CLEARING-EXIT-F)
      (WEST TO FORK-OF-SORTS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE VENUS)
      (ACTION CLEARING-F)>

<ROUTINE CLEARING-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a tiny anti-oasis of barrenness amidst the teeming Venusian jungle.
Winding paths enter the jungle in most directions.">)>>

<ROUTINE CLEARING-EXIT-F ()
	 <TELL
"You walk swiftly down the trail! It turns! It twists! It narrows! Vines grab
at your ankles and bird-sized insects close in for a kill! Suddenly" ,ELLIPSIS>
	 <COND (<PRSO? ,P?NE>
		,FRONT-DOOR)
	       (<PRSO? ,P?NW>
		,BACK-DOOR)
	       (T
		<DESCRIBE-ROOM>
		<COND (<IN? ,SIDEKICK ,HERE>
		       <NORMAL-SIDEKICK-FOLLOW>)>
		<RFALSE>)>>

<OBJECT STAIN
	(LOC CLEARING)
	(DESC "can of black stain")
	(NO-T-DESC "can of black sain")
	(SYNONYM CAN STAIN SAIN PAINT)
	(ADJECTIVE BLACK)
	(FLAGS TAKEBIT READBIT)
	(ACTION STAIN-F)
	(TEXT
"\"MarsCo Brand Black Hyperdimensional Transport Circle Stain.\"")>

<ROUTINE STAIN-F ()
	 <COND (<FSET? ,STAIN ,UNTEEDBIT>
		<RFALSE>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<EXAMINE-CREAM-AND-STAIN>)
	       (<AND <VERB? APPLY>
		     <GLOBAL-IN? ,HOLE ,HERE>>
		<APPLY-STAIN ,HOLE>)
	       (<AND <VERB? EMPTY>
		     <PRSO? ,STAIN>>
		<COND (<FSET? ,STAIN ,MUNGBIT>
		       <EXAMINE-CREAM-AND-STAIN>)
		      (<OR <NOT ,PRSI>
			   <PRSI? ,GROUND ,CANAL-OBJECT ,WATER ,TREE-HOLE>>
		       <FSET ,STAIN ,MUNGBIT>
		       <TELL "Done. What a waste of good stain!" CR>)
		      (T
		       <APPLY-STAIN ,PRSI>)>)
	       (<VERB? OPEN CLOSE>
		<NO-LID>)
	       (<VERB? DRINK>
		<TELL ,YECHH>)
	       (<AND <VERB? POUR>
		     <PRSI? ,GROUND ,CANAL-OBJECT ,WATER ,TREE-HOLE>>
		<PERFORM ,V?EMPTY ,STAIN ,GROUND>
		<RTRUE>)
	       (<AND <VERB? POUR PUT-ON RUB>
		     <PRSO? ,STAIN>
		     <NOUN-USED ,W?STAIN ,STAIN>>
		<APPLY-STAIN ,PRSI>)>>

<ROUTINE APPLY-STAIN (OBJ)
	 <COND (<FSET? ,STAIN ,MUNGBIT>
		<SETG PRSO ,STAIN>
		<EXAMINE-CREAM-AND-STAIN>)
	       (<EQUAL? .OBJ ,HOLE>
		<THIS-IS-IT ,HOLE>
		<TELL "The circle is ">
		<COND (<CIRCLE-ISNT-BLACK>
		       <SETG CIRCLE-BLACK T>
		       <FSET ,STAIN ,MUNGBIT>
		       <PUT ,P-ADJW 0 <>> ;"prevents YOU CAN'T SEE ANY... bug"
		       <PUT ,P-ADJW 1 <>> ;"since parser doesn't clears P-ADJW"
		       <PUTP ,HOLE ,P?SDESC "black circle">
		       <TELL "once again">)
		      (T
		       <TELL "already">)>
		<TELL " black!" CR>)
	       (<EQUAL? .OBJ ,FLYTRAP>
		<PERFORM ,V?TOUCH ,FLYTRAP>
		<RTRUE>)
	       (T
	 	<TELL
"You apply a tiny dab to" T .OBJ " but it doesn't stick." CR>)>>

<ROUTINE EXAMINE-CREAM-AND-STAIN ()
	 <TELL "The " D ,PRSO " is ">
	 <COND (<FSET? ,PRSO ,MUNGBIT>
		<TELL "empty">)
	       (T
		<TELL "full">)>
	 <COND (<VERB? EXAMINE>
	 	<TELL ", and has some writing on it">)>
	 <TELL ,PERIOD-CR>>

<ROOM FRONT-DOOR
      (LOC ROOMS)
      (DESC "Front Door")
      (LDESC
"To the north: the entrance to a plasticoid house, the only type of structure
that lasts more than three minutes in the volatile Venusian biosphere. To the
south and east: paths into the jungle.")
      (NORTH TO LOOKS-CAN-BE-DECEIVING IF FRONT-DOOR-OBJECT IS OPEN)
      (IN TO LOOKS-CAN-BE-DECEIVING IF FRONT-DOOR-OBJECT IS OPEN)
      (SOUTH TO CLEARING)
      (EAST TO ROCKY-CLIFFTOP)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FRONT-DOOR-OBJECT HOUSE TREE VENUS)>

<ROOM BACK-DOOR
      (LOC ROOMS)
      (DESC "Back Door")
      (LDESC
"You're near the rear entrance of a house, to the south.
Trails enter the jungle to the east and the west.")
      (WEST TO CLEARING)
      (EAST TO ROCKY-CLIFFTOP) 
      (SOUTH TO LOOKS-CAN-BE-DECEIVING IF BACK-DOOR-OBJECT IS OPEN) ;"imposs."
      (IN TO LOOKS-CAN-BE-DECEIVING IF BACK-DOOR-OBJECT IS OPEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BACK-DOOR-OBJECT HOUSE TREE VENUS)
      (ACTION BACK-DOOR-F)>

<ROUTINE BACK-DOOR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-SALESMAN -1>)>>

<OBJECT SALESMAN
	(LOC BACK-DOOR)
	(DESC "salesman")
	(LDESC
"An extraordinary number of door-to-door salesmen are camped out here, having
been booted away from the front door, but still hopeful of making a sale.")
	(SYNONYM SALESMAN MAN)
	(ADJECTIVE SALES)
	(FLAGS ACTORBIT CONTBIT OPENBIT)
	(ACTION SALESMAN-F)>

<ROUTINE SALESMAN-F ()
	 <COND (<EQUAL? ,SALESMAN ,WINNER>
		<QUEUE I-SALESMAN 2> ;"he shouldn't speak twice in one turn"
		<COND (<OR <AND <VERB? WHAT>
				<PRSO? ,LGOP>>
			   <AND <VERB? TELL-ABOUT>
				<PRSO? ,ME>
				<PRSI? ,LGOP>>>
		       <TELL
"\"I know the ones you mean. Made a fortune in interplanetary shoe
and briefcase peddling. They really know the territory.\"" CR>)
		      (T
		       <TELL
"\"Let's cut the gab and cut a deal instead!\"" CR>
		       <STOP>)>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,SALESMAN>>
		<COND (<PRSO? ,FLASHLIGHT>
		       <REMOVE ,FLASHLIGHT>
		       <MOVE ,ODD-MACHINE ,HERE>
		       <FCLEAR ,ODD-MACHINE ,TRYTAKEBIT>
		       <REMOVE ,SALESMAN>
		       <SETG FOLLOW-FLAG 8>
		       <QUEUE I-FOLLOW 2>
		       <INCREMENT-SCORE 3 7>
		       <EAGERLY-ACCEPTS>
		       <TELL
", mentioning that he knows a Plutonian plutocrat who'll trade his life fortune
for one, and drops" A ,ODD-MACHINE " at your feet. \"It's a TEE remover,\" he
explains. You ponder what it removes -- tea stains, hallway T-intersections --
even TV star Mr. T crosses your mind, until you recall that it's only 1936. But
before you have a chance to ask the salesman, he ">
		       <COND (<FSET? ,FLASHLIGHT ,ONBIT>
			      <TELL "points" T ,FLASHLIGHT " upwards">)
			     (T
			      <TELL "turns on" T ,FLASHLIGHT>)>
		       <TELL
" and a giant Venusian MegaMoth swoops down and carries him off. The
other salesmen scatter like frightened salesmen." CR>
		       <RFATAL>)
		      (T
		       <QUEUE I-SALESMAN 2>
		       <COND (<PRSO? ,TEN-MARSMID-COIN ,ONE-MARSMID-COIN>
			      <PERFORM ,V?BUY ,ODD-MACHINE>
			      <RTRUE>)
			     (T
			      <TELL <PICK-ONE ,SALESMAN-REFUSALS>>)>
		       <TELL " Offer me something else.\"" CR>)>)
	       (<OR <AND <VERB? SHOW>
			 <PRSO? ,FLASHLIGHT>>
		    <AND <VERB? ASK-ABOUT>
			 <PRSI? ,FLASHLIGHT>>>
		<TELL "The salesman tries to look disinterested." CR>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 8>>
		<TELL ,DONT-WANT-TO>)
	       (<VERB? BARTER-WITH>
		<TELL "Just give him something!" CR>)
	       (<VERB? COUNT>
		<TELL "Lots." CR>)>>

<GLOBAL SALESMAN-REFUSALS
	<LTABLE
	 0
	 "\"No thanks, I've already got one."
	 "\"Stop insulting me. There's a glut of those on the market."
	 "\"That model went out of style before I was born!">>

<GLOBAL SALESMANISMS
	<LTABLE
	 0
	 "\"I'll throw in a free two-week service contract.\""
	 "\"Barter-back guarantee!\""
	 "\"Never had a complaint in 37 years of selling these babies.\""
	 "\"Includes a three-day warranty!\"">>

<ROUTINE I-SALESMAN ()
	 <QUEUE I-SALESMAN -1>
	 <COND (<NOT <IN? ,SALESMAN ,HERE>>
		<FCLEAR ,SALESMAN ,TOUCHBIT>
		<DEQUEUE I-SALESMAN>
		<RFALSE>)>
	 <TELL "   ">
	 <COND (<FSET? ,SALESMAN ,TOUCHBIT>
		<TELL <PICK-ONE ,SALESMANISMS> CR>)
	       (T
		<FSET ,SALESMAN ,TOUCHBIT>
		<FCLEAR ,ODD-MACHINE ,NDESCBIT>
		<THIS-IS-IT ,SALESMAN>
		<TELL "A salesman approaches you. \"You look like a ">
		<COND (,MALE
		       <TELL "fella">)
		      (T
		       <TELL "doll">)>
		<TELL
" who can spot a good deal. One of my machines could change your life! Let's
barter; offer me something as an even-up trade.\"" CR>)>>

<OBJECT ODD-MACHINE
	(LOC SALESMAN)
	(DESC "odd machine")
	(SYNONYM REMOVE MACHINE COMPARTMENT T-REMOVER)
	(ADJECTIVE YOUR ODD SMALL T TEE TEA TEE-REMOVER TEA-REMOVER)
	(FLAGS VOWELBIT TAKEBIT TRYTAKEBIT CONTBIT SEARCHBIT NDESCBIT)
	(CAPACITY 60)
	(SIZE 8)
	(GENERIC GENERIC-MACHINE-F)
	(ACTION ODD-MACHINE-F)>

<ROUTINE ODD-MACHINE-F ("AUX" OBJ-IN-MACHINE)
	 <SET OBJ-IN-MACHINE <FIRST? ,ODD-MACHINE>>
	 <COND (<AND <VERB? BUY>
		     <IN? ,ODD-MACHINE ,SALESMAN>>
		<QUEUE I-SALESMAN 2>
		<TELL
"\"I wouldn't part with this baby for a hundred marsmids!\"" CR>)
	       (<AND <VERB? PUT>
		     <FSET? ,ODD-MACHINE ,OPENBIT>
		     <PRSI? ,ODD-MACHINE>>
		<COND (<AND .OBJ-IN-MACHINE
			    <NOT <PRSO? .OBJ-IN-MACHINE>>>
		       <TELL ,ONLY-ONE-THING-IN-COMPARTMENT>)
		      (<PRSO? ,BABY>
		       <TELL
"The baby cries so ferociously, you reconsider." CR>)
		      (<FIRST? ,PRSO>
		       <TELL
,YOULL-HAVE-TO "empty" T ,PRSO " first. " ,ONLY-ONE-THING-IN-COMPARTMENT>)>)
	       (<VERB? EXAMINE>
		<TELL "The " 'ODD-MACHINE " is off, and has a small, ">
		<OPEN-CLOSED ,ODD-MACHINE>
		<TELL " compartment">
		<COND (<AND .OBJ-IN-MACHINE
			    <FSET? ,ODD-MACHINE ,OPENBIT>>
		       <TELL " containing" A .OBJ-IN-MACHINE>)>
		<TELL ,PERIOD-CR>)
	       (<AND <VERB? TAKE OPEN ON>
		     <FSET? ,ODD-MACHINE ,TRYTAKEBIT>>
		<QUEUE I-SALESMAN 2>
		<TELL
"\"Hey!\" The salesman jumps back. \"No deal, no merchandise.\"" CR>)
	       (<VERB? BARTER-FOR>
		<COND (<PRSI? ,ODD-MACHINE>
		       <PERFORM ,V?GIVE ,PRSO ,SALESMAN>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?BARTER-WITH ,SALESMAN>
		       <RTRUE>)>)
	       (<VERB? OFF>
		<TELL ,ALREADY-IS>)
	       (<VERB? ON>
		<COND (<FSET? ,ODD-MACHINE ,OPENBIT>
		       <TELL ,NOTHING-HAPPENS>)
		      (T
		       <COND (<AND .OBJ-IN-MACHINE
				   <GETP .OBJ-IN-MACHINE ,P?NO-T-DESC>>
			      <COND (<EQUAL? .OBJ-IN-MACHINE ,TUBE ,TORCH>
				     <FSET .OBJ-IN-MACHINE ,VOWELBIT>)>
			      <COND (<EQUAL? .OBJ-IN-MACHINE ,TORCH>
				     <DEQUEUE I-TORCH>)>
			      <FCLEAR .OBJ-IN-MACHINE ,CONTBIT>
			      <FCLEAR .OBJ-IN-MACHINE ,SEARCHBIT>
			      <FCLEAR .OBJ-IN-MACHINE ,OPENBIT>
			      <FCLEAR .OBJ-IN-MACHINE ,READBIT>
			      <FCLEAR .OBJ-IN-MACHINE ,VEHBIT>
			      <FCLEAR .OBJ-IN-MACHINE ,WEARBIT>
			      <FCLEAR .OBJ-IN-MACHINE ,ONBIT>
			      <FCLEAR .OBJ-IN-MACHINE ,SURFACEBIT>
			      <FSET .OBJ-IN-MACHINE ,UNTEEDBIT>)
			     (<EQUAL? .OBJ-IN-MACHINE ,RABBIT>
			      <FSET ,RABBIT ,UNTEEDBIT>)>
		       <COND (<AND <EQUAL? .OBJ-IN-MACHINE ,CHOCOLATE>
				   <NOT <FSET? ,CHOCOLATE ,SMELLEDBIT>>>
			      ;"there's no T in it's DESC yet"
			      <FCLEAR ,CHOCOLATE ,UNTEEDBIT>)>
		       <TELL
"Sparks! Explosions! \"Pockita pockita pockita FEEP!\"
exclaims the machine." CR>)>)
	       (<AND <VERB? OPEN>
		     <IN? ,RABBIT ,ODD-MACHINE>
		     <FSET? ,RABBIT ,UNTEEDBIT>>
		<FSET ,ODD-MACHINE ,OPENBIT>
		<REMOVE ,RABBIT>
		<TELL
"A bearded rabbi wearing a prayer shawl leaps out of the machine, recites
a Torah blessing, and ">
		<COND (<EQUAL? ,HERE ,CANAL ,IN-SPACE>
		       <TELL "swim">)
		      (T
		       <TELL "dashe">)>
		<TELL "s off in search of a minyan." CR>)>>

<OBJECT BACK-DOOR-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "back door")
	(SYNONYM DOOR)
	(ADJECTIVE BACK REAR)
	(FLAGS DOORBIT LOCKEDBIT)
        (ACTION MAD-SCIENTIST-DOOR-F)>

<OBJECT FRONT-DOOR-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "front door")
	(SYNONYM DOOR)
	(ADJECTIVE FRONT)
	(FLAGS DOORBIT LOCKEDBIT)
	(ACTION MAD-SCIENTIST-DOOR-F)>

<ROUTINE MAD-SCIENTIST-DOOR-F ()
	 <COND (<AND <VERB? KNOCK>
		     <NOT <EQUAL? ,HERE ,LOOKS-CAN-BE-DECEIVING>>
		     <NOT <FSET? ,CAGE ,MUNGBIT>>>
		<FSET ,PRSO ,OPENBIT>
		<TELL
"The door is thrown open by a wild-eyed " 'MAD-SCIENTIST ". \"">
		<COND (<FSET? ,LOOKS-CAN-BE-DECEIVING ,TOUCHBIT>
		       <TELL
"Ach! You haf returned! Ve can continue der experiment!">)
		      (T
		       <TELL
"Nein! Nein! Nein! I don't need any!\" Then, taking a closer look at you
through spectacles thick enough to stop gamma rays, he says, \"Oh! Not ein
salesman! In fact, just der type I need for mein experiment.">)>
		<COND (<ULTIMATELY-IN? ,FLEXIBLE-HOLE>
		       <TELL " But leaf your ">
		       <COND (<IN? ,FLEXIBLE-HOLE ,TUBE>
			      <PRINTD ,TUBE>
			      <MOVE ,TUBE ,HERE>)
			     (T
			      <PRINTD ,FLEXIBLE-HOLE>
			      <MOVE ,FLEXIBLE-HOLE ,HERE>)>
		       <TELL
" outsite,\" he says, knocking it to the ground, \"I'm allergic.">)>
		<TELL
"\" He grips your wrist with surprising strength and drags you inside." CR CR>
		<MOVE ,MAD-SCIENTIST ,LOOKS-CAN-BE-DECEIVING>
		<GOTO ,LOOKS-CAN-BE-DECEIVING>)>>

<ROOM LOOKS-CAN-BE-DECEIVING
      (LOC ROOMS)
      (DESC "Looks Can Be Deceiving")
      (SOUTH TO FRONT-DOOR IF FRONT-DOOR-OBJECT IS OPEN)
      (NORTH TO BACK-DOOR IF BACK-DOOR-OBJECT IS OPEN)
      (DOWN TO LABORATORY)
      (FLAGS RLANDBIT ONBIT INDOORSBIT NARTICLEBIT)
      (GLOBAL STAIRS FRONT-DOOR-OBJECT BACK-DOOR-OBJECT HOUSE VENUS)
      (ACTION LOOKS-CAN-BE-DECEIVING-F)>

<ROUTINE LOOKS-CAN-BE-DECEIVING-F (RARG "AUX" (OPEN-DOOR <>))
	 <COND (<FSET? ,FRONT-DOOR-OBJECT ,OPENBIT>
		<SET OPEN-DOOR ,FRONT-DOOR-OBJECT>)
	       (<FSET? ,BACK-DOOR-OBJECT ,OPENBIT>
		<SET OPEN-DOOR ,BACK-DOOR-OBJECT>)>
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"From the innocent appearance of this quiet living area, you'd never guess
that all sorts of twisted, maniacal, perverted experiments are in progress
a short flight of stairs below. There are doors to the north">
		<COND (<EQUAL? .OPEN-DOOR ,BACK-DOOR-OBJECT>
		       <TELL " (open)">)>
		<TELL " and south">
		<COND (<EQUAL? .OPEN-DOOR ,FRONT-DOOR-OBJECT>
		       <TELL " (open)">)>
		<COND (<NOT .OPEN-DOOR>
		       <TELL ", both closed">)>
		<TELL ".">)
	       (<AND <EQUAL? .RARG ,M-END>
		     .OPEN-DOOR>
		<QUEUE I-MAD-SCIENTIST 2>
		<FCLEAR .OPEN-DOOR ,OPENBIT>
		<TELL
"   You feel uneasy as" T ,MAD-SCIENTIST " locks the door behind you
and dissolves the key in a vat of acid." CR>)>>

<OBJECT MAD-SCIENTIST
	(DESC "mad scientist")
	(DESCFCN MAD-SCIENTIST-F)
	(SYNONYM SCIENTIST)
	(ADJECTIVE MAD)
	(FLAGS ACTORBIT)
	(ACTION MAD-SCIENTIST-F)>

<ROUTINE MAD-SCIENTIST-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? ,IMPATIENCE-COUNTER 0>
		       <RFALSE>)
		      (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL "   The wild-eyed " 'MAD-SCIENTIST " is "
<GET ,MAD-SCIENTIST-DESCS ,MAD-SCIENTIST-COUNTER>>)
	       (<EQUAL? ,MAD-SCIENTIST ,WINNER>
		<COND (<OR <AND <VERB? WHAT>
				<PRSO? ,LGOP>>
			   <AND <VERB? TELL-ABOUT>
				<PRSO? ,ME>
				<PRSI? ,LGOP>>>
		       <TELL
"\"Eh?\" yells" T ,MAD-SCIENTIST ", cupping his ear. \"Heather bodices
of no-doze? Vat in heck are you jabbering about?\"" CR>)
		      (T
		       <TELL
"The " 'MAD-SCIENTIST " ignores you, cackling with inner glee." CR>
		       <STOP>)>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 17>>
		<DO-WALK ,P?NORTH>)>>

<CONSTANT MAD-SCIENTIST-DESCS
	<TABLE
"waiting impatiently for you to descend."
"stalking around the room, rubbing his hands and cackling madly."
"stalking around the room, rubbing his hands and cackling madly."
"watching you intently and scrawling an occasional note.">>

<GLOBAL MAD-SCIENTIST-COUNTER 0>

<GLOBAL IMPATIENCE-COUNTER 0>

<ROUTINE I-MAD-SCIENTIST ()
	 <TELL "   ">
	 <COND (<EQUAL? ,MAD-SCIENTIST-COUNTER 0>
		<SETG IMPATIENCE-COUNTER <+ ,IMPATIENCE-COUNTER 1>>
		<QUEUE I-MAD-SCIENTIST 2>
	 	<COND (<EQUAL? ,IMPATIENCE-COUNTER 1>
		       <TELL
"\"Let us retire to der laboratory,\" suggests" TR ,MAD-SCIENTIST>)
		      (<EQUAL? ,IMPATIENCE-COUNTER 2>
		       <TELL
"\"Downstairs, please,\" says" T ,MAD-SCIENTIST ", impatiently." CR>)
		      (<EQUAL? ,IMPATIENCE-COUNTER 3>
		       <TELL
"The " 'MAD-SCIENTIST ", fidgeting himself into a frenzy,
motions toward the stairs." CR>)
		      (T
		       <TELL
"The " 'MAD-SCIENTIST " loses his patience and opens
the trapdoor, dumping you">
		       <AND-SIDEKICK ,LABORATORY>
		       <TELL " down a chute" ,ELLIPSIS>
		       <GOTO ,LABORATORY>
		       <LABORATORY-F ,M-END>
		       <RTRUE>)>)
	       (<EQUAL? ,MAD-SCIENTIST-COUNTER 1>
		<MOVE ,PROTAGONIST ,FIRST-SLAB>
		<SETG OHERE <>>
		<QUEUE I-MAD-SCIENTIST 3>
		<SETG MAD-SCIENTIST-COUNTER 2>
		<SETG BODY-TIED-TO-SLAB T>
		<TELL
"Again exhibiting extraordinary strength," T ,MAD-SCIENTIST
" straps you down on" T ,FIRST-SLAB>
		<COND (<VISIBLE? ,SIDEKICK>
		       <MOVE ,SIDEKICK ,SECOND-SLAB>
		       <SETG SIDEKICKS-BODY-TIED-TO-SLAB T>
		       <TELL " and " D ,SIDEKICK " onto" T ,SECOND-SLAB>)>
		<TELL ,PERIOD-CR>)
	       (<EQUAL? ,MAD-SCIENTIST-COUNTER 2>
		<QUEUE I-MAD-SCIENTIST 6>
		<SETG MAD-SCIENTIST-COUNTER 3>
		<IDENTITY-TRANSFER>
		<TELL
"The " 'MAD-SCIENTIST " flips" T ,POWER-SWITCH ", and you suddenly find
yourself within the cage. Oddly, you can also see yourself still strapped
to" T ,FIRST-SLAB ". As you swing across the cage to get a better look,
you realize that you're now inside the body of a gorilla." CR>)
	       (<EQUAL? ,MAD-SCIENTIST-COUNTER 3>
		<MINE-THEORY>)>>

<ROOM LABORATORY
      (LOC ROOMS)
      (DESC "Laboratory")
      (UP PER LABORATORY-EXIT-F)
      (NORTH PER LAB-DOOR-ENTER-F)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL HOLE STAIRS HOUSE VENUS)
      (HOLE-DESTINATION VIZICOMM-BOOTH)
      (ACTION LABORATORY-F)
      ;(THINGS <PSEUDO (<> DOOR LAB-DOOR-F)
		      (<> STRAP STRAP-F)
		      (<> STRAPS STRAP-F)>)>

<OBJECT LAB-DOOR
      (LOC LABORATORY) 
      (DESC "lab door")
      (SYNONYM DOOR)
      (ADJECTIVE LAB)
      (FLAGS NDESCBIT)
      (ACTION LAB-DOOR-F)>

<OBJECT STRAPS
      (LOC LABORATORY)
      (DESC "strap")
      (SYNONYM STRAP STRAPS)
      (FLAGS NDESCBIT)
      (ACTION STRAP-F)>

<ROUTINE LABORATORY-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <QUEUED? ,I-ION-DEATH>>
		<FSET ,POWER-TRANSMITTER ,MUNGBIT>
		<QUEUE I-ION-DEATH 1> ;"explode before ape transfer not after")
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The scientist's madness is finally evident by his lab, filled with many
expressions of insane genius, such as the ">
		<COND (<AND <FSET? ,MALE-GORILLA ,NDESCBIT>
			    <FSET? ,FEMALE-GORILLA ,NDESCBIT>>
		       <TELL "two caged gorillas, one male and one female">)
		      (T
		       <TELL "cage">)>
		<TELL
", the two slabs for strapping down human victims, and" T ,POWER-SWITCH
". A closed door leads north; at the foot of the winding stone stairs
is" A ,HOLE ".">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,MAD-SCIENTIST ,LOOKS-CAN-BE-DECEIVING>>
		<FCLEAR ,MALE-GORILLA ,NDESCBIT> ;"for sake of room desc"
		<FCLEAR ,FEMALE-GORILLA ,NDESCBIT> ;"ditto"
		<MOVE ,MAD-SCIENTIST ,HERE>
		<QUEUE I-MAD-SCIENTIST 5>
		<SETG MAD-SCIENTIST-COUNTER 1>
		<TELL
"   The " 'MAD-SCIENTIST " bounds down from the first floor, activating
a (guaranteed 100% effective) Vaporo-Zap Energy Barrier across the foot
of the stairs." CR>)>>

<ROUTINE LAB-DOOR-ENTER-F ()
	 <DO-FIRST "open the door">
	 <RFALSE>>

<ROUTINE LAB-DOOR-F ()
	 <COND (<VERB? OPEN CLOSE>
		<PERFORM-PRSA ,BACK-DOOR-OBJECT> ;"very locked"
		<RTRUE>)
	       (<VERB? KNOCK>
		<PERFORM-PRSA ,WIDE-CELL-DOOR> ;"silence answers"
		<RTRUE>)>>

<ROUTINE STRAP-F ()
	 <COND (<VERB? UNTIE OPEN>
		<PERFORM ,V?UNTIE ,ME>
		<RTRUE>)>>

<OBJECT POWER-SWITCH
	(LOC LABORATORY)
	(DESC "huge red power switch")
	(SYNONYM SWITCH)
	(ADJECTIVE LARGE RED POWER)
	(FLAGS NDESCBIT)
	(ACTION POWER-SWITCH-F)>

<ROUTINE POWER-SWITCH-F ()
	 <COND (<AND <TOUCHING? ,POWER-SWITCH>
		     <NOT <IN? ,PROTAGONIST ,HERE>>>
	        <CANT-REACH ,POWER-SWITCH>)
	       (<AND <VERB? SET ON OFF THROW MOVE PUSH RAISE LOWER OPEN CLOSE>
		     <PRSO? ,POWER-SWITCH>>
		<COND (<IN? ,MAD-SCIENTIST ,HERE>
		       <TELL "The " 'MAD-SCIENTIST " stops you." CR>)
		      (T
		       <IDENTITY-TRANSFER>
		       <TELL "Zap! You're back in ">
		       <COND (,GONE-APE
			      <TELL "the body of the ">
			      <COND (<NOT ,MALE>
				     <TELL "fe">)>
			      <TELL 'MALE-GORILLA ".">)
			     (T
			      <COND (<NOT <FSET? ,RUBBER-HOSE ,MUNGBIT>>
				     <FSET ,RUBBER-HOSE ,MUNGBIT>
				     <INCREMENT-SCORE 19 24 T>)>
			      <MOVE ,MALE-GORILLA ,CAGE>
			      <MOVE ,FEMALE-GORILLA ,CAGE>
			      <TELL
"your own body! The gorilla looks confused and slinks back into the
comfortingly familiar environment of the cage.">)>
		       <COND (<AND ,BODY-TIED-TO-SLAB
				   <NOT ,SIDEKICKS-BODY-TIED-TO-SLAB>
				   <VISIBLE? ,SIDEKICK>>
			      <SETG BODY-TIED-TO-SLAB <>>
			      <MOVE ,SIDEKICK ,HERE>
			      <TELL
" " D ,SIDEKICK " rushes over and unties you.">)>
		       <CRLF>)>)>>

<ROUTINE IDENTITY-TRANSFER ()
	 <OPEN-EYES-AND-REMOVE-HANDS>
	 <COND (,GONE-APE
		<COND (,MALE
		       <ROB ,PROTAGONIST ,MALE-GORILLA>
		       <MOVE ,MALE-GORILLA <LOC ,PROTAGONIST>>
		       <FCLEAR ,MALE-GORILLA ,NDESCBIT>)
		      (T
		       <ROB ,PROTAGONIST ,FEMALE-GORILLA>		       
		       <MOVE ,FEMALE-GORILLA <LOC ,PROTAGONIST>>
		       <FCLEAR ,FEMALE-GORILLA ,NDESCBIT>)>
		<COND (<VISIBLE? ,SIDEKICKS-BODY>
		       <MOVE ,SIDEKICK <LOC ,SIDEKICKS-BODY>>
		       <REMOVE ,SIDEKICKS-BODY>)>
		<MOVE ,PROTAGONIST <LOC ,YOUR-BODY>>
		<SETG OHERE <>>
		<ROB ,YOUR-BODY ,PROTAGONIST>
		<REMOVE ,YOUR-BODY>
		<SETG GONE-APE <>>)
	       (T
		<SETG GONE-APE T>
		<MOVE ,YOUR-BODY <LOC ,PROTAGONIST>>
	 	<ROB ,PROTAGONIST ,YOUR-BODY>
		<COND (,MALE
		       <MOVE ,PROTAGONIST <LOC ,MALE-GORILLA>>
		       <FSET ,MALE-GORILLA ,NDESCBIT> ;"refer to it = you"
		       <ROB ,MALE-GORILLA ,PROTAGONIST>)
		      (T
		       <MOVE ,PROTAGONIST <LOC ,FEMALE-GORILLA>>
		       <FSET ,FEMALE-GORILLA ,NDESCBIT> ;"refer to it = you"
		       <ROB ,FEMALE-GORILLA ,PROTAGONIST>)>
		<SETG OHERE <>>
		<COND (<VISIBLE? ,SIDEKICK>
		       <MOVE ,SIDEKICKS-BODY <LOC ,SIDEKICK>>
		       <REMOVE ,SIDEKICK>)>)>>

<ROUTINE LABORATORY-EXIT-F ()
	 <JIGS-UP
"If you were a representative of the Vaporo-Zap Energy Barrier Company, you'd
be pleased to see that the firm's 100% effective guarantee had once again
proven to be a solid claim.">>

<OBJECT CAGE
	(LOC LABORATORY)
	(DESC "cage")
	(SYNONYM CAGE BAR BARS)
	(CAPACITY 200)
	(FLAGS NDESCBIT VEHBIT OPENBIT CONTBIT SEARCHBIT INBIT)
	(ACTION CAGE-F)>

<ROUTINE CAGE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The bars ">
		<COND (<FSET? ,CAGE ,MUNGBIT>
		       <TELL "have been" ,SPREAD-APART>)
		      (T
		       <TELL "seem sturdy">)>
		<TELL ,PERIOD-CR>)
	       (<AND <VERB? ENTER BOARD WALK-TO DISEMBARK LEAVE EXIT>
		     <EQUAL? ,HERE ,LABORATORY>
		     <NOT <FSET? ,CAGE ,MUNGBIT>>>
		<TELL "You don't fit between the bars." CR>)
	       (<OR <VERB? OPEN MUNG BEND>
		    <AND <VERB? MOVE>
			 <NOT <NOUN-USED ,W?CAGE ,CAGE>>>>
		<COND (<FSET? ,CAGE ,MUNGBIT>
		       <TELL ,SENILITY-STRIKES>)
		      (<NOT ,GONE-APE>
		       <TELL
"This cage was built to hold an ape! Mere human strength is
nothing against these bars!" CR>)
		      (T
		       <TELL "Bellowing madly, you pull at the bars! ">
		       <COND (<EQUAL? ,SUGAR-RUSH ,GORILLA-ATE-CHOCOLATE>
			      <FSET ,CAGE ,MUNGBIT>
			      <TELL "Slowly, they" ,SPREAD-APART ".">
			      <COND (<IN? ,MAD-SCIENTIST ,HERE>
				     <TELL " The " 'MAD-SCIENTIST>
				     <JIGS-UP
" yells, \"Mein Gott! Mad gorilla on der loose!\" He pulls out a ray
gun and puts a bolt through your chest.">)
				    (T
				     <CRLF>)>)
			     (T
			      <TELL
"They almost give, but you haven't got quite enough strength." CR>)>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,CAGE>
		     <EQUAL? <LOC ,PROTAGONIST> ,FIRST-SLAB ,SECOND-SLAB>>
		<CANT-REACH ,CAGE>)
	       (<VERB? REACH-IN>
		<COND (<IN? ,PROTAGONIST ,CAGE>
		       <TELL ,LOOK-AROUND>)
		      (<IN? ,RUBBER-HOSE ,CAGE>
		       <CANT-REACH ,RUBBER-HOSE>)>)>>

<GLOBAL BODY-TIED-TO-SLAB <>>

<GLOBAL SIDEKICKS-BODY-TIED-TO-SLAB <>>

<GLOBAL GONE-APE <>>

<GLOBAL GORILLA-EXAMINED <>>

<OBJECT MALE-GORILLA
	(LOC CAGE)
	(DESC "male gorilla")
	(SYNONYM GORILLA APE MONKEY)
	(ADJECTIVE MALE OTHER)
	(FLAGS ACTORBIT NDESCBIT OPENBIT CONTBIT SEARCHBIT)
	(GENERIC GENERIC-GORILLA-F)
	(ACTION GORILLA-F)>

<OBJECT FEMALE-GORILLA
	(LOC CAGE)
	(DESC "female gorilla")
	(SYNONYM GORILLA APE MONKEY)
	(ADJECTIVE FEMALE OTHER)
	(FLAGS ACTORBIT FEMALEBIT NDESCBIT OPENBIT CONTBIT SEARCHBIT)
	(GENERIC GENERIC-GORILLA-F)
	(ACTION GORILLA-F)>

<ROUTINE GORILLA-F ()
	 <COND (<AND ,GONE-APE
		     ,MALE
		     <PRSO? ,MALE-GORILLA>>
		<PERFORM-PRSA ,ME ,PRSI>
		<RTRUE>)
	       (<AND ,GONE-APE
		     ,MALE
		     <PRSI? ,MALE-GORILLA>>
		<PERFORM-PRSA ,PRSO ,ME>
		<RTRUE>)
	       (<AND ,GONE-APE
		     <NOT ,MALE>
		     <PRSO? ,FEMALE-GORILLA>>
		<PERFORM-PRSA ,ME ,PRSI>
		<RTRUE>)
	       (<AND ,GONE-APE
		     <NOT ,MALE>
		     <PRSI? ,FEMALE-GORILLA>>
		<PERFORM-PRSA ,PRSO ,ME>
		<RTRUE>)
	       (<VERB? TELL>
		<TELL "\"Ooo oo ee ee ee!\"" CR>
		<STOP>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,MALE-GORILLA ,FEMALE-GORILLA>>
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,FIRST-SLAB ,SECOND-SLAB>
		       <CANT-REACH ,PRSI>)
		      (T
		       <EAGERLY-ACCEPTS>
		       <TELL ,PERIOD-CR>)>)
	       (<VERB? EXAMINE>
		<COND (,GONE-APE
		       <SETG GORILLA-EXAMINED T>
		       <NOT-BAD-LOOKING>)
		      (T
		       <TELL "An uglier beast cannot possibly exist.">)>
		<COND (<FIRST? ,PRSO>
		       <TELL " ">
		       <RFALSE>)
		      (T
		       <CRLF>)>)
	       (<VERB? FUCK KISS TOUCH>
		<COND (<NOT ,GONE-APE>
		       <TELL "What a repulsive, bestial idea!" CR>)
		      (T
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       	      <TELL
"Normally, we wouldn't allow this in TAME mode, but it's okay in this
case since you're only a gorilla. This sort of thing appears all
the time in National Geographic.">)
			     (T
			      <COND (<NOT ,GORILLA-EXAMINED>
				     <SETG GORILLA-EXAMINED T>
				     <NOT-BAD-LOOKING>
				     <TELL " ">)>
			      <TELL
"You begin nuzzling, and things quickly get hot and heavy.">
			      <COND (<EQUAL? ,NAUGHTY-LEVEL 2>
				     <TELL
" The " 'PRSO " screams, \"Eee oo oo ah!\" which translates roughly
as \"Oh, you animal!\"">)>)>
		       <COND (<IN? ,MAD-SCIENTIST ,HERE>
			      <TELL " ">
			      <MINE-THEORY T>)
			     (T
		       	      <CRLF>)>)>)>>

<ROUTINE GENERIC-GORILLA-F ()
	 <COND (<NOT ,GONE-APE>
		<RFALSE>)
	       (,MALE
		<RETURN ,FEMALE-GORILLA>)
	       (T
		<RETURN ,MALE-GORILLA>)>>

<ROUTINE NOT-BAD-LOOKING ()
	 <TELL "Hey! The " 'PRSO " isn't bad-looking!">>

<ROUTINE MINE-THEORY ("OPTIONAL" (RIGHT <>))
	 <REMOVE ,MAD-SCIENTIST>
	 <DEQUEUE I-MAD-SCIENTIST>
	 <SETG FOLLOW-FLAG 17>
	 <QUEUE I-FOLLOW 2>
	 <TELL "\"Ach!\" yells" T ,MAD-SCIENTIST ", \"mein theory iss ">
	 <COND (.RIGHT
		<TELL "correct">)
	       (T
		<TELL "wronk">)>
	 <TELL "! Der sex drive uf a species resides in der b">
	 <COND (.RIGHT
		<TELL "ody">)
	       (T
		<TELL "rain">)>
	 <TELL ", not in der b">
	 <COND (.RIGHT
		<TELL "rain">)
	       (T
		<TELL "ody">)>
	 <TELL "!\" He dashes off." CR>
	 <COND (<VISIBLE? ,SIDEKICKS-BODY>
		<TELL
"   Through the briefly open door, you see two " 'FLYTRAP "s running madly
around the next room. One is chasing, while the other is frantically trying
to stay as far away as possible." CR>)>
	 <RTRUE>>

<OBJECT RUBBER-HOSE
	(LOC CAGE)
	(DESC "rubber hose")
	(SYNONYM HOSE)
	(ADJECTIVE RUBBER)
	(SIZE 3)
	(FLAGS TAKEBIT)
	(ACTION RUBBER-HOSE-F)>

<ROUTINE RUBBER-HOSE-F ()
	 <COND (<VERB? EXAMINE MEASURE>
		<TELL "The hose is around six feet long." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)>>

<OBJECT FIRST-SLAB
	(LOC LABORATORY)
	(DESC "first slab")
	(SYNONYM SLAB)
	(ADJECTIVE FIRST)
	(FLAGS NDESCBIT VEHBIT CONTBIT SURFACEBIT OPENBIT SEARCHBIT)
	(GENERIC GENERIC-SLAB-F)
	(CAPACITY 100)
	(ACTION FIRST-SLAB-F)>

<ROUTINE FIRST-SLAB-F ()
	 <COND (<AND <VERB? DISEMBARK>
		     <NOT ,GONE-APE>
		     ,BODY-TIED-TO-SLAB>
		<TELL "You're strapped down." CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,FIRST-SLAB>
		     <IN? ,PROTAGONIST ,CAGE>>
		<CANT-REACH ,FIRST-SLAB>)>>

<OBJECT SECOND-SLAB
	(LOC LABORATORY)
	(DESC "second slab")
	(SYNONYM SLAB)
	(ADJECTIVE SECOND)
	(GENERIC GENERIC-SLAB-F)
	(CAPACITY 100)
	(FLAGS NDESCBIT VEHBIT CONTBIT SURFACEBIT OPENBIT SEARCHBIT)
	(ACTION SECOND-SLAB-F)>

<ROUTINE SECOND-SLAB-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <PRSI? ,SECOND-SLAB>
		     <IN? ,PROTAGONIST ,CAGE>>
		<CANT-REACH ,SECOND-SLAB>)>>

<ROUTINE GENERIC-SLAB-F ()
	 <COND (<EQUAL? <LOC ,PROTAGONIST> ,FIRST-SLAB ,SECOND-SLAB>
		<RETURN <LOC ,PROTAGONIST>>)
	       (T
		<RFALSE>)>>

<OBJECT YOUR-BODY
	(DESC "your body")
	(SYNONYM BODY)
	(ADJECTIVE YOUR MY)
	(FLAGS NARTICLEBIT CONTBIT ACTORBIT SEARCHBIT OPENBIT)
	(ACTION YOUR-BODY-F)>

<ROUTINE YOUR-BODY-F ()
	 <COND (<VERB? TELL>
		<PERFORM-PRSA ,MALE-GORILLA>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "Your body">
		<COND (<IN? ,YOUR-BODY ,FIRST-SLAB>
		       <TELL " on" T ,FIRST-SLAB>)>
		<TELL
" is grunting, scratching itself with its foot, and looking
around the room for a banana." CR>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,YOUR-BODY>>
		<EAGERLY-ACCEPTS>
		<TELL ,PERIOD-CR>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,YOUR-BODY>>
		<TELL "Carrying " 'YOUR-BODY " around">
		<HO-HUM>)
	       (<AND <VERB? TIE>
		     <PRSO? ,FIRST-SLAB ,SECOND-SLAB>
		     <NOT ,BODY-TIED-TO-SLAB>>
		<COND (<PRSO? ,SECOND-SLAB>
		       <TELL "[the first slab is closer]" CR>)>
		<SETG BODY-TIED-TO-SLAB T>
		<NOW-TIED ,FIRST-SLAB>)
	       (<VERB? UNTIE>
		<COND (<IN? ,PROTAGONIST ,CAGE>
		       <CANT-REACH ,YOUR-BODY>)
		      (,GONE-APE
		       <COND (,BODY-TIED-TO-SLAB
			      <SETG BODY-TIED-TO-SLAB <>>
			      <TELL
"Your body leaps for a rafter and lands back on" T ,FIRST-SLAB " with a loud
\"whump,\" looking momentarily stunned." CR>)
			     (T
			      <TELL ,SENILITY-STRIKES>)>)
		      (,BODY-TIED-TO-SLAB
		       <YUKS>)
		      (T
		       <TELL "Your body isn't tied down!" CR>)>)>>

<OBJECT SIDEKICKS-BODY
	(SDESC "")
	(SYNONYM BODY TRENT TIFFANY TIFF)
	(ADJECTIVE TRENT\'S TIFFANY\'S TIFF\'S)
	(FLAGS NARTICLEBIT CONTBIT ACTORBIT SEARCHBIT OPENBIT)
	(GENERIC GENERIC-SIDEKICK-F)
	(ACTION SIDEKICKS-BODY-F)>

<ROUTINE SIDEKICKS-BODY-F ()
	 <COND (<VERB? EXAMINE>
		<HIS-HER T>
		<TELL
" eyes are darting around the room, as though following a fly." CR>)
	       (<VERB? TIE>
		<COND (<AND <PRSO? ,SECOND-SLAB>
		     	    ,SIDEKICKS-BODY-TIED-TO-SLAB>
		       <TELL D ,SIDEKICK " already is!" CR>)
		      (<AND <PRSO? ,SECOND-SLAB>
			    ,GONE-APE>
		       <SETG SIDEKICKS-BODY-TIED-TO-SLAB T>
		       <NOW-TIED ,SECOND-SLAB>)
		      (T
		       <WASTES>)>)
	       (<VERB? UNTIE>
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,CAGE ,FIRST-SLAB>
		       <CANT-REACH ,SIDEKICKS-BODY>)
		      (,GONE-APE
		       <COND (,SIDEKICKS-BODY-TIED-TO-SLAB
			      <SETG SIDEKICKS-BODY-TIED-TO-SLAB <>>
			      <TELL
"As you untie " D ,SIDEKICKS-BODY ", it attempts to wrap
its arms around you as though they were tentacles." CR>)
			     (T
			      <TELL ,SENILITY-STRIKES>)>)
		      (T
		       <TELL D ,SIDEKICKS-BODY " isn't tied down!" CR>)>)>>

<ROOM ROCKY-CLIFFTOP
      (LOC ROOMS)
      (DESC "Rocky Clifftop")
      (NW TO VIZICOMM-BOOTH)
      (NORTH TO BACK-DOOR)
      (WEST TO FRONT-DOOR)
      (DOWN SORRY
"Stepping off the cliff would mean a fatal plunge to the jungle below.")
      (EAST SORRY
"Stepping off the cliff would mean a fatal plunge to the jungle below.")
      (SE SORRY
"Stepping off the cliff would mean a fatal plunge to the jungle below.")
      (SOUTH SORRY
"Stepping off the cliff would mean a fatal plunge to the jungle below.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HOLE TREE BOOTH-OBJECT VENUS)
      (HOLE-DESTINATION ROYAL-DOCKS)
      (ACTION ROCKY-CLIFFTOP-F)
      ;(THINGS <PSEUDO (ROCKY CLIFF CLIFF-OBJECT-F)>)>

<OBJECT CLIFF-OBJECT
      (LOC ROCKY-CLIFFTOP) 
      (DESC "cliff")
      (SYNONYM CLIFF CLIFFTOP)
      (ADJECTIVE ROCKY)
      (FLAGS NDESCBIT)
      (ACTION CLIFF-OBJECT-F)>

<ROUTINE ROCKY-CLIFFTOP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Even the most adaptable Venusian flora can't gain a foothold on this
outcropping, so the jungle (which can be entered to the north or west)
peters out here. To the southeast, your clifftop vantage offers a stunning
view of more lush jungle, stretching unbroken to the horizon.|
   To the northwest, between the two paths into the jungle, is a vizicomm
booth. At the edge of the cliff is" A ,HOLE ".">)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,GONE-APE>
		<JIGS-UP
"   A tranquilizer dart pierces your rump and you spend your remaining years
in the gorilla cage of the Venusian Planetary Zoo.">)>>

<ROUTINE CLIFF-OBJECT-F ()
	 <COND (<VERB? LEAP-OFF>
		<SETG PRSO <>>
		<V-LEAP>)
	       (<VERB? EXAMINE>
		<V-LOOK>)>>

<OBJECT BOOTH-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "booth")
	(SYNONYM BOOTH)
	(ADJECTIVE VIZICOMM SMALL)
	(ACTION BOOTH-OBJECT-F)>

<ROUTINE BOOTH-OBJECT-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,ROCKY-CLIFFTOP>
		       <DO-WALK ,P?NW>)
		      (<EQUAL? ,HERE ,VIZICOMM-BOOTH>
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,ROCKY-CLIFFTOP>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?SE>)>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,VIZICOMM-BOOTH>>
		<V-LOOK>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)
	       (<AND <VERB? LOOK-INSIDE>
		     <EQUAL? ,HERE ,ROCKY-CLIFFTOP>>
		<TELL ,CANT-FROM-HERE>)>>

<ROOM VIZICOMM-BOOTH
	(LOC ROOMS)
	(DESC "Vizicomm Booth")
	(SE TO ROCKY-CLIFFTOP)
	(OUT TO ROCKY-CLIFFTOP)
	(FLAGS ONBIT RLANDBIT)
	(GLOBAL SIGN BOOTH-OBJECT VENUS)
	(ACTION VIZICOMM-BOOTH-F)
	;(THINGS <PSEUDO (<> DIAL DIAL-F)
			(COIN SLOT COIN-SLOT-F)>)>

<OBJECT DIAL 
      (LOC VIZICOMM-BOOTH)
      (DESC "dial")
      (SYNONYM DIAL)
      (FLAGS NDESCBIT)
      (ACTION DIAL-F)>

<OBJECT COIN-SLOT
      (LOC VIZICOMM-BOOTH)
      (DESC "coin slot")
      (SYNONYM SLOT)
      (ADJECTIVE COIN)
      (FLAGS NDESCBIT)
      (ACTION COIN-SLOT-F)>

<ROUTINE VIZICOMM-BOOTH-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This small booth, which opens to the southeast, contains" ,VIZICOMM-DESC
" A red sign is posted over the vizicomm.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,GONE-APE
		     <VISIBLE? ,FLEXIBLE-HOLE>>
		;"since trank dart doesn't usually get you until Clifftop"
		<ROCKY-CLIFFTOP-F ,M-END>)>>

<OBJECT VIZICOMM
	(LOC VIZICOMM-BOOTH)
	(DESC "vizicomm")
	(SYNONYM VIZICOMM)
	(ADJECTIVE PAY)
	(FLAGS NDESCBIT)
	(ACTION VIZICOMM-F)>

<ROUTINE VIZICOMM-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's" ,VIZICOMM-DESC CR>)
	       (<VERB? SET>
		<TELL "The dial is stuck and won't turn." CR>)>>

<ROUTINE DIAL-F ()
	 <COND (<VERB? SET MOVE>
		<PERFORM ,V?SET ,VIZICOMM>
		<RTRUE>)
	       (<VERB? TAKE>
		<TELL ,PART-OF-VIZICOMM>)>>

<ROUTINE COIN-SLOT-F ()
	 <COND (<VERB? TAKE>
		<TELL ,PART-OF-VIZICOMM>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,ONLY-BLACKNESS>)
	       (<AND <VERB? PUT>
		     <PRSO? ,TEN-MARSMID-COIN ,ONE-MARSMID-COIN>>
		<MOVE ,PRSO ,COIN-RETURN-KNOB>
		<TELL "\"Clink.\"" CR>)>>

<OBJECT HANDSET
	(LOC VIZICOMM-BOOTH)
	(DESC "handset")
	(SYNONYM HANDSET)
	(FLAGS NDESCBIT)
	(ACTION HANDSET-F)>

<ROUTINE HANDSET-F () 
	 <COND (<VERB? PICK-UP LISTEN RAISE PICK-UP>
		<TELL "There's no dial tone." CR>)
	       (<VERB? TAKE>
		<TELL ,PART-OF-VIZICOMM>)>>

<OBJECT COIN-RETURN-KNOB
	(LOC VIZICOMM-BOOTH)
	(DESC "coin return knob")
	(SYNONYM KNOB)
	(ADJECTIVE COIN RETURN)
	(FLAGS NDESCBIT)
	(ACTION COIN-RETURN-KNOB-F)>

<ROUTINE COIN-RETURN-KNOB-F ("AUX" (COIN <>))
	 <COND (<VERB? PUSH MOVE SET>
		<COND (<SET COIN <FIRST? ,COIN-RETURN-KNOB>>
		       <MOVE .COIN ,COIN-RETURN-BOX>
		       <TELL "\"Clank.\"" CR>)
		      (T
		       <TELL ,NOTHING-HAPPENS>)>)
	       (<VERB? TAKE>
		<TELL ,PART-OF-VIZICOMM>)>>

<OBJECT COIN-RETURN-BOX
	(LOC VIZICOMM-BOOTH)
	(DESC "coin return box")
	(SYNONYM BOX)
	(ADJECTIVE COIN RETURN)
	(FLAGS NDESCBIT CONTBIT)
	(CAPACITY 1)
	(ACTION COIN-RETURN-BOX-F)>

<ROUTINE COIN-RETURN-BOX-F ("AUX" (COIN <>))
	 <COND (<VERB? LOOK-INSIDE REACH-IN SEARCH OPEN>
		<COND (<SET COIN <FIRST? ,COIN-RETURN-BOX>>
		       <MOVE .COIN ,HERE>
		       <THIS-IS-IT .COIN>
	               <TELL "A coin falls to the ground!" CR>)
		      (T
		       <TELL
"The box is empty. Upon letting go, it swings shut." CR>)>)>>

<OBJECT TEN-MARSMID-COIN
	(LOC COIN-RETURN-KNOB)
	(DESC "coin")
	(SYNONYM COIN MARSMID MONEY)
	(ADJECTIVE TEN MARSMID)
	(FLAGS TAKEBIT READBIT)
	(GENERIC GENERIC-COIN-F)
	(TEXT "The coin reads \"Ten Marsmids.\"")>

<OBJECT ONE-MARSMID-COIN
	(DESC "coin")
	(SYNONYM COIN MARSMID MONEY)
	(ADJECTIVE ONE MARSMID)
	(FLAGS TAKEBIT READBIT)
	(GENERIC GENERIC-COIN-F)
	(TEXT "The coin reads \"One Marsmid.\"")>

<ROUTINE GENERIC-COIN-F () ;"ambiguity can occur due to MOBY-FIND verbs"
	 ,ONE-MARSMID-COIN>
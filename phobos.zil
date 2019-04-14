"PHOBOS for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

;"NOTE: my calculations indicate that the surface gravity of Phobos is
approximately .175 cm/sec/sec, or about 1/5000th the surface gravity of Earth."

<OBJECT CELL-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "cell")
	(SYNONYM CELL)
	(ADJECTIVE PRISON OTHER)
	(ACTION CELL-OBJECT-F)>

<ROUTINE CELL-OBJECT-F ()
	 <COND (<VERB? ENTER BOARD WALK-TO>
		<COND (<OR <ADJ-USED ,W?OTHER>
			   <ADJ-USED ,W?SMALL>>
		       <COND (<EQUAL? ,HERE ,OTHER-CELL>
			      <TELL ,LOOK-AROUND>)
			     (<EQUAL? ,HERE ,END-OF-HALLWAY>
			      <DO-WALK ,P?SOUTH>)
			     (T
			      <TELL ,CANT-FROM-HERE>)>)
		      (<EQUAL? ,HERE ,CELL>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,END-OF-HALLWAY>
		       <DO-WALK ,P?NORTH>)
		       (T
		       <TELL ,CANT-FROM-HERE>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<OR <ADJ-USED ,W?OTHER>
			   <ADJ-USED ,W?SMALL>>
		       <COND (<EQUAL? ,HERE ,OTHER-CELL>
			      <DO-WALK ,P?NORTH>)
			     (T
			      <TELL ,LOOK-AROUND>)>)
		      (<EQUAL? ,HERE ,CELL>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE ,OTHER-CELL>
		       <DO-WALK ,P?NORTH>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<AND <VERB? EXAMINE>
		     <NOT <EQUAL? ,HERE ,END-OF-HALLWAY>>>
		<V-LOOK>)
	       (<VERB? LOOK-INSIDE OPEN CLOSE>
		<COND (<EQUAL? ,HERE ,END-OF-HALLWAY>
		       <COND (<OR <ADJ-USED ,W?OTHER>
				  <ADJ-USED ,W?SMALL>>
			      <PERFORM-PRSA ,NARROW-CELL-DOOR>)
			     (T
			      <PERFORM-PRSA ,WIDE-CELL-DOOR>)>)
		      (<VERB? LOOK-INSIDE>
		       <V-LOOK>)
		      (<EQUAL? ,HERE ,CELL>
		       <PERFORM-PRSA ,WIDE-CELL-DOOR>)
		      (T
		       <PERFORM-PRSA ,NARROW-CELL-DOOR>)>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,CELL-OBJECT>>
		<COND (<EQUAL? ,HERE ,END-OF-HALLWAY>
		       <TELL ,CANT-FROM-HERE>)
		      (T
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)>)
	       (<AND <NOT <EQUAL? ,HERE ,END-OF-HALLWAY>>
		     <PRSO? ,CELL-OBJECT>>
		<PERFORM-PRSA ,GLOBAL-ROOM ,PRSI>
		<RTRUE>)>>

<ROOM CELL
      (LOC ROOMS)
      (DESC "Cell")
      (SOUTH TO END-OF-HALLWAY IF WIDE-CELL-DOOR IS OPEN)
      (OUT TO END-OF-HALLWAY IF WIDE-CELL-DOOR IS OPEN)
      (UP PER HOLE-ENTER-F)
      (FLAGS ONBIT RLANDBIT INDOORSBIT)
      (GLOBAL WIDE-CELL-DOOR HOLE CELL-OBJECT)
      (HOLE-DESTINATION MAIN-HALL-OF-PALACE)
      (ACTION CELL-F)>

<ROUTINE CELL-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a large cell with a soft, cushiony floor. A wide door (">
		<COND (<FSET? ,WIDE-CELL-DOOR ,OPENBIT>
		       <TELL "now open">)
		      (<FSET? ,WIDE-CELL-DOOR ,TOUCHBIT>
		       <TELL "now closed">)
		      (T
		       <TELL "closed, naturally">)>
		<TELL ") forms the southern wall of the cell">
		<COND (,HOLE-OPEN
		       <TELL
". A " D ,HOLE " is lying on the ground amidst some rubble">)>
		<TELL ".">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT ,TRAY-DELIVERED>>
		<SETG TRAY-DELIVERED T>
		<MOVE ,TRAY ,HERE>
		<TELL
"   Someone thrusts a tray into your cell. A " D ,CHOCOLATE " on the tray"
,LOOKS-UNAPPETIZING>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,SIDEKICK ,HERE>
		     <NOT ,CELL-GRIPE>>
		<SETG CELL-GRIPE T>
		<TELL
"   \"What a great cell!\" says " D ,SIDEKICK ", looking around. \"Why
didn't I get a cell like this? Maybe I shouldn't have kicked that guard ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 1>
		       <TELL "below the waist ">)
		      (<EQUAL? ,NAUGHTY-LEVEL 2>
		       <TELL "in the nuts ">)>
		<TELL "when I first got here...\"" CR>)>>

<ROUTINE HOLE-ENTER-F ()
	 <COND (,HOLE-OPEN
		<TELL ,YOU-CANT "reach the hole in the ceiling." CR>)
	       (T
		<TELL ,CANT-GO>)>
	 <RFALSE>>

<GLOBAL CELL-GRIPE <>>

<GLOBAL TRAY-DELIVERED <>>

<OBJECT BLANKET
	(LOC CELL)
	(DESC "blanket")
	(NO-T-DESC "blanke")
	(SYNONYM BLANKET)
	(FLAGS TAKEBIT BURNBIT)
	(ACTION BLANKET-F)>

<ROUTINE BLANKET-F ()
	 <COND (<FSET? ,BLANKET ,UNTEEDBIT>
		<RFALSE>)
	       (<VERB? MEASURE>
		<TELL "Small." CR>)
	       (<OR <VERB? WEAR>
		    <AND <VERB? WRAP>
			 <PRSI? ,ME>>>
		<TELL
"It's too small; your jailors must have meant it to be used as a pillow." CR>)
	       (<VERB? BOARD>
		<WASTES>)
	       (<VERB? TIE>
		<TELL "The material of the blanket is too thick to knot." CR>)
	       (<AND <VERB? REMOVE TAKE>
		     <IN? ,BLANKET ,BABY>>
		<PERFORM ,V?REMOVE ,BABY>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,BASKET>>
		<COND (<IN? ,BLANKET ,BABY>
		       <PERFORM-PRSA ,BABY ,BASKET>
		       <RTRUE>)
		      (<IN? ,BABY ,BASKET>
		       <MOVE ,BLANKET ,BASKET>
		       <MOVE ,BABY ,PROTAGONIST>
		       <PERFORM-PRSA ,BABY ,BASKET>
		       <RTRUE>)>)
	       (<AND <VERB? DROP PUT THROW>
		     <PRSO? ,BLANKET>
		     <IN? ,BLANKET ,BABY>>
		<DO-FIRST "unwrap the baby">)
	       (<AND <VERB? LOOK-INSIDE>
		     <IN? ,BLANKET ,BABY>>
		<PERFORM ,V?ALARM ,BABY>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,BLANKET>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<WASTES>)>>

<OBJECT PAINTING
	(LOC CELL)
	(DESC "painting")
	(FDESC "Hanging on the wall is a painting of a pussy cat.")
	(NO-T-DESC "paining")
	(SYNONYM PAINTING PICTURE CAT PAINING)
	(ADJECTIVE PUSSY ART)
	(FLAGS TAKEBIT BURNBIT)
	(ACTION PAINTING-F)>

<ROUTINE PAINTING-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <NOT <FSET? ,PAINTING ,UNTEEDBIT>>>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "It's a good likeness of a pussy, but is it art?" CR>)>>

<OBJECT TRAY
	(DESC "tray")
	(NO-T-DESC "ray")
	(SYNONYM TRAY RAY)
	(FLAGS TAKEBIT SURFACEBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 20)
	(ACTION TRAY-F)>

<ROUTINE TRAY-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <FSET? ,TRAY ,UNTEEDBIT>>
		<TELL
"It looks a little like Ray whatsisname from second grade." CR>)>>

<OBJECT CHOCOLATE
	(LOC TRAY)
	(SDESC "hunk of brown food")
	(NO-T-DESC "hunk of chocolae")
	(SYNONYM FOOD HUNK CHOCOLATE CANDY)
	(ADJECTIVE BROWN LUSCIOUS MILK CREAMY)
	(FLAGS TAKEBIT)
	(ACTION CHOCOLATE-F)>

<GLOBAL CHOCOLATE-IDENTIFIED <>>

<GLOBAL SUGAR-RUSH <>>

<CONSTANT HUMAN-ATE-CHOCOLATE 1>

<CONSTANT GORILLA-ATE-CHOCOLATE 2>

<ROUTINE CHOCOLATE-F ()
	 <COND (<FSET? ,CHOCOLATE ,UNTEEDBIT>
		<RFALSE>)
	       (<VERB? EAT>
		<COND (<NOT <ULTIMATELY-IN? ,CHOCOLATE>>
		       <TELL ,YNH " it!" CR>
		       <RTRUE>)>
		<REMOVE ,CHOCOLATE>
	 	<QUEUE I-UNRUSH 6>
		<COND (,GONE-APE
		       <SETG SUGAR-RUSH ,GORILLA-ATE-CHOCOLATE>)
		      (T
		       <SETG SUGAR-RUSH ,HUMAN-ATE-CHOCOLATE>)>
		<TELL "Mmmm! ">
		<COND (,CHOCOLATE-IDENTIFIED
		       <TELL "G">)
		      (T
		       <TELL "It's a piece of really g">)>
		<TELL
"ood chocolate! You feel yourself getting a sugar rush." CR>)
	       (<VERB? EXAMINE>
		<TELL "The " D ,CHOCOLATE ,LOOKS-UNAPPETIZING>)
	       (<VERB? TASTE>
		<SETG CHOCOLATE-IDENTIFIED T>
		<PUTP ,CHOCOLATE ,P?SDESC "hunk of chocolate">
		<RFALSE> ;"It tastes just like...")
	       (<AND <VERB? SMELL>
		     <NOT <FSET? ,CHOCOLATE ,SMELLEDBIT>>>
		<SETG CHOCOLATE-IDENTIFIED T>
		<FSET ,CHOCOLATE ,SMELLEDBIT>
		<PUTP ,CHOCOLATE ,P?SDESC "hunk of chocolate">
		<SCRATCH-N-SNIFF 2>
		<TELL "Luscious, creamy milk chocolate!" CR>)>>

<ROUTINE I-UNRUSH ()
	 <COND (<OR <AND ,GONE-APE
			 <EQUAL? ,SUGAR-RUSH ,GORILLA-ATE-CHOCOLATE>>
		    <AND <NOT ,GONE-APE>
			 <EQUAL? ,SUGAR-RUSH ,HUMAN-ATE-CHOCOLATE>>>
		<SETG SUGAR-RUSH <>>
	 	<TELL "   You feel the sugar rush ebb." CR>)
	       (T
		<SETG SUGAR-RUSH <>>
		<RFALSE>)>>

<OBJECT WIDE-CELL-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "wide cell door")
	(SYNONYM DOOR)
	(ADJECTIVE NORTH WIDE CELL)
	(FLAGS DOORBIT)>

<ROOM OTHER-CELL
      (LOC ROOMS)
      (DESC "Other Cell")
      (NORTH TO END-OF-HALLWAY IF NARROW-CELL-DOOR IS OPEN)
      (OUT TO END-OF-HALLWAY IF NARROW-CELL-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL NARROW-CELL-DOOR CELL-OBJECT)
      (ACTION OTHER-CELL-F)>

<ROUTINE OTHER-CELL-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,OTHER-CELL ,TOUCHBIT>>>
		<THIS-IS-IT ,SIDEKICK>
		<QUEUE I-BLUEPRINT 19>
		<COND (<EQUAL? ,VERBOSITY 0>
		       <RFALSE>)>
		<TELL "As you enter, a ">
		<COND (<NOT ,MALE>
		       <TELL "wo">)>
		<TELL
"man sitting limply in the shadows stiffens and rises to ">
		<HIS-HER>
		<TELL
" feet. \"A human! They got you too? I've been here a week. When you opened the
door, I figured it was a guard! Was it unlocked? I never thought of trying it.
By the way, my name's " D ,SIDEKICK ". From Alaska. I'm not too bright, but I'm
strong as an ox, and I'm great with my hands. Maybe we can lick these Leather
Goddesses together.\"" CR CR>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a very tiny room with a rock-hard floor. A " 'NARROW-CELL-DOOR
" to the north is ">
		<OPEN-CLOSED ,NARROW-CELL-DOOR>
		<TELL ".">)>>

<OBJECT NARROW-CELL-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "narrow cell door")
	(SYNONYM DOOR)
	(ADJECTIVE SOUTH NARROW CELL)
	(FLAGS DOORBIT)
	(ACTION NARROW-CELL-DOOR-F)>

<ROUTINE NARROW-CELL-DOOR-F ()
	 <COND (<AND <VERB? KNOCK>
		     <IN? ,SIDEKICK ,OTHER-CELL>>
		<TELL
"A muffled voice responds, \"Beat it, you alien fruitcake freako
mutant weirdo scum!\"" CR>)>>

<OBJECT SIDEKICK
	(LOC OTHER-CELL)
	(SDESC "")
	(DESCFCN SIDEKICK-F)
	(SYNONYM TIFFANY TIFF TRENT BODY)
	(ADJECTIVE TRENT\'S TIFFANY\'S TIFF\'S)
	(FLAGS NARTICLEBIT ACTORBIT CONTBIT OPENBIT SEARCHBIT)
	(GENERIC GENERIC-SIDEKICK-F)
	(ACTION SIDEKICK-F)>

<ROUTINE SIDEKICK-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL "   " D ,SIDEKICK " is here, ">
		<SIDEKICK-DESC>
		<TELL ".">)
	       (<EQUAL? ,SIDEKICK ,WINNER>
		<COND (<VERB? WHAT>
		       <PERFORM ,V?TELL-ABOUT ,ME ,PRSO>
		       <RTRUE>)
		      (<AND <VERB? READ>
			    <PRSO? ,SCRAP-OF-PAPER>>
		       <PERFORM ,V?TELL-ABOUT ,ME ,SCRAP-OF-PAPER>
		       <RTRUE>)
		      (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>>
		       <COND (<AND <PRSI? ,ODD-MACHINE>
				   <NOT <IN? ,ODD-MACHINE ,SALESMAN>>>
			      <TELL
"\"Hmmm, tee remover. For cleaning up golf courses?\"" CR>)
			     (<PRSI? ,SCRAP-OF-PAPER>
			      <TELL
"\"I dunno what it means; I doodled it one night in my sleep!\"" CR>)
			     (<AND <PRSI? ,MATCHBOOK>
				   <NOT <QUEUED? ,I-BLUEPRINT>>>
			      <SCRAPE-UP-THESE-ITEMS>)
			     (<PRSI? ,LGOP>
			      <TELL
"\"No doubt some gang of interplanetary floozies who get their jollies
from enslaving defenseless planets. We'll stop 'em!\"" CR>)
			     (T
			      <TELL
D ,SIDEKICK " shrugs. \"What do I know? I'm from Alaska,\" ">
			      <HE-SHE>
			      <TELL
" says, in a burst of insecurity that will no doubt ease in a quarter century
or so when Alaska becomes a state." CR>)>)
		      (<VERB? WALK>
		       <TELL "\"After you!\"" CR>)
		      (<AND <VERB? FOLLOW>
			    <PRSO? ,ME>>
		       <TELL "\"Lead on!\"" CR>)
		      (<VERB? HELLO>
		       <TELL "\"Hi!\"" CR>)
		      (<AND <VERB? DISEMBARK ENTER EXIT>
			    <PRSO? ,WINDOW>
			    <EQUAL? ,HERE ,BEDROOM>>
		       <COND (,SIDEKICK-TRIP-FLAG
			      <TELL "\"Not again!\"" CR>)
			     (<QUEUED? ,I-SIDEKICK-OUT-WINDOW>
			      <TELL "\"Gimme a second to get ready!\"" CR>)
			     (T
			      <TELL "\"I'm dumb, but not that dumb!\"" CR>)>)
		      (<AND <VERB? KISS>
			    <PRSO? ,FROG>>
		       <TELL "\"I'd sooner kiss a pig!\"" CR>)
		      (<AND <VERB? RAISE>
			    <PRSO? ,ME>
			    <EQUAL? <LOC ,PROTAGONIST> ,TREE-HOLE ,CLOSET>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?CLIMB-ON ,SIDEKICK>
		       <SETG WINNER ,SIDEKICK>
		       <RTRUE>)
		      (<AND <VERB? TAKE>
			    <PRSO? ,HEADLIGHT>
			    <FSET? ,HEADLIGHT ,TRYTAKEBIT>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?SHOW ,HEADLIGHT ,SIDEKICK>
		       <SETG WINNER ,SIDEKICK>
		       <RTRUE>)
		      (<AND <VERB? GIVE>
			    <PRSI? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ASK-FOR ,SIDEKICK ,PRSO>
		       <SETG WINNER ,SIDEKICK>
		       <RTRUE>)
		      (<VERB? SGIVE>
		       <RFALSE>)
		      (<AND <VERB? MAKE>
			    <PRSO? ,ANTI-LGOP-MACHINE>>
		       <TELL "\"Don't crowd me.\"" CR>)
		      (T
		       <TELL D ,SIDEKICK " is ">
		       <SIDEKICK-DESC>
		       <TELL " and fails to notice that you've spoken." CR>
		       <STOP>)>)
	       (<WRONG-SEX-WORD ,SIDEKICK ,W?TRENT ,W?TIFFANY>
		<STOP>)
	       (<WRONG-SEX-WORD ,SIDEKICK ,W?TRENT ,W?TIFF>
		<STOP>)		 
	       (<VERB? EXAMINE>
		<TELL D ,SIDEKICK " is about your age">
		<COND (<NOT <EQUAL? ,NAUGHTY-LEVEL 0>>
		       <TELL
" and has a body worthy of envy: tall and well-built, with wide shoulders, ">
		       <COND (,MALE
			      <TELL "massive pectorals, and thick">)
			     (T
			      <TELL "a generous bosom, slim waist, and long">)>
		       <TELL
", tawny legs. The only minus seems to be slightly oversized feet, but even
oversized feet are a plus if you're into toe-sucking">)>
		<TELL ".">
		<COND (<FIRST? ,SIDEKICK>
		       <TELL " ">
		       <RFALSE>)
		      (T
		       <CRLF>)>)
	       (<AND <VERB? ASK-FOR>
		     <PRSO? ,SIDEKICK>>
		<COND (<ULTIMATELY-IN? ,PRSI ,SIDEKICK>
		       <MOVE ,PRSI ,PROTAGONIST>
		       <TELL "\"What's mine is yours!\"" CR>)
		      (T
		       <TELL "\"I haven't got" A ,PRSI "!\"" CR>)>)
	       (<VERB? FOLLOW>
		<COND (<EQUAL? ,FOLLOW-FLAG 1>
		       <PERFORM ,V?CLIMB-DOWN ,SHEET>
		       <RTRUE>)
		      (<EQUAL? ,FOLLOW-FLAG 2>
		       <TELL ,DONT-WANT-TO>)
		      (<EQUAL? ,FOLLOW-FLAG 3>
		       <PERFORM ,V?ENTER ,CANAL-OBJECT>
		       <RTRUE>)>)
	       (<VERB? UNTIE>
		<PERFORM-PRSA ,SIDEKICKS-BODY>
		<RTRUE>)
	       (<AND <VERB? TIE>
		     <PRSI? ,FIRST-SLAB ,SECOND-SLAB>>
		<PERFORM-PRSA ,SIDEKICKS-BODY>
		<RTRUE>)
	       (<VERB? CLIMB-ON BOARD STAND-ON>
		<COND (<OR <IN? ,PROTAGONIST ,TREE-HOLE>
			   <AND <EQUAL? ,HERE ,CLOSET>
			    	<FIRST? ,SHELF>>>
		       <TELL "Using " D ,SIDEKICK "'s shoulders, you ">
		       <COND (<IN? ,PROTAGONIST ,TREE-HOLE>
		       	      <MOVE ,PROTAGONIST ,HERE>
		       	      <MOVE ,SIDEKICK ,HERE>
		       	      <SETG OHERE <>>
			      <TELL
"climb out of the hole and help " D ,SIDEKICK " out">)
			     (T
		       	      <ROB ,SHELF ,PROTAGONIST>
		              <TELL "get everything from the shelf">)>
		       <TELL ,PERIOD-CR>)
		      (T
		       <WASTES>)>)
	       (<AND <VERB? PUSH>
		     <PRSI? ,TREE-HOLE>>
		<TELL D ,SIDEKICK
" grabs wildly at you, pulling both of you into the hole">
		<COND (<FSET? ,TRELLIS ,MUNGBIT>
		       <COND (,LEAVES-PLACED
			      <MOVE ,LEAVES ,TREE-HOLE>)>
		       <REMOVE ,TRELLIS>
		       <UNDO-TRAP>
		       <TELL " with a crash of splintering wood">)>
		<TELL ". ">
		<COND (<IN? ,FLYTRAP ,TREE-HOLE>
		       <PERFORM ,V?ENTER ,TREE-HOLE>
		       <RTRUE>)
		      (T
		       <MOVE ,PROTAGONIST ,TREE-HOLE>
		       <MOVE ,SIDEKICK ,TREE-HOLE>
		       <SETG OHERE <>>
		       <COND (<IN? ,TRELLIS ,PROTAGONIST>
			      <MOVE ,TRELLIS ,HERE>)>
		       <TELL
"\"Brilliant move, bozo,\" says " D ,SIDEKICK ,PERIOD-CR>)>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,HERE ,PLAZA>>
		<COND (<AND <PRSO? <GET ,PARTS-LIST <- ,PLAZA-COUNTER 1>>>
			    <NOT <FSET? ,PRSO ,UNTEEDBIT>>>
		       <REMOVE ,PRSO>
		       <SETG RIGHT-PART T>
		       <TELL
D ,SIDEKICK " grabs" T ,PRSO " and quickly incorporates it into ">
		       <HIS-HER>
		       <TELL " contraption." CR>)
		      (T
		       <TELL
D ,SIDEKICK " gives" T ,PRSO " the barest glance. \"No good! It has to be a">
		       <PRINT-PART>
		       <TELL "!\"" CR>)>
		<RFATAL>)
	       (<AND <VERB? GIVE>
		     <INTBL? ,PRSO ,PARTS-LIST 8>
		     <NOT <FSET? ,PRSO ,UNTEEDBIT>>>
		<EAGERLY-ACCEPTS>
		<TELL ,PERIOD-CR>)
	       (<VERB? SHOW>
		<COND (<AND <PRSO? ,HEADLIGHT>
		     	    <FSET? ,HEADLIGHT ,TRYTAKEBIT>>
		       <TELL "\"Can't reach it from here!\"" CR>)
		      (<PRSO? ,SCRAP-OF-PAPER>
		       <PERFORM ,V?ASK-ABOUT ,SIDEKICK ,SCRAP-OF-PAPER>
		       <RTRUE>)
		      (<AND <INTBL? ,PRSO ,PARTS-LIST 8>
			    <NOT <FSET? ,PRSO ,UNTEEDBIT>>>
		       <TELL
"\"Hey, wow!\" says " D ,SIDEKICK ", clearly impressed by your discovery
of" TR ,PRSO>)>)>>

<ROUTINE SIDEKICK-DESC ()
	 <COND (<G? ,PLAZA-COUNTER 0>
		<TELL "busy with" T ,ANTI-LGOP-MACHINE>)
	       (<EQUAL? ,HERE ,BOUDOIR>
		<TELL "lying on another couch">)
	       (<PROB 33>
		<TELL "alertly surveying your surroundings">)
	       (<AND <PROB 50>
		     <NOT ,SIDEKICKS-BODY-TIED-TO-SLAB>>
		<TELL "doing some quick limbering exercises">)
	       (T
		<TELL "counting on ">
		<HIS-HER>
		<TELL " fingers and mumbling to ">
		<HIM-HER>
		<TELL "self">)>>

<ROUTINE GENERIC-SIDEKICK-F ()
	 <COND (<OR <EQUAL? <GET ,P-NAMW 0> ,W?BODY>
		    <EQUAL? <GET ,P-NAMW 1> ,W?BODY>>
	        ;"confusion is between 2 bodies in Lab"
		<RFALSE>)
	       (T
	 	<RETURN ,SIDEKICK>)>>

<GLOBAL SIDEKICK-EXPLODED 0> ;"1 = blown up, 2 = reconstituted"

<GLOBAL SIDEKICK-TRIP-FLAG <>>

<GLOBAL SIDEKICK-DROWNED <>>

<GLOBAL SIDEKICK-EATEN <>>

<ROUTINE MEMORIAM ()
	 <TELL
", " 'EYES " fill with tears. You hang " 'HEAD " in sorrow for a moment to
honor your brave, loyal companion who gave ">
	 <HIS-HER>
	 <TELL
" life that humanity might be safe from the terrible scourge of "
'LGOP ,PERIOD-CR>>

<OBJECT SCRAP-OF-PAPER
	(LOC OTHER-CELL)
	(DESC "scrap of paper")
	(FDESC
"A crumpled paper lies discarded in the corner. There seems to be some
writing on it.")
	(SYNONYM SCRAP PAPER)
	(ADJECTIVE DISCARDED CRUMPLED)
	(FLAGS TAKEBIT BURNBIT READBIT)
	(SIZE 2)
	(ACTION SCRAP-OF-PAPER-F)>

<ROUTINE SCRAP-OF-PAPER-F ()
	 <COND (<VERB? READ>
		<TELL
"There's a seemingly meaningless matrix of letters on the paper:" CR>
		<PUT 0 8 <BOR <GET 0 8> 2>> ;"turns on fixed spacing for Mac"
		<TELL
;"after removing all the letters from all the words on the parts list, the
remaining letters spell HISSING FRIGHTENS FLY TRAPS"
"   HESOHREBBUR|
   ILSSSIPNGEF|
   RGIUGHTHDEN|
   SNKOOBENOHP|
   FALYTMERATP|
   SHEADLIGHTO|
   SLLABNOTTOC|">
		<PUT 0 8 <BAND <GET 0 8> -3>> ;"turns off fixed spacing"
		<RTRUE>)>>

<GLOBAL HOLE-OPEN <>>

<ROOM CRAMPED-SPACE
      (LOC ROOMS)
      (DESC "Cramped Space")
      (DOWN TO CELL IF HOLE-OPEN)
      (FLAGS INDOORSBIT)
      (ACTION CRAMPED-SPACE-F)
      ;(THINGS <PSEUDO (<> HOLE CRAMPED-SPACE-HOLE-F)>)>

<OBJECT CRAMPED-SPACE-HOLE
      (LOC CRAMPED-SPACE) 
      (DESC "hole")
      (SYNONYM HOLE)
      (FLAGS NDESCBIT)
      (ACTION CRAMPED-SPACE-HOLE-F)>

<ROUTINE CRAMPED-SPACE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT ,HOLE-OPEN>>
		<QUEUE I-CRAMPED-SPACE 2>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a dark space, too tiny to move around in. The">
		<COND (,HOLE-OPEN
		       <TELL " only exit is a hole in the floor.">)
		      (T
		       <TELL "re are no visible exits.">)>)>>

<ROUTINE I-CRAMPED-SPACE ()
	 <TELL "   Suddenly, part of the floor collapses, and you">
	 <AND-SIDEKICK>
	 <TELL " tumble through the resulting hole" ,ELLIPSIS>
	 <GOTO ,CELL T>
	 <COND (<IN? ,SIDEKICK ,CRAMPED-SPACE>
		<MOVE ,SIDEKICK ,HERE>)>
	 <SETG HOLE-OPEN T>
	 <FCLEAR ,CRAMPED-SPACE ,TOUCHBIT>
	 <TELL
"   Among the new rubble, you notice" A ,HOLE ", attached to a piece
of (what used to be) the floor of the cramped space." CR>
	 <CELL-F ,M-END>
	 <RTRUE>>

<ROUTINE CRAMPED-SPACE-HOLE-F ()
	 <COND (<NOT ,HOLE-OPEN>
		<CANT-SEE ,CRAMPED-SPACE-HOLE>)
	       (<VERB? CLIMB-DOWN STAND-ON ENTER BOARD>
		<DO-WALK ,P?DOWN>)>>

<ROOM END-OF-HALLWAY
	(LOC ROOMS)
	(DESC "End of Hallway")
	(WEST PER EXAMINATION-ROOM-F)
	(EAST PER OTHER-END-OF-HALLWAY-F)
	(NORTH TO CELL IF WIDE-CELL-DOOR IS OPEN)
	(SOUTH TO OTHER-CELL IF NARROW-CELL-DOOR IS OPEN)
	(UP TO OBSERVATION-ROOM)
	(DOWN TO BASEMENT)
	(FLAGS RLANDBIT ONBIT INDOORSBIT)
	(GLOBAL SIGN WIDE-CELL-DOOR NARROW-CELL-DOOR EXAM-ROOM-DOOR
	 	CELL-OBJECT STAIRS)
	(ACTION END-OF-HALLWAY-F)>

<ROUTINE END-OF-HALLWAY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "A " 'WIDE-CELL-DOOR " lies ">
		<OPEN-CLOSED ,WIDE-CELL-DOOR>
		<TELL " to the north, and" A ,NARROW-CELL-DOOR " lies ">
		<OPEN-CLOSED ,NARROW-CELL-DOOR>
		<TELL
" to the south. The hallway ends at a gleaming " 'EXAM-ROOM-DOOR " to the west,
and continues east. Something, possibly this very sentence, tells you that it
would be dangerous to travel east or west" ,SIGN-AND-STAIRS>)>>

<OBJECT EXAM-ROOM-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "metal door")
	(SYNONYM DOOR)
	(ADJECTIVE WEST GLEAMING METAL)
	(FLAGS NDESCBIT DOORBIT)>

<GLOBAL SEEN-EXAMINATION-ROOM <>>

<ROUTINE EXAMINATION-ROOM-DESC ("OPTIONAL" (VIEWING <>))
	 <TELL "A number of hideous experiments fill th">
	 <COND (.VIEWING
		<TELL "e">)
	       (T
		<TELL "is">)>
	 <TELL " room. Their obvious purpose: studies of the human anatomy">
	 <COND (<NOT <EQUAL? ,NAUGHTY-LEVEL 1>>
		<TELL
", especially those parts rarely referred to in the New York Times">)>
	 <TELL
". A pathetic-looking human is the current subject; however, even an author as
fond of lascivious detail as this one would hesitate to describe it ">
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 2>
		<TELL
"even in LEWD mode, except to mention that it involves a lot of lubricants,
some plastic tubing, and a yak." CR>)
	       (T
		<TELL "to someone who's merely in ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL "TAME">)
		      (T
		       <TELL "SUGGESTIVE">)>
		<TELL " mode." CR>)>> 

<ROUTINE EXAMINATION-ROOM-F ()
	 <COND (<FSET? ,EXAM-ROOM-DOOR ,OPENBIT>
		<TELL "\"Examination\" Room|   ">
		<COND (,SEEN-EXAMINATION-ROOM
		       <TELL
"The experiments look even more horrible from here than from
the Observation Room window." CR>)
		      (T
		       <EXAMINATION-ROOM-DESC>)>
		<TELL
"   Before you've really gotten as sick as you know you could get, one of the">
		<LECKBANDI>)
	       (T
		<THIS-IS-IT ,EXAM-ROOM-DOOR>
		<DO-FIRST "open" ,EXAM-ROOM-DOOR>
		<RFALSE>)>>

<ROUTINE OTHER-END-OF-HALLWAY-F ()
	 <TELL
"Other End of Hallway|
   Before you can even begin to wonder what happened to the middle of the
hallway, a guard patrol erupts from the shadows. A">
	 <LECKBANDI>>

<ROUTINE LECKBANDI ()
	 <JIGS-UP
" tall, neatly dressed Leckbandi tucks you under its arm. (The Leckbandi, who
evolved in the asteroid belt, all work exclusively as security guards. This
is odd, since there's not a single thing in the entire asteroid belt worth
stealing.)|
   Consulting a wrist computer, the Leckbandi punches in notable features of
your appearance: size, number of heads, lack of feathers, and so forth.
Eventually, the tiny screen flashes: \"IDENTIFICATION COMPLETED: Prisoner,
human, escaped. DISPOSITION: Death, painful, immediate.\" The Leckbandi, who,
like all Leckbandis, prides itself on its ability to follow the orders of
wrist computers, immediately and painfully kills you.">>

<ROOM BASEMENT
      (LOC ROOMS)
      (DESC "Basement")
      (LDESC
"This is a moist cellar. Soft light trickles down the stairway.")
      (UP TO END-OF-HALLWAY)
      (OUT TO END-OF-HALLWAY)
      (FLAGS ONBIT RLANDBIT INDOORSBIT)
      (GLOBAL STAIRS LIGHT)
      ;(THINGS <PSEUDO (<> LIGHT UNIMPORTANT-THING-F)>)>

<OBJECT LIGHT 
      (LOC LOCAL-GLOBALS)
      (DESC "light")
      (SYNONYM LIGHT)
      (ADJECTIVE SOFT)
      (FLAGS NDESCBIT TRANSBIT)
      (ACTION UNIMPORTANT-THING-F)> 

<ROOM OBSERVATION-ROOM
      (LOC ROOMS)
      (DESC "Observation Room")
      (NORTH TO CLOSET)
      (WEST SORRY
"You discover that the window makes a pleasant \"boing\" noise
when a human nose is pushed into it at approximately walking speed.")
      (IN TO CLOSET)
      (DOWN TO END-OF-HALLWAY)
      (UP TO ROOF)
      (FLAGS ONBIT RLANDBIT INDOORSBIT)
      (GLOBAL WINDOW SIGN STAIRS CLOSET-OBJECT)
      (ACTION OBSERVATION-ROOM-F)
      ;(THINGS <PSEUDO (SMALL CLOSET CLOSET-OBJECT-F)>)>

<OBJECT CLOSET-OBJECT
      (LOC LOCAL-GLOBALS) 
      (DESC "small closet")
      (SYNONYM CLOSET)
      (ADJECTIVE SMALL)
      (FLAGS NDESCBIT)
      (ACTION CLOSET-OBJECT-F)>

<ROUTINE OBSERVATION-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Calvin Coolidge once described windows as \"rectangles of glass.\" If so,
he may have been thinking about the window which fills the western wall of
this room. A tiny closet lies to the north" ,SIGN-AND-STAIRS>)>>

<ROOM CLOSET
      (LOC ROOMS)
      (DESC "Closet")
      (SOUTH PER CLOSET-EXIT-F)
      (OUT PER CLOSET-EXIT-F)
      (FLAGS RLANDBIT INDOORSBIT)
      (GLOBAL HOLE ODOR CLOSET-OBJECT)
      (HOLE-DESTINATION JUNGLE)
      (ODOR "mothballs")
      (ODOR-NUMBER 3)
      (ACTION CLOSET-F)
      ;(THINGS <PSEUDO (SMALL CLOSET CLOSET-OBJECT-F)>)>

<ROUTINE CLOSET-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This room is barely large enough to turn around in. Just to prove
it, you turn around. As you do, you spot" A ,HOLE ", about two feet across,
seemingly painted on the floor in the corner. A shelf protrudes from one
wall, very close to the ceiling. The closet is open to the south.">
		<COND (<NOT <FSET? ,NOSE ,MUNGBIT>>
		       <TELL " A strong odor ">
		       <COND (<FSET? ,HERE ,SMELLEDBIT>
			      <TELL "of " 'MOTHBALLS " ">)>
		       <TELL "pervades the closet.">)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-SMELL>
		<TELL
"Apparently this section of Phobos has a significant moth problem.">)>>

<ROUTINE CLOSET-EXIT-F ()
	 <TELL "Ah! Coming out of the closet, I see" ,ELLIPSIS>
	 ,OBSERVATION-ROOM>

<ROUTINE CLOSET-OBJECT-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,CLOSET>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,OBSERVATION-ROOM>
		       <DO-WALK ,P?NORTH>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,CLOSET>
		       <DO-WALK ,P?SOUTH>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? OPEN CLOSE>
		<TELL "No door." CR>)
	       (<AND <VERB? SMELL>
		     <EQUAL? ,HERE ,CLOSET>>
		<PERFORM-PRSA ,ODOR>
		<RTRUE>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,CLOSET>
		       <V-LOOK>)
		      (T
		       <TELL ,ONLY-BLACKNESS>)>)>>

<OBJECT SHELF
	(LOC CLOSET)
	(DESC "shelf")
	(SYNONYM SHELF LEDGE)
	(FLAGS SURFACEBIT SEARCHBIT CONTBIT OPENBIT NDESCBIT)
	(CAPACITY 40)
	(ACTION SHELF-F)>

<ROUTINE SHELF-F ()
	 <COND (<AND <VERB? PUT-ON PUT>
		     <PRSI? ,SHELF>
		     <NOT <IN? ,PROTAGONIST ,STOOL>>>
		<CANT-REACH ,SHELF>)>>

<OBJECT BASKET
	(LOC SHELF)
	(DESC "wicker basket")
	(NO-T-DESC "wicker baske")
	(SYNONYM BASKET BASKE)
	(ADJECTIVE WICKER)
	(CAPACITY 40) ;"shouldn't be able to hold more than baby and blanket"
	(FLAGS CONTBIT SEARCHBIT OPENBIT TAKEBIT BURNBIT)
	(ACTION BASKET-F)>

<ROUTINE BASKET-F ()
	 <COND (<FSET? ,BASKET ,UNTEEDBIT>
		<RFALSE>)
	       (<VERB? EXAMINE>
		<TELL
"The basket is oval-shaped. A handle spans the narrow part." CR>)
	       (<VERB? MEASURE>
		<TELL "The basket is about fifteen by thirty inches." CR>)
	       (<VERB? CLOSE>
		<NO-LID>)
	       (<AND <VERB? PUT PUT-NEAR> ;"for PUT BASKET IN FRONT OF DOOR"
		     <PRSI? ,ORPHANAGE-DOOR>>
		<PERFORM ,V?PUT-ON ,BASKET ,FRONT-STOOP>
		<RTRUE>)
	       (<TAKE-BABY-FROM-STOOP ,BASKET>
		<RTRUE>)>>

<ROUTINE TAKE-BABY-FROM-STOOP (OBJ)
	 <COND (<AND <VERB? TAKE>
		     <PRSO? .OBJ>
		     <QUEUED? ,I-ORPHANAGE>
		     <L? <CCOUNT ,PROTAGONIST> 11>>
		<DEQUEUE I-ORPHANAGE>
		<RFALSE>)>>

<OBJECT MOTHBALLS
	(LOC CLOSET)
	(DESC "mothballs")
	(SYNONYM MOTHBALL MOTHBALLS BALL BALLS)
	(ADJECTIVE MOTH)
	(FLAGS NARTICLEBIT NDESCBIT)
	(ACTION MOTHBALLS-F)>

<ROUTINE MOTHBALLS-F ()
	 <COND (<EQUAL? ,HERE ,CLOSET>
		<TELL
,YOU-CANT-SEE-ANY 'MOTHBALLS " here. It must be some imitation mothball air
mist." CR>)>>

<ROOM ROOF
      (LOC ROOMS)
      (DESC "Roof")
      (DOWN TO OBSERVATION-ROOM)
      (IN TO OBSERVATION-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STAIRS HOLE)
      (HOLE-DESTINATION MARTIAN-DESERT)
      (ACTION ROOF-F)
      ;(THINGS <PSEUDO (<> ROOF ROOF-OBJECT-F)>)>

<OBJECT ROOF-OBJECT
      (LOC ROOF)
      (DESC "roof")
      (SYNONYM ROOF)
      (FLAGS NDESCBIT)
      (ACTION ROOF-OBJECT-F)>

<ROUTINE ROOF-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Your view extends to the horizon, which on tiny Phobos usually means a few
hundred feet. Thrusting up into sight beyond the horizon are"
,PLEASURE-PALACE-DESC 'LGOP ". On a wide plain between here and the palace,
powerful warships are poised for the imminent invasion of Earth.|
   Mars dominates the view, a dull red orb spanning a quarter of the sky.
Bright blue canals lace the surface, and white caps of ice are visible at
both poles.|
   A stairway leads down into the building. Near the edge, seemingly painted
onto the roof, is" A ,HOLE ". You might be able to jump to the ground, but
frankly we advise against it.">)>>

;"NOTE: The above description of Mars spanning nearly a quarter of the Phobos'
sky is based on the following calculation: The radius of Mars is 3400km, and
the distance between Mars and Phobos is 9380km. These two dimensions form an
angle at the point of a viewer on Phobos between the center of Mars and one
edge of Mars. The tangent of this angle is 3400 divided by 9380 (.3625), so
the angle is approximately 20 degrees. The full width of Mars, edge to edge,
would be twice this, or 40 degrees. One quarter of the sky is 45 degrees."

<ROUTINE ROOF-OBJECT-F ()
	 <COND (<OR <VERB? LEAP-OFF DISEMBARK>
		    <AND <VERB? TAKE-OFF>
			 <EQUAL? ,P-PRSA-WORD ,W?GET>>>
		<SETG PRSO <>>
		<V-LEAP>)
	       (<VERB? EXAMINE>
		<V-LOOK>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)>>

;"end game"
<ROUTINE I-BLUEPRINT ()
	 <COND (<AND <VISIBLE? ,SIDEKICK>
		     <LIT? ,HERE>
		     <NOT <EQUAL? <LOC ,SIDEKICK> ,SECOND-SLAB ,STALLION>>
		     <NOT <QUEUED? ,I-SIDEKICK-OUT-WINDOW>>>
		<MOVE ,MATCHBOOK ,PROTAGONIST>
		<TELL
"   " D ,SIDEKICK " trots over to you. \"I've got a plan to bring these
Leather Goddess jokers to their knees,\" ">
		<HE-SHE>
		<TELL " says, flipping you a " 'MATCHBOOK ". ">
		<COVER-FILLED-WITH-NOTES>
		<SCRAPE-UP-THESE-ITEMS>)
	       (T
		<QUEUE I-BLUEPRINT 3>
		<RFALSE>)>>

<ROUTINE SCRAPE-UP-THESE-ITEMS ()
	 <TELL
"\"If we can scrape up these items, I can whip up something that'll knock 'em
cold! A " 'ANTI-LGOP-MACHINE "!!!\"" CR>>

<CONSTANT PARTS-LIST
	<TABLE
	 BLENDER
	 RUBBER-HOSE
	 COTTON-BALLS
	 EIGHTY-TWO-DEGREE-ANGLE
	 HEADLIGHT
	 MOUSE
	 PHOTO
	 PHONE-BOOK>>

<OBJECT MATCHBOOK
	(DESC "matchbook")
	(NO-T-DESC "machbook")
	(SYNONYM MATCHBOOK MACHBOOK BOOK COVER NOTATION NOTATIONS BLUEPRINT)
	(ADJECTIVE EMPTY MATCH MACH MATCHBOOK MATCHES SCRAWLED)
	(FLAGS READBIT TAKEBIT BURNBIT)
	(SIZE 2)
	(ACTION MATCHBOOK-F)>

<ROUTINE MATCHBOOK-F ()
	 <COND (<FSET? ,MATCHBOOK ,UNTEEDBIT>
		<RFALSE>)
	       (<AND <VERB? KILL>
		     <EQUAL? ,P-PRSA-WORD ,W?STRIKE>>
		<PERFORM ,V?ON ,MATCHBOOK>
		<RTRUE>)
	       (<VERB? OPEN COUNT LOOK-INSIDE ON>
		<TELL
"You briefly open the " 'MATCHBOOK " and see that
there are no matches left." CR>)
	       (<VERB? CLOSE>
		<TELL ,ALREADY-IS>)
	       (<VERB? READ>
		<TELL
"Most of the scrawlings are a \"blueprint\" for a vastly complicated
device. Below that is a parts list:|
   1." A ,BLENDER "|
   2. six feet of " 'RUBBER-HOSE "|
   3. a " 'COTTON-BALLS "|
   4. an " 'EIGHTY-TWO-DEGREE-ANGLE "|
   5. a " 'HEADLIGHT " from any 1933 Ford|
   6. a white mouse|
   7. any size " D ,PHOTO "|
   8. a copy of" T ,PHONE-BOOK CR>)
	       (<VERB? EXAMINE>
		<COVER-FILLED-WITH-NOTES>
		<PERFORM ,V?OPEN ,MATCHBOOK>
		<RTRUE>)>>

<ROUTINE COVER-FILLED-WITH-NOTES ()
	 <TELL
"The cover of the " 'MATCHBOOK " is filled with scrawled notations. ">>

<ROOM BOUDOIR
      (LOC ROOMS)
      (DESC "Boudoir")
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (ODOR "leather")
      (ODOR-NUMBER 6)
      (GLOBAL ODOR)
      (ACTION BOUDOIR-F)>

<ROUTINE BOUDOIR-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<MOVE ,PROTAGONIST ,DIVAN>
		<SETG OHERE <>>
		<QUEUE I-BOUDOIR 6>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"There is only enough light here to make out vague shapes. ">
		<COND (<IN? ,PROTAGONIST ,DIVAN>
		       <TELL "You seem to be lying on a plush divan. ">)>
		<NOT-ALONE-ON-DIVAN>
		<COND (<NOT <FSET? ,NOSE ,MUNGBIT>>
		       <TELL " A pleasing odor ">
		       <COND (<FSET? ,HERE ,SMELLEDBIT>
			      <TELL "of leather ">)>
		       <TELL "comes from close by.">)>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-SMELL>
		<TELL "Someone nearby is wearing leather. Lots of leather.">)>>

<ROUTINE NOT-ALONE-ON-DIVAN ()
	 <TELL "You hear heavy breathing from nearby">
	 <COND (<IN? ,PROTAGONIST ,DIVAN>
		<TELL ", and realize that you are not alone on the couch">)>
	 <TELL ".">>

<OBJECT DIVAN
	(LOC BOUDOIR)
	(DESC "divan")
	(SYNONYM DIVAN COUCH)
	(ADJECTIVE PLUSH)
	(CAPACITY 100)
	(FLAGS VEHBIT OPENBIT CONTBIT SEARCHBIT NDESCBIT)>

<ROUTINE I-BOUDOIR ("OPTIONAL" (NOT-CALLED-BY-FUCK T))
	 <TELL "   You hear a click, and ">
	 <COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		<TELL "leap to your feet as ">)>
	 <TELL
"the room is flooded with light!|
|"
'HERE "|
   Oh, no! You have violated the sanctity of a boudoir! And not just any old
boudoir, but an" ,PRIVATE-BOUDOIR "! And not just any old" ,PRIVATE-BOUDOIR
", but an" ,PRIVATE-BOUDOIR " belonging to " 'LGOP "!|
   \"The escaped prisoner">
	 <COND (<VISIBLE? ,SIDEKICK>
		<TELL "s">)>
	 <TELL "!\" cries one of " 'LGOP ". \"Sound the alarm!\"|
   \"Inform the guards!\" yells another.|
   \"Call out the army!\"|
   \"Alert the space fleet!\"|
   \"Summon my masseur,\" says the single unfrantic Goddess, calmly pulling a
lever. As the floor opens up, you">
	 <AND-SIDEKICK>
	 <TELL " plunge down a long chute" ,ELLIPSIS>
	 <INCREMENT-SCORE 9 13>
	 <GOTO ,PLAZA T>
	 <COND (<ULTIMATELY-IN? ,SIDEKICK ,BOUDOIR>
		<MOVE ,SIDEKICK ,PLAZA>)>
	 <COND (<AND .NOT-CALLED-BY-FUCK
		     <NOT <VERB? WAIT>> ;"WAIT calls CLOCKER, not MAIN-LOOP">
		<PLAZA-F ,M-END>)>
	 <RTRUE>>

<OBJECT LGOP
	(LOC DIVAN)
	(DESC "the Leather Goddesses of Phobos")
	(SYNONYM PHOBOS GODDESSES SHAPE SHAPES)
	(ADJECTIVE LEATHER COUCHMATE)
	(FLAGS NDESCBIT NARTICLEBIT ACTORBIT FEMALEBIT PLURALBIT)
        (ACTION LGOP-F)>

<ROUTINE LGOP-F ()
	 <COND (<EQUAL? ,LGOP ,WINNER>
		<COND (<AND <VERB? KISS>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM-PRSA ,LGOP>
		       <SETG WINNER ,LGOP>
		       <RTRUE>)
		      (<AND <VERB? FUCK TAKE>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?FUCK ,LGOP>
		       <SETG WINNER ,LGOP>
		       <RTRUE>)
		      (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL ,LEAVE-ME-ALONE>)
		      (T
		       <TELL "\"Shut up and kiss me, honey.\"" CR>
		       <STOP>)>)
	       (<VERB? EXAMINE>
		<TELL "The lighting is too dim to see more than vague shapes.">
		<COND (<NOT <EQUAL? ,NAUGHTY-LEVEL 0>>
		       <TELL " But very shapely shapes!">)>
		<CRLF>)
	       (<AND <VERB? TOUCH FUCK KISS>
		     <EQUAL? ,NAUGHTY-LEVEL 0>>
		<TELL "You're pushed away. " ,LEAVE-ME-ALONE>)
	       (<VERB? EAT>
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <V-FUCK>)
		      (<EQUAL? ,NAUGHTY-LEVEL 1>
		       <TELL ,MISSIONARY-ONLY>)
		      (T
		       <TELL
"As you dive between her thighs, she arches toward you, shivering with
hedonistic pleasure." CR>)>)
	       (<VERB? TOUCH>
		<TELL
"Your arms discover a soft and eager body. You hear a purr of pleasure">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 2>
		       <BODIES-PRESS-TOGETHER "fondling" "breasts">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? KISS>
		<TELL
"Your lips meet those of your couchmate -- full, moist lips; the lips of
someone who knows how to kiss">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 2>
		       <TELL ". A tongue slides teasingly into " 'MOUTH>
		       <BODIES-PRESS-TOGETHER "kissing" "lips">)>
		<COND (<VISIBLE? ,SIDEKICK>
		       <TELL
,PERIOD-CR "   You hear a \"thunk\" as " D ,SIDEKICK
", humping enthusiastically, falls off ">
		       <HIS-HER>
		       <TELL " couch">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? SMELL>
		<PERFORM-PRSA ,ODOR>
		<RTRUE>)
	       (<VERB? FUCK>
		<TELL
"Your couchmate seems only too happy to oblige. You flush with passion">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 2>
		       <BODIES-PRESS-TOGETHER "making love to" "breasts">)>
		<TELL ". Suddenly..." CR>
		<DEQUEUE I-BOUDOIR>
		<I-BOUDOIR <>>)>>

<ROUTINE BODIES-PRESS-TOGETHER (VERB-STRING NOUN-STRING)
	 <MOVE ,PROTAGONIST ,DIVAN>
	 <SETG OHERE <>>
	 <TELL " as your two bodies draw closer together on the divan">
	 <COND (<AND <NOT ,MALE>
		     <NOT ,DISCOVERED>>
		<SETG DISCOVERED T>
		<TELL
". You discover, much to your surprise, that you are " .VERB-STRING
" a woman. Even more surprising, your misgivings are swept away by the heady
pleasure of the soft, full " .NOUN-STRING " pressing against your own">)>>

<GLOBAL DISCOVERED <>>

<ROOM PLAZA
      (LOC ROOMS)
      (DESC "Plaza")
      (FLAGS RLANDBIT ONBIT)
      (ODOR "banana")
      (ODOR-NUMBER 7)
      (GLOBAL TREE LAWN-OBJECT FLOWER)
      (ACTION PLAZA-F)
      ;(THINGS <PSEUDO (<> LAWN LAWN-OBJECT-F)
		      (<> BIRD UNIMPORTANT-THING-F)
		      (<> BIRDS UNIMPORTANT-THING-F)
		      (<> FLOWER UNIMPORTANT-THING-F)
		      (<> FOUNTAIN UNIMPORTANT-THING-F)>)>

<OBJECT BIRDS 
      (LOC PLAZA)
      (DESC "bird")
      (SYNONYM BIRD BIRDS)
      (FLAGS NDESCBIT)
      (ACTION UNIMPORTANT-THING-F)>

<OBJECT FOUNTAIN
      (LOC PLAZA)
      (DESC "fountain")
      (SYNONYM FOUNTAIN FOUNTAINS)
      (ADJECTIVE GUSHING)
      (FLAGS NDESCBIT)
      (ACTION UNIMPORTANT-THING-F)>

<ROUTINE PLAZA-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a wide plaza between" ,PLEASURE-PALACE-DESC 'LGOP ". It is a lovely,
bucolic area of gushing fountains, curving flower beds, and lawns of thick,
green grass. Birds fly amongst the trees, singing peacefully, as baby squirrels
hop across the lawn, lazily collecting nuts.">)
	       (<EQUAL? .RARG ,M-SMELL>
		<TELL
"Through the smoke of battle, you see a banana peel squirt
from" T ,ANTI-LGOP-MACHINE ".">)
	       (<EQUAL? .RARG ,M-END>
		<SETG PLAZA-COUNTER <+ ,PLAZA-COUNTER 1>>
	 	<TELL "   ">
	 	<COND (<EQUAL? ,PLAZA-COUNTER 1>
		       <TELL
"A half-megaton grenade explodes nearby as the palace
guards attempt to repel ">
		       <COND (<IN? ,SIDEKICK ,HERE>
			      <TELL "some">)
			     (T
			      <TELL "an">)>
		       <TELL " unwanted intruder">
		       <COND (<IN? ,SIDEKICK ,HERE>
			      <TELL "s">)>
		       <TELL " (namely: you">
		       <AND-SIDEKICK>
		       <TELL ")." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 2>
		       <TELL
"The guards now have reinforcements: a row of imposing radium-powered tanks
are rolling towards you." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 3>
		       <TELL
"Giant berserk robotoid sumo wrestlers, each madly waving about three dozen
samurai swords, are now storming across the plaza at you." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 4>
		       <TELL
"With a swooping roar, the" ,ATTACK-FLEET " of " 'LGOP " joins the attack.
Several nearby trees are suddenly vaporized." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 5>
		       <TELL
"The palace guards are setting up a massive dematerialization ray. Closer
by, a sumo-robot discovers a boulder in its path, and a large quantity of
gravel is created." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 6>
		       <TELL
"A Phobosian Chomper is faster than a cheetah, meaner than a Tyrannosaurus Rex,
bigger than a sperm whale, and as hungry as the state of Texas. We mention this
because fifty of them just entered the plaza and spotted you." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 7>
		       <TELL
"Several fifty-foot craters appear as the" ,ATTACK-FLEET " begins lobbing ion
bombs. As they veer around for a more precise attack, the tanks close in, and
you realize that each one is larger than the Upper Sandusky City Hall." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 8>
		       <TELL
"A couple of buildings behind you silently vanish, indicating that the palace
guards are better at assembling a death ray than at aiming it. However, in
sixty centuries of repelling intruders, they've never missed twice. Meanwhile,
one of the Chompers has stopped to swallow a herd of goats that was grazing
nearby, thus slowing it down for a full tenth of a second." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 9>
		       <TELL
"The guards have finished aiming the death ray, and have begun the activation
sequence. The ground quakes as the berserko robotoids plow through the rubble
toward you; the wind from their whirling swords knocks over a few trees. The
tanks loom above you, their gun turrets blocking out the sun. Beyond them, the"
,ATTACK-FLEET " is sweeping in for a final attack." CR>)
		      (<EQUAL? ,PLAZA-COUNTER 10> ;"if SIDEKICK isn't present"
		       <JIGS-UP
"All your attackers come together in a climactic battle scene far too
incredible to describe in the 23 words allotted to this sentence.">)>
		<COND (<NOT <VISIBLE? ,SIDEKICK>>
		       <RTRUE>)>
		<TELL "   " D ,SIDEKICK>
	 	<COND (<EQUAL? ,PLAZA-COUNTER 1>
		       <MOVE ,ANTI-LGOP-MACHINE ,HERE>
		       <TELL " shouts, \"Okay, this is it!">
		       <COND (<FIRST? ,SIDEKICK>
			      <ROB ,SIDEKICK ,PROTAGONIST>
			      <TELL "\" ">
			      <HE-SHE T>
			      <TELL " hands you everything ">
			      <HE-SHE>
			      <TELL "'s carrying. \"">)
			     (T
			      <TELL " ">)>
		       <TELL
"Gotta start building that " 'ANTI-LGOP-MACHINE "! ">)
		      (T
		       <TELL
", hammering and twiddling madly at the growing machine, yells, \"">
		       <COND (,RIGHT-PART
		       	      <TELL
"Okay, things are going " <GET ,HYPE-WORD <- ,PLAZA-COUNTER 2>> "! ">)
			     (T
		       	      <SETG MISSING-PART
			     	    <GET ,PARTS-LIST <- ,PLAZA-COUNTER 2>>>
		       	      <TELL
"Well, I'll try and work around the missing ">
			      <COND (<EQUAL? ,MISSING-PART ,PHOTO>
				     <TELL <GETP ,PHOTO ,P?SDESC>>)
				    (T
				     <PRINTD ,MISSING-PART>)>
			      <TELL ". ">)>
		       <COND (<EQUAL? ,PLAZA-COUNTER 9>
		       	      <TELL
"There! I think it's all done. Cross your fingers, kiddo!\" ">
		       	      <HE-SHE T>
		       	      <TELL
" switches on the device. Amidst showers of sparks, a powerful electric arc
bridges two electrodes. The machine shudders, and ">
		       	      <COND (,MISSING-PART
				     <TELL
"awe-inspiring rays of raw plasma begin shooting in every direction. You and "
D ,SIDEKICK " dive to the ground. Crashing spaceships collide with careening
robotoid monsters; the tanks, inches before pancaking you, become pools of
molten metal. A stray plasma ray strikes the only remaining tree in the plaza,
and you are fatally wounded as a coconut drops onto " 'HEAD ". The last sound
you hear is " D ,SIDEKICK "'s voice, saying,">
				     <EXPLETIVE>
				     <TELL "I was going to use that ">
				     <COND (<EQUAL? ,MISSING-PART ,PHOTO>
					    <TELL <GETP ,PHOTO ,P?SDESC>>)
					   (T
					    <PRINTD ,MISSING-PART>)>
				     <TELL
" to build a coconut deflector.\"" CR>)
				    (T
				     <TELL "you ">
				     <COND (<FSET? ,NOSE ,MUNGBIT>
					    <TELL "see">)
					   (T
					    <TELL "smell">)>
				     <TELL
" something yellow shoot from the machine.">
				     <COND (<FSET? ,NOSE ,MUNGBIT>
					    <TELL " It's a banana peel!" CR>)
					   (T
					    <CRLF>
					    <PERFORM ,V?SMELL ,ODOR>)>
				     <TELL
"   The peel lands a few feet away, as the " 'ANTI-LGOP-MACHINE " gives one
final shudder and self-destructs in an orgy of flames and shrapnel!|
   The attacking forces continue to close, and certain death is only seconds
away when one of the Chompers, loping toward you at nearly Mach One, steps on
the banana peel, and slips a few inches to one side before righting itself.
This is enough, however, to nudge a tank into a crater, tripping one of the
samurai robots!|
   More and more of the attacking forces plow into the mess in the crater, like
some improbably fantastical football tackle. A stray grenade lands right in
its midst, and the resulting plume of debris shears the fins off the leading
warship. Your heart leaps as the entire" ,ATTACK-FLEET " of " 'LGOP " plummets
toward the ground. The mass of flaming metal strikes the ground, and a
tremendous explosion knocks you senseless!|
|
   Eventually, daylight intrudes upon your senselessness and illuminates a
sleepy-looking gas station. You are lying at the edge of a dusty road, once
again wearing your comfortable old overalls. Though dirty, dishevelled, and
bleeding from a few superficial cuts, you are nevertheless aglow in the
knowledge that Earth is safe from the threat of " 'LGOP ".|
   As " 'HEAD " clears, three uniformed ">
				     <COND (,MALE
					    <TELL "girls come bounc">)
					   (T
					    <TELL "guys come pound">)>
				     <TELL
"ing out of the service station toward you. \"Oh, my goodness,\" they ">
				     <COND (,MALE
					    <TELL "coo">)
					   (T
					    <TELL "call out">)>
				     <TELL
", in perfect unison. \"Are you all right?\"|
|
   Coming soon from Infocom: GAS PUMP GIRLS MEET THE
PULSATING INCONVENIENCE FROM PLANET X." CR>
				     <SETG RANK 9>
				     <SETG EXT-MAX ,INT-MAX>)>
			      <FINISH>)>)>
		<TELL "Hand me a">
		<PRINT-PART>
		<TELL ".\"" CR>
	 	<SETG RIGHT-PART <>>
	 	<THIS-IS-IT ,SIDEKICK>)>>

<ROUTINE PRINT-PART ("AUX" NEXT-PART)
	 <SET NEXT-PART <GET ,PARTS-LIST <- ,PLAZA-COUNTER 1>>>
	 <THIS-IS-IT .NEXT-PART>
	 <COND (<EQUAL? .NEXT-PART ,EIGHTY-TWO-DEGREE-ANGLE>
		<TELL "n ">)
	       (T
		<TELL " ">)>
	 <COND (<EQUAL? .NEXT-PART ,PHOTO>
		<TELL <GETP ,PHOTO ,P?SDESC>>)
	       (T
		<PRINTD .NEXT-PART>)>>

<GLOBAL PLAZA-COUNTER 0>

<GLOBAL RIGHT-PART <>>

<GLOBAL MISSING-PART <>>

<CONSTANT HYPE-WORD
	<TABLE "great"
	       "swell"
	       "fantastically"
	       "perfectly"
	       "teriff"
	       "boffo"
	       "hunky dory"
	       "neato peachy keen">>

<OBJECT ANTI-LGOP-MACHINE
	(DESC "Super-Duper Anti-Leather Goddesses of Phobos Attack Machine")
	(SYNONYM MACHINE DEVICE)
	(ADJECTIVE SUPER DUPER ATTACK LARGE)
	(GENERIC GENERIC-MACHINE-F)
	(FLAGS NDESCBIT)>

<ROUTINE GENERIC-MACHINE-F ("AUX" NUM)
	 <SET NUM <CANAL-LOC>>
	 <COND (<AND <EQUAL? ,HERE ,CANAL>
		     <OR <G? .NUM 31>
			 <L? .NUM 13>>>
		<RETURN ,ODD-MACHINE>)
	       (<VERB? ASK-ABOUT>
		<COND (<VISIBLE? ,ODD-MACHINE>
		       <RETURN ,ODD-MACHINE>)
		      (T
		       <RETURN ,ANTI-LGOP-MACHINE>)>)
	       (<AND <EQUAL? ,SIDEKICK ,WINNER>
		     <NOT <QUEUED? ,I-BLUEPRINT>>>
		<RETURN ,ANTI-LGOP-MACHINE> ;"example: TRENT, MAKE A MACHINE")
	       (T
		<RFALSE>)>>
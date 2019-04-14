"CLEVELAND for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

<OBJECT CLEVELAND-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "Cleveland")
	(SYNONYM CLEVELAND)
	(ACTION CLEVELAND-OBJECT-F)>

<ROUTINE CLEVELAND-OBJECT-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,CLEVELAND>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,LAWN>
		       <DO-WALK ,P?NORTH>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,CLEVELAND>
		       <V-WALK-AROUND>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? EXAMINE>
		<V-LOOK>)>>

<ROOM CLEVELAND
      (LOC ROOMS)
      (DESC "Cleveland")
      (LDESC
"You suddenly find yourself longing for the slime pits of Venus or the
sandstorms of Mars. This particular section of Cleveland has exits to
the northeast and south.")
      (NE TO TEENSY-WEENSY-HOUSE)
      (SOUTH TO LAWN)
      (FLAGS RLANDBIT ONBIT NARTICLEBIT)
      (GLOBAL CLEVELAND-OBJECT HOUSE)>

<ROOM LAWN
      (LOC ROOMS)
      (DESC "Lawn")
      (NORTH TO CLEVELAND)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CLEVELAND-OBJECT LAWN-OBJECT)
      (ACTION LAWN-F)
      ;(THINGS <PSEUDO (TALL FENCE FENCE-F)
		      (<> LAWN LAWN-OBJECT-F)>)>

<OBJECT LAWN-OBJECT
      (LOC LOCAL-GLOBALS)
      (DESC "lawn")
      (SYNONYM LAWN)
      (FLAGS NDESCBIT)
      (ACTION LAWN-OBJECT-F)>

<OBJECT TALL-FENCE
      (LOC LAWN)  
      (DESC "tall fence")
      (SYNONYM FENCE)
      (ADJECTIVE TALL)
      (FLAGS NDESCBIT)
      (ACTION FENCE-F)>

<ROUTINE LAWN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Yes, \"Lawn\" is the kindest word for this muddy patch of limp crabgrass. ">
		<COND (<AND <FSET? ,RAKE ,TRYTAKEBIT>
			    <FSET? ,SACK ,TRYTAKEBIT>>
		       <TELL "Miraculously, someone actually seems to ">
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
			      <TELL "care">)
			     (T
			      <TELL "give a ">
			      <COND (<EQUAL? ,NAUGHTY-LEVEL 1>
				     <TELL "damn">)
				    (T
				     <TELL "shit">)>)>
		       <TELL
" about this lawn, because there are signs of recent activity:" A ,RAKE
" and a large " 'SACK ". ">)>
		<TELL
"A fence rings the lawn; through an opening to the north you can
see Cleveland.">)
	       (<EQUAL? .RARG ,M-END>
		<FCLEAR ,RAKE ,TRYTAKEBIT>
		<FCLEAR ,SACK ,TRYTAKEBIT>
		<FCLEAR ,RAKE ,NDESCBIT>
		<FCLEAR ,SACK ,NDESCBIT>)>>

<ROUTINE FENCE-F ()
	 <COND (<VERB? LOOK-OVER CLIMB CLIMB-UP CLIMB-OVER>
		<TELL "It's too tall." CR>)
	       (<AND <VERB? PUT-AGAINST>
		     <PRSO? ,TRELLIS>>
		<PERFORM-PRSA ,TRELLIS ,HOUSE>
		<RTRUE>)>>

<ROUTINE LAWN-OBJECT-F ()
	 <COND (<VERB? RAKE>
		<TELL "It's already raked." CR>)
	       (<VERB? CLIMB-UP CLIMB-ON CLIMB BOARD LOOK-UNDER>
		<PERFORM-PRSA ,GROUND ,PRSI>
		<RTRUE>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,LAWN-OBJECT>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)
	       (<VERB? EXAMINE>
		<V-LOOK>)>>

<OBJECT RAKE
	(LOC LAWN)
	(DESC "wooden rake")
	(SYNONYM RAKE)
	(ADJECTIVE WOODEN)
	(FLAGS NDESCBIT TAKEBIT BURNBIT TRYTAKEBIT)>

<OBJECT SACK
	(LOC LAWN)
	(DESC "canvas sack")
	(SYNONYM SACK BAG)
	(ADJECTIVE CANVAS LARGE)
	(FLAGS NDESCBIT TRYTAKEBIT TAKEBIT CONTBIT SEARCHBIT BURNBIT)
	(SIZE 3)
	(CAPACITY 50)>

<OBJECT LEAVES
	(LOC SACK)
	(DESC "whole bunch of leaves")
	(SYNONYM BUNCH LEAVES LEAF PILE)
	(ADJECTIVE WHOLE)
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT PLURALBIT)
	(SIZE 2)
	(ACTION LEAVES-F)>

<ROUTINE LEAVES-F ()
	 <COND (<VERB? ENTER>
		<COND (<ULTIMATELY-IN? ,LEAVES>
		       <TELL ,HOLDING-IT>)
		      (T
		       <WEE>)>)
	       (<VERB? TAKE>
		<COND (<PRE-TOUCH>
		       <RTRUE>)>
		<TELL ,YOU-CANT "hold so many leaves in your arms!" CR>)
	       (<VERB? RAKE>
		<TELL "They're already in a ">
		<COND (<IN? ,LEAVES ,SACK>
		       <PRINTD ,SACK>)
		      (T
		       <TELL "pile">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? COUNT>
		<TELL "69,105." CR>)
	       (<VERB? SEARCH LOOK-INSIDE>
		<TELL "You find ... more leaves!" CR>)
	       (<AND <VERB? POUR>
		     <PRSO? ,LEAVES>>
		<COND (<ULTIMATELY-IN? ,LEAVES>
		       <COND (<PRSI? ,WINDOW>
		       	      <PERFORM ,V?PUT-THROUGH ,LEAVES ,WINDOW>
		       	      <RTRUE>)
			     (T
			      <PERFORM ,V?PUT ,LEAVES ,PRSI>
			      <RTRUE>)>)
		      (T
		       <TELL ,YNH TR ,LEAVES>)>)
	       (<OR <AND <VERB? PUSH PUT>
		     	 <PRSI? ,SACK>>
		    <AND <VERB? FILL>
			 <PRSO? ,SACK>>>
		<COND (<UNTOUCHABLE? ,LEAVES>
		       <CANT-REACH ,LEAVES>
		       <RTRUE>)
		      (<IN? ,LEAVES ,SACK>
		       <RFALSE>)>
		<FCLEAR ,LEAVES ,TRYTAKEBIT>
		<SETG LEAVES-PLACED <>>
		<FSET ,TREE-HOLE ,OPENBIT>
		<FCLEAR ,LEAVES ,NDESCBIT>
		<MOVE ,LEAVES ,SACK>
		<TELL "Done." CR>)
	       (<AND <VERB? MOVE>
		     ,LEAVES-PLACED>
		<FCLEAR ,LEAVES ,TRYTAKEBIT>
		<SETG LEAVES-PLACED <>>
		<FSET ,TREE-HOLE ,OPENBIT>
		<FCLEAR ,LEAVES ,NDESCBIT>
		<MOVE ,LEAVES ,HERE>
		<TELL "You uncover the trellis." CR>)
	       (<AND <VERB? LOOK-UNDER>
		     ,LEAVES-PLACED>
		<TRELLIS-VISIBLE>
		<CRLF>)
	       (<AND <VERB? EMPTY>
		     <PRSO? ,LEAVES>
		     <IN? ,LEAVES ,SACK>>
		<PERFORM ,V?DROP ,LEAVES>
		<RTRUE>)
	       (<AND <VERB? STAND-ON CLIMB-ON BOARD>
		     ,LEAVES-PLACED>
		<PERFORM ,V?STAND-ON ,TRELLIS>
		<RTRUE>)>>

<ROOM TEENSY-WEENSY-HOUSE
      (LOC ROOMS)
      (DESC "Teensy-Weensy House")
      (LDESC
"This rickety home is so petite that the entire first floor is only
one location in this story. When you tire of this floor, you can go
east, southwest, or up.")
      (SW TO CLEVELAND)
      (EAST TO GARDEN)
      (UP TO BEDROOM)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL STAIRS HOUSE FIRST-FLOOR SECOND-FLOOR)
      ;(THINGS <PSEUDO (FIRST FLOOR FIRST-FLOOR-F)
		      (SECOND FLOOR SECOND-FLOOR-F)>)>

<OBJECT FIRST-FLOOR
      (LOC LOCAL-GLOBALS)
      (DESC "first floor")
      (SYNONYM FLOOR)
      (ADJECTIVE FIRST)
      (FLAGS NDESCBIT)
      (ACTION FIRST-FLOOR-F)>

<OBJECT SECOND-FLOOR
      (LOC LOCAL-GLOBALS) 
      (DESC "second floor")
      (SYNONYM FLOOR)
      (ADJECTIVE SECOND)
      (FLAGS NDESCBIT)
      (ACTION SECOND-FLOOR-F)>

<ROOM GARDEN
      (LOC ROOMS)
      (DESC "Garden")
      (WEST TO TEENSY-WEENSY-HOUSE)
      (IN TO TEENSY-WEENSY-HOUSE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HOLE HOUSE FLOWER)
      (HOLE-DESTINATION END-OF-HALLWAY)
      (ACTION GARDEN-F)
      ;(THINGS <PSEUDO (<> FLOWER FLOWERS-F)>)>

<OBJECT FLOWER
      (LOC LOCAL-GLOBALS)
      (DESC "flower")
      (SYNONYM FLOWER FLOWERS BED BEDS)
      (ADJECTIVE YELLOW BULBOUS FLOWER)
      (FLAGS NDESCBIT)
      (ACTION FLOWERS-F)>

<ROUTINE GARDEN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The house opens onto a fragrant garden! A piece of sod has been ">
		<COND (<FSET? ,SOD ,MUNGBIT>
		       <TELL "rolled aside, revealing" A ,HOLE>)
		      (T
		       <TELL "recently planted">)>
		<TELL
", and a clump of yellow, bulbous flowers grows nearby.">
		<COND (<FSET? ,TRELLIS ,TRYTAKEBIT>
		       <TELL
" The flowers barely reach the trellis which rises behind them.">)>
		<TELL " You can reenter the house to the west.">)>>

<ROUTINE FLOWERS-F ()
	 <COND (<VERB? SMELL>
		<PERFORM-PRSA ,ODOR>
		<RTRUE>)
	       (<VERB? PICK TAKE MUNG>
		<TELL "That would be the act of a philistine." CR>)>>

<OBJECT SOD
	(LOC GARDEN)
	(DESC "sod")
	(SYNONYM PIECE SOD)
	(FLAGS NARTICLEBIT NDESCBIT TRYTAKEBIT)
	(ACTION SOD-F)>

<ROUTINE SOD-F ()
	 <COND (<VERB? TAKE>
		<EXAMINE-SOD T>)
	       (<VERB? MOVE ROLL PUSH>
		<COND (<FSET? ,SOD ,MUNGBIT>
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <FSET ,SOD ,MUNGBIT>
		       <THIS-IS-IT ,HOLE>
		       <TELL "Moving the sod reveals" AR ,HOLE>)>)
	       (<OR <AND <VERB? PUT-ON>
			 <PRSI? ,HOLE>>
		    <VERB? UNROLL>>
		<COND (<FSET? ,SOD ,MUNGBIT>
		       <FCLEAR ,SOD ,MUNGBIT>
		       <TELL "You re-cover" TR ,HOLE>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<AND <VERB? RAISE LOOK-UNDER>
		     <NOT <FSET? ,SOD ,MUNGBIT>>>
		<TELL
"You lift a corner. Before the sod drops back to the ground,
you notice something dark." CR>)
	       (<VERB? EXAMINE>
		<EXAMINE-SOD>)>>

<ROUTINE EXAMINE-SOD ("OPTIONAL" (TAKING <>))
	 <TELL "Although the sod hasn't taken root yet, it">
	 <COND (.TAKING
		<TELL "'">)
	       (T
		<TELL " look">)>
	 <TELL "s too heavy to carry." CR>>

<OBJECT TRELLIS
	(LOC GARDEN)
	(DESC "trellis")
	(NO-T-DESC "rellis")
	(DESCFCN TRELLIS-F)
	(SYNONYM TRELLIS RELLIS)
	(ADJECTIVE WOODEN WHITE TALL WIDE SQUARE)
	(FLAGS NDESCBIT TAKEBIT BURNBIT TRYTAKEBIT SEARCHBIT)
	(SIZE 55)
	(CAPACITY 50)
	(ACTION TRELLIS-F)>

<ROUTINE TRELLIS-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<FSET? ,TRELLIS ,MUNGBIT>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL "   ">
		       <DESCRIBE-TRELLIS-ON-HOLE>)
		      (T
		       <RFALSE>)>)
               (<FSET? ,TRELLIS ,UNTEEDBIT>
		<RFALSE>)
	       (<AND <VERB? PUT-ON PUT>
		     <PRSO? ,LEAVES>
		     <FSET? ,TRELLIS ,MUNGBIT>>
		<COND (<IN? ,LEAVES ,TREE-HOLE>
		       <CANT-REACH ,LEAVES>)
		      (T
		       <SETG LEAVES-PLACED T>
		       <FCLEAR ,TREE-HOLE ,OPENBIT>
		       <FSET ,LEAVES ,NDESCBIT>
		       <FSET ,LEAVES ,TRYTAKEBIT>
		       <MOVE ,LEAVES ,TRELLIS>
		       <TELL "The leaves cover the trellis." CR>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,TREE-HOLE>>
		<COND (<FSET? ,TRELLIS ,MUNGBIT>
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <COND (<IN? ,LEAVES ,TRELLIS>
			      <SETG LEAVES-PLACED T>
			      <FCLEAR ,TREE-HOLE ,OPENBIT>
			      <FSET ,LEAVES ,NDESCBIT>
			      <FSET ,LEAVES ,TRYTAKEBIT>)>
		       <MOVE ,TRELLIS ,HERE>
		       <FSET ,TRELLIS ,TRYTAKEBIT>
		       <FSET ,TRELLIS ,MUNGBIT>
		       <TELL "The trellis barely spans the hole." CR>)>)
	       (<AND <VERB? TAKE>
		     <FSET? ,TRELLIS ,TRYTAKEBIT>
		     <NOT <UNTOUCHABLE? ,TRELLIS>>>
		<UNDO-TRAP>
		<RFALSE>)
	       (<AND <VERB? CLIMB CLIMB-ON>
		     <EQUAL? ,HERE ,GARDEN>
		     <FSET? ,TRELLIS ,TRYTAKEBIT>>
		<UNDO-TRAP>
		<TELL "It falls over." CR>)
	       (<AND <VERB? MOVE REMOVE>
		     <FSET? ,TRELLIS ,MUNGBIT>>
		<UNDO-TRAP>
		<TELL "You uncover the hole." CR>)
	       (<AND <VERB? PUT-AGAINST>
		     <PRSI? ,HOUSE>>
		<TELL "The trellis is too flimsy to climb." CR>)
	       (<AND <VERB? LOOK-INSIDE>
		     <EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?THROUGH>>
		<V-LOOK>)
	       (<VERB? MEASURE>
		<TELL "It's six or seven feet wide." CR>)
	       (<AND <VERB? EXAMINE>
		     ,LEAVES-PLACED>
		<FCLEAR ,LEAVES ,NDESCBIT>
		<V-EXAMINE>
		<FSET ,LEAVES ,NDESCBIT>)
	       (<AND <VERB? EXAMINE>
		     <NOT <FIRST? ,TRELLIS>>>
		<TELL
"The trellis is a tight lattice of white wood. Though slightly
wider at the top, it is approximately square in shape." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,TREE-HOLE>>
		<TELL ,TRELLIS-TOO-WIDE>)
	       (<AND <VERB? STAND-ON BOARD>
		     <FSET? ,TRELLIS ,MUNGBIT>>
		<ROB ,TRELLIS ,TREE-HOLE>
	 	<REMOVE ,TRELLIS>
		<MOVE ,PROTAGONIST ,TREE-HOLE>
		<SETG OHERE <>>
		<TELL "Crash! You">
		<AND-SIDEKICK ,TREE-HOLE>
		<UNDO-TRAP>
		<TELL " are now in the hole, along with some splinters." CR>)>>

<ROUTINE TRELLIS-VISIBLE ()
	 <TELL "The edge of a trellis is just visible under" A ,LEAVES ".">>

<ROUTINE DESCRIBE-TRELLIS-ON-HOLE ()
	 <COND (,LEAVES-PLACED
		<TRELLIS-VISIBLE>)
	       (T
		<TELL "A trellis covers the hole.">)>>

<ROUTINE UNDO-TRAP ()
	 <COND (,LEAVES-PLACED
		<SETG LEAVES-PLACED <>>
		<FCLEAR ,LEAVES ,TRYTAKEBIT>
		<FCLEAR ,LEAVES ,NDESCBIT>)>
	 <FSET ,TREE-HOLE ,OPENBIT>
	 <FCLEAR ,TRELLIS ,TRYTAKEBIT>
	 <FCLEAR ,TRELLIS ,MUNGBIT>
	 <FCLEAR ,TRELLIS ,NDESCBIT> ;"for first time you take it in Garden"
	 <FSET ,TRELLIS ,OPENBIT> ;"ditto"
	 <FSET ,TRELLIS ,CONTBIT> ;"ditto"
	 <FSET ,TRELLIS ,SURFACEBIT> ;"ditto">

<ROUTINE FIRST-FLOOR-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <DO-WALK ,P?DOWN>)
		      (<EQUAL? ,HERE ,TEENSY-WEENSY-HOUSE>
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?UP>)>)
	       (<EQUAL? ,HERE ,TEENSY-WEENSY-HOUSE>
		<COND (<PRSO? ,FIRST-FLOOR>
		       <PERFORM-PRSA ,GLOBAL-ROOM ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM-PRSA ,PRSO ,GLOBAL-ROOM>)>)>>

<ROUTINE SECOND-FLOOR-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,TEENSY-WEENSY-HOUSE>
		       <DO-WALK ,P?UP>)
		      (<EQUAL? ,HERE ,BEDROOM>
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<COND (<EQUAL? ,HERE ,BEDROOM>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<EQUAL? ,HERE ,BEDROOM>
		<COND (<PRSO? ,SECOND-FLOOR>
		       <PERFORM-PRSA ,GLOBAL-ROOM ,PRSI>
		       <RTRUE>)
		      (T
		       <PERFORM-PRSA ,PRSO ,GLOBAL-ROOM>)>)>>

<ROOM BEDROOM
      (LOC ROOMS)
      (DESC "Bedroom")
      (LDESC
"The second floor of the house has an open window overlooking the street and
a stair leading down.")
      (DOWN PER BEDROOM-EXIT-F)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL STAIRS WINDOW HOUSE FIRST-FLOOR SECOND-FLOOR)
      ;(THINGS <PSEUDO (FIRST FLOOR FIRST-FLOOR-F)
		      (SECOND FLOOR SECOND-FLOOR-F)>)>

<ROUTINE BEDROOM-EXIT-F ("OPTIONAL" (CALLED-BY-STAIRS-F <>))
	 <COND (<AND ,SIDEKICK-TRIP-FLAG
		     <QUEUED? ,I-SIDEKICK-OUT-WINDOW>>
		<TELL "Just as you are about to..." CR>
		<RFALSE>)
	       (<AND ,SHEET-HANGING
		     <NOT .CALLED-BY-STAIRS-F>>
		<TELL
"Choice: You could climb down the stairs or the rope." CR>
		<RFALSE>)
	       (T
	 	,TEENSY-WEENSY-HOUSE)>>

<OBJECT BED
	(LOC BEDROOM)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS VEHBIT NDESCBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT)
	(CAPACITY 100)
	(ACTION BED-F)>

<ROUTINE BED-F ()
	 <COND (<VERB? MAKE>
		<V-CLEAN>)
	       (<AND <VERB? EXAMINE>
		     <OR ,SHEET-TIED
			 <FSET? ,SHEET ,TRYTAKEBIT>>>
		<SHEET-F ,M-OBJDESC>
		<COND (<FIRST? ,BED>
		       <COND (<AND <EQUAL? <FIRST? ,BED> ,SHEET>
				   <NOT <NEXT? ,SHEET>>>
			      <CRLF>)
			     (T
			      <TELL " ">
			      <RFALSE>)>)
		      (T
		       <CRLF>)>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSO? ,RAFT ,STOOL>>
		<WASTES> ;"don't want nested vehicles")
	       (<VERB? MOVE PUSH>
		<TELL "The bed is too heavy to move." CR>)>>

<GLOBAL SHEET-HANGING <>>

<GLOBAL SHEET-TIED <>>

<OBJECT SHEET
	(LOC BEDROOM)
	(SDESC "sheet")
	(NO-T-DESC "shee")
	(DESCFCN SHEET-F)
	(SYNONYM SHEET STRIPS END ROPE)
	(ADJECTIVE OTHER SHEE CLOTH) ;"no synonym slots left...sigh"
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT)
	(ACTION SHEET-F)>

<ROUTINE SHEET-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<OR ,SHEET-TIED
			   <FSET? ,SHEET ,TRYTAKEBIT>>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <COND (<NOT <VERB? EXAMINE>>
			      <TELL "   ">)>
		       <COND (,SHEET-TIED
			      <TELL "A " D ,SHEET " is tied to the bed">
		       	      <COND (,SHEET-HANGING
				     <TELL ", its other end out the window">)>
		       	      <TELL ".">)
			     (T
		       	      <TELL
"The bed is unmade, with the sheet lying half on the floor.">)>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? MAKE>
		     <NOUN-USED ,W?ROPE ,SHEET>>
		<COND (<FSET? ,SHEET ,MUNGBIT>
		       <PERFORM ,V?TIE-TOGETHER ,SHEET>
		       <RTRUE>)
		      (T
		       <TELL "Be less general." CR>)>)
	       (<AND <VERB? TIE MAKE-WITH>
		     <PRSO? ,PRSI> ;"both PRSO and PRSI are the sheet">
		<PERFORM ,V?TIE-TOGETHER ,SHEET>
		<RTRUE>)
	       (<VERB? TIE-TOGETHER>
		<COND (<FSET? ,SHEET ,MUNGBIT>
		       <TELL ,SENILITY-STRIKES>)
		      (<FSET? ,SHEET ,NARTICLEBIT>
		       <FCLEAR ,SHEET ,NARTICLEBIT>
		       <FCLEAR ,SHEET ,PLURALBIT>
		       <FSET ,SHEET ,MUNGBIT>
		       <PUTP ,SHEET ,P?SDESC "rope of cloth">
		       <PUTP ,SHEET ,P?NO-T-DESC "rope of cloh">
		       <TELL
"With the expertise of one who has watched countless prison escape movies,
you tie the strips into a rope." CR>)
		      (T
		       <TELL "Tying the ends of the sheet together">
		       <HO-HUM>)>)
	       (<AND <NOUN-USED ,W?ROPE ,SHEET>
		     <NOT <FSET? ,SHEET ,MUNGBIT>>>
		<CANT-SEE ,SHEET>)
	       (<AND <VERB? PUT TAKE>
		     <PRSO? ,SHEET>
		     <FSET? ,SHEET ,TRYTAKEBIT>
		     <NOT <PRSI? ,WINDOW>>>
		<COND (,SHEET-TIED
		       <DO-FIRST "untie it">)
		      (T
		       <FCLEAR ,SHEET ,TRYTAKEBIT>
		       <FCLEAR ,BED ,NDESCBIT>
		       <RFALSE>)>)
	       (<FSET? ,SHEET ,UNTEEDBIT>
		<RFALSE>)
	       (<OR <VERB? RIP>
		    <AND <VERB? CUT>
			 <PRSO? ,SHEET>>>
		<COND (<OR <FSET? ,SHEET ,NARTICLEBIT>
			   <FSET? ,SHEET ,MUNGBIT>>
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <SETG SHEET-TIED <>>
		       <FSET ,SHEET ,NARTICLEBIT>
		       <FCLEAR ,SHEET ,TRYTAKEBIT>
		       <FCLEAR ,BED ,NDESCBIT>
		       <FSET ,SHEET ,PLURALBIT>
		       <PUTP ,SHEET ,P?SDESC "strips of cloth">
		       <PUTP ,SHEET ,P?NO-T-DESC "srips of cloh">
		       <TELL "You rip the sheet into" TR ,SHEET>)>)
	       (<AND <VERB? TIE>
		     <PRSO? ,SHEET>>
		<COND (,SHEET-TIED
		       <TELL "But" T ,SHEET " is already tied to the bed." CR>)
		      (<FSET? ,SHEET ,NARTICLEBIT>
		       <TELL
"Unless you want to make a nice decorative fringe for" T ,PRSI ", that">
		       <HO-HUM>)
		      (<PRSI? ,BED>
		       <SETG SHEET-TIED T>
		       <FSET ,BED ,NDESCBIT>
		       <FSET ,SHEET ,TRYTAKEBIT>
		       <MOVE ,SHEET ,HERE>
		       <NOW-TIED ,BED>)
		      (<AND <FSET? ,PRSI ,ACTORBIT>
			    <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		       <RFALSE> ;"V-TIE will say KINKY!")
		      (<NOT <PRSO? ,BLANKET>> ;"BLANKET-F handles it"
		       <WASTES>)>)
	       (<AND <VERB? UNTIE>
		     ,SHEET-TIED>
		<FCLEAR ,SHEET ,TRYTAKEBIT>
		<SETG SHEET-TIED <>>
		<MOVE ,SHEET <LOC ,PROTAGONIST>>
		<COND (,SHEET-HANGING
		       <FCLEAR ,BED ,NDESCBIT>
		       <SETG SHEET-HANGING <>>
		       <TELL "You pull in" T ,PRSO " and untie it." CR>)
		      (T
		       <TELL "Untied." CR>)>)
	       (<AND <VERB? PUT-THROUGH PUT>
		     <PRSI? ,WINDOW>>
		<COND (,SHEET-HANGING
		       <TELL ,SENILITY-STRIKES>)
		      (,SHEET-TIED
		       <COND (<NOT <FSET? ,SHEET ,MUNGBIT>>
			      <TELL
"The sheet would barely reach the window, let alone the ground below!" CR>
			      <RTRUE>)>
		       <MOVE ,SHEET ,HERE>
		       <SETG SHEET-HANGING T>
		       <TELL "The " D ,SHEET " hangs almost to the ground.">
		       <COND (<OR <NOT <IN? ,SIDEKICK ,HERE>>
				  ,SIDEKICK-TRIP-FLAG ;"he already went once">
			      <CRLF>
			      <RTRUE>)>
		       <QUEUE I-SIDEKICK-OUT-WINDOW 2>
		       <TELL
" " D ,SIDEKICK " looks awed. \"Super idea! Doesn't look too strong,
though. I'm lighter, so I'll go down.\"" CR>)>)
	       (<VERB? MOVE>
		<COND (,SHEET-HANGING
		       <SETG SHEET-HANGING <>>
		       <TELL "You pull" T ,SHEET " back into the room." CR>)
		      (,SHEET-TIED
	       	       <PERFORM-PRSA ,BED>
	       	       <RTRUE>)>)
	       (<AND <VERB? CLIMB-DOWN>
		     ,SHEET-HANGING>
		<TELL "The rope rips under your weight. ">
		<PLUMMET-TO-PAVEMENT>)
	       (<AND <VERB? MEASURE>
		     <FSET? ,SHEET ,MUNGBIT>>
		<TELL "Long enough." CR>)
	       (<AND <VERB? EXAMINE>
		     <OR ,SHEET-TIED
			 <FSET? ,SHEET ,TRYTAKEBIT>>>
	        <SHEET-F ,M-OBJDESC>
	        <CRLF>)>>

<ROUTINE PLUMMET-TO-PAVEMENT ()
	 <JIGS-UP
"After plummeting to the pavement, ambulances rush up to take you the finest
hospitals in Cleveland. If only the ambulances had all picked the same
hospital, there might've been a chance to put you back together.">>

<ROUTINE I-SIDEKICK-OUT-WINDOW ()
	 <TELL "   ">
	 <COND (,SIDEKICK-TRIP-FLAG
		<FSET ,BEDROOM ,MUNGBIT>
		<MOVE ,SIDEKICK ,HERE>
		<MOVE ,HEADLIGHT ,HERE>
		<INCREMENT-SCORE 14 33 T>
		<TELL
"The ceiling collapses into a cloud of old plaster and startled termites,
and out of the middle of it steps " D ,SIDEKICK ", looking dishevelled but,
for the most part, alive!|
   \"That truck explosion knocked me into the basement of some nutty professor,
who strapped me into a faster-than-light missile he was about to test! Halfway
to Pluto, I was intercepted by slavers looking for asteroid mining laborers. I
beat off about thirty of 'em, but they just kept coming and coming. Just then
I noticed" A ,HOLE " which led to a spot about four feet above the floor of
the attic ... or what used to be the floor of the attic. Anyway, I got the "
'HEADLIGHT "!\" ">
		<HE-SHE T>
		<TELL
" points to the battered but usable " 'HEADLIGHT " on the floor." CR>)
	       (<OR <NOT <EQUAL? ,HERE ,BEDROOM>>
		    <NOT ,SHEET-HANGING>>
		<DEQUEUE I-SIDEKICK-OUT-WINDOW>
		<TELL
"\"Okay, forget the " 'HEADLIGHT ",\" shrugs " D ,SIDEKICK ,PERIOD-CR>)
	       (T
		<MOVE ,FORD ,HERE>
		<REMOVE ,SIDEKICK>
		<REMOVE ,HEADLIGHT>
		<SETG FOLLOW-FLAG 1>
		<QUEUE I-FOLLOW 2>
		<FCLEAR ,HEADLIGHT ,NDESCBIT>
		<FCLEAR ,HEADLIGHT ,TRYTAKEBIT>
		<SETG SIDEKICK-TRIP-FLAG T>
		<QUEUE I-SIDEKICK-OUT-WINDOW 1>
		<TELL
D ,SIDEKICK " climbs down the rope and unscrews the " 'HEADLIGHT ". Suddenly,
a truck barrels down the street and hits " D ,SIDEKICK ", carrying ">
		<HIM-HER>
		<TELL
" out of sight. Moments later, you hear an explosion. As the smoke
drifts past the window">
		<MEMORIAM>)>>

<OBJECT HEADLIGHT
	(DESC "headlight")
	(NO-T-DESC "headligh")
	(SYNONYM HEADLIGHT LIGHT LIGH)
	(ADJECTIVE FORD HEAD)
	(FLAGS TAKEBIT TRYTAKEBIT NDESCBIT)
	(ACTION HEADLIGHT-F)>

<ROUTINE HEADLIGHT-F ()
	 <COND (<AND <VERB? EXAMINE>
		     <FSET? ,HEADLIGHT ,TRYTAKEBIT>>
		<TELL "It looks loose." CR>)
	       (<AND <TOUCHING? ,HEADLIGHT>
		     <FSET? ,HEADLIGHT ,TRYTAKEBIT>>
		<CANT-REACH ,HEADLIGHT>)>>

<OBJECT FORD
	(DESC "Ford")
	(SYNONYM FORD CAR AUTO)
	(ADJECTIVE NUMBER) ;"so you can refer to it as 1933 FORD"
	(FLAGS NDESCBIT)
	(ACTION FORD-F)>

<ROUTINE FORD-F ()
	 <COND (<AND <ADJ-USED ,W?NUMBER>
		     <NOT <EQUAL? ,P-NUMBER 1933>>>
		<CANT-SEE ,FORD> ;"will this really work?")
	       (<TOUCHING? ,FORD>
		<CANT-REACH ,FORD>)>>
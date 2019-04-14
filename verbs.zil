"VERBS for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

;"subtitle game commands"

<GLOBAL VERBOSITY 1> ;"0 = superbrief, 1 = brief, 2 = verbose"

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSITY 2>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSITY 1>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPERBRIEF ()
	 <SETG VERBOSITY 0>
	 <TELL "Superbrief descriptions." CR>>

<GLOBAL NAUGHTY-LEVEL 1> ;"0 = tame, 1 = suggestive, 2 = lewd"

<GLOBAL AGE -1>

<ROUTINE V-TAME ()
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<TELL ,ALREADY-IN-MODE>)
	       (T
		<SETG NAUGHTY-LEVEL 0>
	        <TELL "Tame descriptions. [Yawn.]" CR>)>>

<ROUTINE V-SUGGESTIVE ()
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 1>
		<TELL ,ALREADY-IN-MODE>)
	       (T
		<SETG NAUGHTY-LEVEL 1>
		<TELL "Suggestive descriptions." CR>)>>

<ROUTINE V-LEWD ("AUX" (ACCEPTABLE-AGE <>))
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 2>
		<TELL ,ALREADY-IN-MODE>
		<RTRUE>)
	       (<G? ,AGE 17>
		<SET ACCEPTABLE-AGE T>)
	       (T
	 	<PUTB ,P-LEXV 0 10>
		<TELL "What is your age? >">
	 	<REPEAT ()
	 	 <PUTB ,P-INBUF 1 0>
		 <READ ,P-INBUF ,P-LEXV>
		 <CRLF>
		 <COND (<EQUAL? <NUMBER? ,P-LEXSTART> ,W?NUMBER>
			<COND (<L? ,P-NUMBER 18>
			       <SETG AGE ,P-NUMBER>
			       <COND (<L? ,P-NUMBER 5>
				      <TELL
"Precocious, aren't you! Unfortunately">)
				     (T
				      <TELL "Sorry">)>
			       <TELL
", you must be at least 18 to enter LEWD mode." CR>
			       <RETURN>)
			      (<G? ,P-NUMBER 120>
			       <TELL "Bullpuckies. Tell the truth. >">)
			      (<AND <G? ,AGE -1>
				    <L? ,AGE 19>>
			       <TELL
"Liar! You said before that you were " N ,AGE ,PERIOD-CR>
			       <RETURN>)
			      (T
			       <SETG AGE ,P-NUMBER>
			       <TELL "Acceptable age. ">
			       <SET ACCEPTABLE-AGE T>
			       <RETURN>)>)
			 (T
			  <TELL "Please tell me your age! >">)>>
		<PUTB ,P-LEXV 0 60>)>
	 <COND (.ACCEPTABLE-AGE
		<TELL "Switching to LEWD level." CR>
		<SETG NAUGHTY-LEVEL 2>)>>

<ROUTINE V-$REFRESH ()
	 <LOWCORE FLAGS <BAND <LOWCORE FLAGS> <BCOM 4>>>
	 <CLEAR -1>
	 <INIT-STATUS-LINE>
	 <RTRUE>>

<ROUTINE V-SAVE ("AUX" X)
	 <COND (<AND <EQUAL? ,HERE ,AUDIENCE-CHAMBER>
		     <NOT ,RIDDLE-ANSWERED>>
		<TELL
"\"Oh, all right,\" says" T ,SULTAN ", \"I'll bend the rules a tad.
You may SAVE.\"" CR CR>)>
	 <SETG P-CONT <>> ;"flush anything on input line after SAVE"
	 <SETG QUOTE-FLAG <>>
	 <SET X <SAVE>>
	 <COND (<BTST <LOWCORE FLAGS> 4>
		<V-$REFRESH>)
	       (<EQUAL? .X 2>
		<INIT-STATUS-LINE>)>
	 <COND (<ZERO? .X>
		<TELL ,FAILED>
		<RFATAL>)
	       (T
	        <TELL ,OK>
		<COND (<NOT <EQUAL? .X 1>>
		       <PERFORM ,V?LOOK>)>
		<RTRUE>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
	        <TELL ,OK>)
	       (T
		<TELL ,FAILED>)>>

<ROUTINE TELL-SCORE ()
	 <TELL "In " N ,MOVES " turn">
	 <COND (<NOT <EQUAL? ,MOVES 1>>
		<TELL "s">)>
	 <TELL
", you have achieved a score of, um, oh, call it " N ,SCORE " out of "
N ,EXT-MAX " points. This gives you the rank of ">
	 <COND (,MALE
		<TELL <GET ,MALE-RANKS ,RANK>>)
	       (T
		<TELL <GET ,FEMALE-RANKS ,RANK>>)>
	 <TELL ,PERIOD-CR>>

<CONSTANT MALE-RANKS
	<TABLE
	 "Sandusky Stablehand"
	 "Knight of Columbus"
	 "Baron of Buffalo"
	 "Viscount of Van Wert County"
	 "Earl of Altoona"
	 "Marquess of McKeesport"
	 "Duke of Detroit"
	 "Prince of Pike's Peak"
	 "King of Queens"
	 "Interplanetary Emperor">>

<CONSTANT FEMALE-RANKS
	<TABLE
	 "Sandusky Stablehand"
	 "Dame of Dayton"
	 "Baroness of Buffalo"
	 "Viscountess of Van Wert County"
	 "Countess of Cleveland"
	 "Marchioness of McKeesport"
	 "Duchess of Detroit"
	 "Princess of Pike's Peak"
	 "Queen of King of Prussia"
	 "Interplanetary Empress">>

;<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<CORP-NOTICE "begins">
	<V-VERSION>>

<ROUTINE V-SCRIPT ()
         <PRINT "[Transcripting o">
	 <TELL "n.]" CR>
	 <DIROUT ,D-PRINTER-ON>
	 <COPR-NOTICE "begins">
	 <RTRUE>>

;<ROUTINE V-UNSCRIPT ()
	<CORP-NOTICE "ends">
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE V-UNSCRIPT ()
	 <COPR-NOTICE "ends">
	 <DIROUT ,D-PRINTER-OFF>
	 <PRINT "[Transcripting o">
	 <TELL "ff.]" CR>
	 <RTRUE>>

;<ROUTINE CORP-NOTICE (STRING)
	 <TELL
"Here " .STRING " a transcript of interaction with " ,LGOP-CAPS ,PERIOD-CR>>

<ROUTINE COPR-NOTICE (STR)
	 <DIROUT ,D-SCREEN-OFF>
	 <TELL CR "Here " .STR "s a transcript of interaction with" CR>
	 <V-VERSION>
	 <DIROUT ,D-SCREEN-ON>
	 <RTRUE>>

<ROUTINE V-DIAGNOSE ()
	 <COND (<NOT <FSET? ,CELL ,TOUCHBIT>>
		<TELL "You're pretty drunk">
		<COND (<RUNNING? ,I-URGE>
		       <TELL ", and your bladder is about to burst">)>)
	       (<G? ,ION-DEATH-COUNTER 0>
		<TELL
"You now have a " <GET ,ION-TABLE ,ION-DEATH-COUNTER> " headache">)
	       (<AND <FSET? ,CATACOMBS ,MUNGBIT>
		     <IN-CATACOMBS>>
		<TELL "You have some tiny wounds">)
	       (<OR <AND ,GONE-APE
			 <EQUAL? ,SUGAR-RUSH ,GORILLA-ATE-CHOCOLATE>>
		    <AND <NOT ,GONE-APE>
			 <EQUAL? ,SUGAR-RUSH ,HUMAN-ATE-CHOCOLATE>>>
		<TELL "You're experiencing a sugar rush">)
	       (<AND <EQUAL? ,HERE ,RUINED-CASTLE-2>
		     <FSET? ,HERE ,MUNGBIT>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<TELL "You feel ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 1>
		       <TELL "sexually unsatisfied">)
		      (T
		       <TELL "horny">)>)
	       (<AND <EQUAL? ,HERE ,IN-SPACE>
		     <NOT <FSET? ,WHITE-SUIT ,WORNBIT>>>
		<TELL "Brrr">)
	       (T
         	<TELL "You are in good health">
		<COND (,GONE-APE
		       <TELL " (for a gorilla)">)>)>
	 <TELL ,PERIOD-CR>>

<ROUTINE V-INVENTORY ()
	 <COND (<AND ,GONE-APE
		     <NOT <FIRST? ,PROTAGONIST>>>
		<TELL "You are empty-pawed." CR>)
	       (T
	 	<DESCRIBE-CONTENTS ,PROTAGONIST <>> ;"you can't have nothing"
	 	<COND (<AND <ULTIMATELY-IN? ,FLASHLIGHT>
			    <EQUAL? ,HERE ,JOES-BAR ,MENS-ROOM ,LADIES-ROOM>>
		       <TELL
" It's not clear why you've carried" A ,FLASHLIGHT " into " 'JOES-BAR ", except
that the lighting in the bathrooms isn't too reliable.">)>
		<CRLF>)>>

<ROUTINE V-QUIT ()
	 <TELL-SCORE>
	 <DO-YOU-WISH "leave the game">
	 <COND (<YES?>
		<QUIT>)
	       (T
		<TELL ,OK>)>>

<ROUTINE V-RESTART ()
	 <TELL-SCORE>
	 <DO-YOU-WISH "restart">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL ,FAILED>)>>

<ROUTINE DO-YOU-WISH (STRING)
	 <TELL CR "Do you wish to " .STRING "? (Y is affirmative): ">>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <PUTB ,P-INBUF 1 0>
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<YES-WORD <GET ,P-LEXV 1>>
		<RTRUE>)
	       (<OR <NO-WORD <GET ,P-LEXV 1>>
		    <EQUAL? <GET ,P-LEXV 1> ,W?N>>
		<RFALSE>)
	       (T
		<TELL "Please answer YES or NO. ">
		<AGAIN>)>>

<ROUTINE FINISH ("AUX" (REPEATING <>) (CNT 0))
	 <PROG ()
	       <CRLF>
	       <COND (<NOT .REPEATING>
		      <SET REPEATING T>
		      <TELL-SCORE>)>
	       <TELL
"Would you like to start over, restore a saved position, end this
session of the game, or look at hints?|
(Type RESTART, RESTORE, QUIT, or HINTS):|
>">
	       <PUTB ,P-LEXV 0 10>
	       <PUTB ,P-INBUF 1 0>
	       <READ ,P-INBUF ,P-LEXV>
	       <PUTB ,P-LEXV 0 60>
	       <SET CNT <+ .CNT 1>>
	       <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTART>
	              <RESTART>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<AND <EQUAL? <GET ,P-LEXV 1> ,W?RESTORE>
		      	   <NOT <RESTORE>>>
		      <TELL ,FAILED>
		      <AGAIN>)
	       	     (<OR <EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
			  <G? .CNT 10>>
		      <QUIT>)
		     (<EQUAL? <GET ,P-LEXV 1> ,W?HINTS ,W?HINT>
		      <V-HINT>
		      <AGAIN>)>
	       <AGAIN>>>

<ROUTINE V-STATUS ()
	 <TELL "You are currently in ">
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<TELL "tame">)
	       (<EQUAL? ,NAUGHTY-LEVEL 1>
		<TELL "suggestive">)
	       (T
		<TELL "lewd">)>
	 <TELL " mode and are getting ">
	 <COND (<EQUAL? ,VERBOSITY 0>
		<TELL "superbrief">)
	       (<EQUAL? ,VERBOSITY 1>
		<TELL "brief">)
	       (T
		<TELL "verbose">)>
	 <TELL " descriptions. ">
	 <TELL-SCORE>>

<ROUTINE V-$ID ()
	 <TELL "Interpreter ">
	 <PRINTN <GETB 0 30>>
	 <TELL " Version ">
	 <PRINTC <GETB 0 31>>
	 <CRLF>
	 <RTRUE>>

<ROUTINE V-VERSION ("AUX" (CNT 17) V)
	 <SET V <BAND <GET 0 1> *3777*>>
	 <TELL ,LGOP-CAPS CR
"Infocom interactive fiction -- a racy space-age spoof|
Copyright (c) 1986 by Infocom, Inc. All rights reserved.|"
,LGOP-CAPS " is a trademark of Infocom, Inc.|
Release " N .V " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <TELL " / ">
	 <V-$ID>
	 <CRLF>>

<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

<ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-$RANDOM ()
	 <COND (<NOT <PRSO? ,INTNUM>>
		<TELL "ILLEGAL." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-$RECORD ()
	 <DIROUT ,D-RECORD-ON> ;"all READS and INPUTS get sent to command file"
	 <RTRUE>>

<ROUTINE V-$UNRECORD ()
	 <DIROUT ,D-RECORD-OFF>
	 <RTRUE>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 69>>
		<TELL N ,SERIAL CR>)
	       (T
		<TELL "Verifying." CR>
	 	<COND (<VERIFY>
		       <TELL ,OK>)
	       	      (T
		       <TELL CR "** Bad **" CR>)>)>>

<CONSTANT SERIAL 0>

;<GLOBAL DEBUG <>>

;<ROUTINE V-$DEBUG ()
	 <TELL "O">
	 <COND (,DEBUG
		<SETG DEBUG <>>
		<TELL "ff">)
	       (T
		<SETG DEBUG T>
		<TELL "n">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE V-$CATACOMB ()
	 <COND (<==? ,HERE ,CATACOMBS>
		<COND (<NOT <OR <FSET? ,RAFT ,TOUCHBIT>
				<FSET? ,PHONE-BOOK ,TOUCHBIT>
				<NOT <FSET? ,TORCH ,LIGHTBIT>>>>
		       <MOVE ,RAFT ,PROTAGONIST>
		       <FSET ,RAFT ,TOUCHBIT>
		       <SETG RAFT-HELD <>>
		       <MOVE ,PHONE-BOOK ,PROTAGONIST>
		       <FSET ,PHONE-BOOK ,TOUCHBIT>
		       <FSET TORCH-LIFE 2>
		       <QUEUE I-TORCH 6>
		       <INCREMENT-SCORE 21 29 T>
		       <TELL 
"Through the miracle of modern technology you are transported to ..." CR CR>
		       <GOTO ,LADDER-ROOM>)
		      (T 
		       <TELL
"You can't cheat once you've disturbed the catacombs." CR>)>)
		(T
		 <TELL
"You can't cheat unless you are in the catacombs." CR>)>>

;<ROUTINE CHEAT ()
	 <SETG SEX-CHOSEN T>
	 <SETG MALE T>
	 <FSET ,CELL ,TOUCHBIT>
	 <FSET ,YOUNG-WOMAN ,FEMALEBIT>
	 <PUTP ,SIDEKICKS-BODY ,P?SDESC "Trent's body">
	 <PUTP ,THORBAST ,P?SDESC "Thorbast">
	 <PUTP ,THORBAST-SWORD ,P?SDESC "his sword">
	 <PUTP ,YOUNG-WOMAN ,P?SDESC "young woman">
	 <FSET ,SULTANS-WIFE ,FEMALEBIT>
	 <FSET ,HAREM-GUARD ,FEMALEBIT>
	 <PUTP ,SIDEKICK ,P?SDESC "Trent">
	 <PUTP ,SULTAN ,P?SDESC "Sultan">
	 <PUTP ,PHOTO ,P?SDESC "photo of Jean Harlow">
	 <PUTP ,HAREM ,P?ODOR "perfume">
	 <DEQUEUE I-URGE>
	 <DEQUEUE I-KIDNAPPING>
	 <MOVE ,SIDEKICK ,HERE>>

;<ROUTINE V-$PARTS ("AUX" CNT)
	 <SET CNT 0>
	 <REPEAT ()
	      <MOVE <GET ,PARTS-LIST .CNT> ,SIDEKICK>
	      <SET CNT <+ .CNT 1>>
	      <COND (<EQUAL? .CNT 8>
		     <RETURN>)>>
	 <TELL ,OK>>

;<ROUTINE V-$JUNGLE ()
	 <CHEAT>
	 <MOVE ,CHOCOLATE ,PROTAGONIST>
	 <GOTO ,JUNGLE>>

;<ROUTINE V-$CLEVELAND ()
	<CHEAT>
	<GOTO ,CLEVELAND>>

;<ROUTINE V-$MARS ()
	 <CHEAT>
	 <MOVE ,PAINTING ,PROTAGONIST>
	 <GOTO ,ROYAL-DOCKS>>

;<ROUTINE V-$SULTAN ()
	 <CHEAT>
	 <REPEAT () ;"last digit can't be zero -- number gets reversed"
		 <SETG WIFE-NUMBER <+ 100 <RANDOM 8270>>>
		 <COND (<AND <NOT <EQUAL? <MOD ,WIFE-NUMBER 10> 0>>
			     <NOT <PALINDROME-NUMBER? ,WIFE-NUMBER>>>
			<RETURN>)>>
	 <MOVE ,CODED-MESSAGE ,PROTAGONIST>
	 <GOTO ,MAIN-HALL-OF-PALACE>>

;<ROUTINE V-$POLE ()
	 <CHEAT>
	 <MOVE ,BASKET ,PROTAGONIST>
	 <MOVE ,BLANKET ,PROTAGONIST>
	 <MOVE ,TEN-MARSMID-COIN ,PROTAGONIST>
	 <MOVE ,STAIN ,PROTAGONIST>
	 <FSET ,STAIN ,TOUCHBIT>
	 <SETG RAFT-HELD <>>
	 <FSET ,RAFT ,TOUCHBIT>
	 <MOVE ,RAFT ,PROTAGONIST>
	 <GOTO ,ICY-DOCK>>

;<ROUTINE V-$SHOP ()
	 <CHEAT>
	 <MOVE ,ONE-MARSMID-COIN ,PROTAGONIST>
	 <MOVE ,RAFT ,PROTAGONIST>
	 <SETG RAFT-HELD <>>
	 <FSET ,RAFT ,TOUCHBIT>
	 <GOTO ,CANALVIEW-MALL>>

;"subtitle real verbs"

<ROUTINE V-ALARM ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM-PRSA ,ME>
		<RTRUE>)
	       (T
		<TELL "But" T ,PRSO " isn't asleep." CR>)>>

<ROUTINE V-ANSWER ()
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD <GET ,P-LEXV ,P-CONT>>>
	        <V-YES>
		<STOP>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-NO>
		<STOP>)
	       (<RUNNING? ,I-SNEEZE>
		<RIDDLE-ANSWER>)
	       (<IN? ,HAREM-GUARD ,HERE>
		<PICK-WIFE>)
	       (T
		<TELL "Nobody is awaiting your answer." CR>
	        <STOP>)>>

<ROUTINE V-ANSWER-KLUDGE ()
	 <COND (<NOUN-USED ,W?I ,ME>
		<V-INVENTORY>)
	       (T
	 	<SETG P-WON <>>
		<TELL ,NO-VERB>
		<STOP>)>>

<GLOBAL AWAITING-FAKE-ORPHAN <>>

<ROUTINE ORPHAN-VERB ()
	 <COND (<NOT <EQUAL? ,HERE ,AUDIENCE-CHAMBER ,BEDROOM>>
		<SETG AWAITING-FAKE-ORPHAN <>>
		<RFALSE>)>
	 <PUT ,P-VTBL 0 ,W?ZZMGCK>
	 <PUT ,P-OVTBL 0 ,W?ANSWER>	;"maybe fix 'what do you want to'"
	 <PUT ,P-OTBL ,P-VERB ,ACT?ZZMGCK>
	 <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
	 <PUT ,P-OTBL ,P-PREP1 0>
	 <PUT ,P-OTBL ,P-PREP1N 0>
	 <PUT ,P-OTBL ,P-PREP2 0>
	 <PUT ,P-OTBL 5 0>
	 <PUT ,P-OTBL ,P-NC1 1>
	 <PUT ,P-OTBL ,P-NC1L 0>
	 <PUT ,P-OTBL ,P-NC2 0>
	 <PUT ,P-OTBL ,P-NC2L 0>
	 <SETG P-OFLAG T>>

<ROUTINE V-APPLAUD ()
	 <COND (<IN-CATACOMBS>
		<QUEUE I-BEETLES 6>)>
	 <TELL "Clap." CR>>

<ROUTINE V-APPLY ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (T
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Apply" T ,PRSO " for what? A job?" CR>)>> 

<ROUTINE PRE-SPEAK ()
	 <COND (,GONE-APE
		<TELL
"You open " 'MOUTH " to speak, but all that comes out are a few grunts." CR>
		<STOP>)
	       (<FSET? ,EARS ,MUNGBIT>
		<TELL ,YOU-CANT "carry on a conversation when " 'EARS " are">
		<COND (<EQUAL? ,EARS ,HAND-COVER>
		       <TELL " covered">)
		      (T
		       <TELL " plugged up">)>
		<TELL ,PERIOD-CR>
		<STOP>)>>

<ROUTINE V-ASK-ABOUT ("AUX" OWINNER)
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<OR <FSET? ,PRSO ,ACTORBIT>
		    <AND <PRSO? ,INTNUM>
			 <EQUAL? ,P-NUMBER ,CHOICE-NUMBER>
		     	 <IN? ,SULTANS-WIFE ,HERE>>>
		<SET OWINNER ,WINNER>
		<SETG WINNER ,PRSO>
		<PERFORM ,V?TELL-ABOUT ,ME ,PRSI>
		<SETG WINNER .OWINNER>
		<THIS-IS-IT ,PRSI>
		<THIS-IS-IT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <TELL "Unsurprisingly," T ,PRSO " doesn't oblige." CR>>

<ROUTINE V-ASK-NO-ONE-FOR ("AUX" ACTOR)
	 <COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT>>
		<PERFORM ,V?ASK-FOR .ACTOR ,PRSO>
		<RTRUE>)
	       (T
		<NO-ONE-HERE "ask">)>>

<ROUTINE V-BARTER-WITH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "But" T ,PRSO " has nothing worth trading for." CR>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-BARTER-FOR ()
	 <IMPOSSIBLES>>

<ROUTINE V-BEND ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?SPREAD>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <V-BOARD>)
		      (T
		       <HACK-HACK "Spreading">)>)
	       (T
	        <HACK-HACK "Bending">)>>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE V-BLOW ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)
	       (T
		<CANT-VERB-A-PRSO "blow">)>>

<ROUTINE PRE-BOARD ()
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<TELL ,LOOK-AROUND>)
	       (<AND <ULTIMATELY-IN? ,PRSO>
		     <NOT <PRSO? ,FLEXIBLE-HOLE>>>
		<TELL ,HOLDING-IT>)
	       (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)>>

<ROUTINE V-BOARD ("AUX" (AV <LOC ,PROTAGONIST>))
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<NOT <EQUAL? <LOC ,PRSO> ,HERE ,LOCAL-GLOBALS>>
		       <TELL ,YOU-CANT "board" T ,PRSO " when it's ">
		       <COND (<FSET? <LOC ,PRSO> ,SURFACEBIT>
			      <TELL "on">)
			     (T
			      <TELL "in">)>
		       <TELL TR <LOC ,PRSO>>
		       <RTRUE>)>
		<MOVE ,PROTAGONIST ,PRSO>
		<SETG OHERE <>>
		<TELL "You are now ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n" T ,PRSO ".">
		<COND (<AND <IN? ,SIDEKICK ,HERE>
			    <PRSO? ,BARGE ,RAFT ,STALLION ,TREE-HOLE>>
		       <MOVE ,SIDEKICK ,PRSO>
		       <TELL " " D ,SIDEKICK " gets ">
		       <COND (<FSET? ,PRSO ,INBIT>
			      <TELL "i">)
			     (T
			      <TELL "o">)>
		       <TELL "n behind you.">)>
		<COND (<AND <PRSO? ,BARGE>
			    <NOT <FSET? ,BARGE ,TOUCHBIT>>>
		       <TELL " You notice some simple controls.">)>
		<FSET ,PRSO ,TOUCHBIT>
		<CRLF>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL
"Let's not beat around the bush. Come out and say what you mean." CR>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN>
		<CANT-VERB-A-PRSO "get into">)
	       (T
		<CANT-VERB-A-PRSO "get onto">)>>

<ROUTINE V-BOARD-DIR ()
	 <RECOGNIZE>>

<ROUTINE V-BURN ()
	 <COND (<NOT ,PRSI>
		<COND (<AND <ULTIMATELY-IN? ,TORCH>
			    <FSET? ,TORCH ,ONBIT>>
		       <SETG PRSI ,TORCH>
		       <TELL "[with the torch]" CR>)
		      (T
		       <TELL "You have no source of fire." CR>
		       <RTRUE>)>)>
	 <COND (<OR <NOT <PRSI? ,TORCH>>
		    <NOT <FSET? ,TORCH ,ONBIT>>>
		<TELL ,YOU-CANT "burn something with" AR ,PRSI>)
	       (<AND <PRSO? ,SHEET>
		     ,SHEET-TIED>
		<DO-FIRST "untie" ,PRSO>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<DO-FIRST "leave" ,PRSO>)
	       (<ULTIMATELY-IN? ,PRSO>
		<DO-FIRST "drop" ,PRSO>)
	       (<FSET? ,PRSO ,BURNBIT>
		<COND (<AND <PRSO? ,LEAVES>
			    ,LEAVES-PLACED>
		       <SETG PRSO ,TRELLIS>)>
		<REMOVE ,PRSO>
		<TELL "In an instant," T ,PRSO>
		<COND (<AND <PRSO? ,TRELLIS>
			    ,LEAVES-PLACED>
		       <REMOVE ,LEAVES>
		       <SETG LEAVES-PLACED <>>
		       <TELL " and leaves are">)
		      (T
		       <TELL " is">)>
		<COND (<PRSO? ,TRELLIS>
		       <UNDO-TRAP>)
		      (<PRSO? ,LEAVES>
		       <SETG LEAVES-PLACED <>>)>
		<TELL " consumed by fire." CR>)
	       (T
		<CANT-VERB-A-PRSO "burn">)>>

<ROUTINE V-BUY ()
	 <TELL "Sorry, there aren't any on sale here." CR>>

<ROUTINE V-BUY-WITH ()
	 <COND (<PRSI? ,ONE-MARSMID-COIN ,TEN-MARSMID-COIN>
		<PERFORM ,V?BUY ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"That must be a queer planet you come from, where" A ,PRSI
" is a unit of money." CR>)>>

<ROUTINE V-CALL ()
	 <COND (<EQUAL? ,HERE ,VIZICOMM-BOOTH>
		<PERFORM ,V?SET ,VIZICOMM>
		<RTRUE>)
	       (<NOT <VISIBLE? ,PRSO>>
	        <CANT-SEE ,PRSO>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-CAST-OFF ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?LAUNCH <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)>>

<ROUTINE V-CATCH ()
	 <TELL "The only thing you're good at catching is a cold." CR>>

<ROUTINE V-CHASTISE ()
	 <COND (<PRSO? ,INTDIR>
		<TELL
,YOULL-HAVE-TO "go in that direction to see what's there." CR>)
	       (T
		<TELL
"Use prepositions to indicate precisely what you want to do: LOOK AT the
object, LOOK INSIDE it, LOOK UNDER it, etc." CR>)>>

<ROUTINE V-CHEER ()
	 <COND (<PRSO? ,ROOMS>
		<TELL ,OK>)
	       (T
		<TELL "Probably," T ,PRSO " is as happy as possible." CR>)>>

<ROUTINE V-CLEAN ()
	 <SETG AWAITING-REPLY 2>
	 <QUEUE I-REPLY 2>
	 <TELL "Do you also do windows?" CR>>

<ROUTINE V-CLICK ()
	 <TELL "\"Click.\"" CR>>

<ROUTINE V-CLIMB ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (<AND <FSET? ,PRSO ,ACTORBIT> ;"GO DOWN ON OBJECT"
		     <EQUAL? ,P-PRSA-WORD ,W?GO>>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<OR <FSET? ,PRSO ,VEHBIT>
		    <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN ;,PR?INSIDE>
		<CANT-VERB-A-PRSO "climb into">)
	       (T
		<CANT-VERB-A-PRSO "climb onto">)>>

<ROUTINE V-CLIMB-OVER ()
	 <COND (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?UP>)
	       (<ULTIMATELY-IN? ,PRSO>
		<TELL ,HOLDING-IT>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CLOSE ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,VEHBIT>>
		<CANT-VERB-A-PRSO "close">)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,CONTBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Okay," T ,PRSO " is now closed." CR>
		       <NOW-DARK?>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (T
		<CANT-VERB-A-PRSO "close">)>>

<ROUTINE V-COME ()
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<TELL "Go." CR>)
	       (T
		<TELL "You're not even breathing hard." CR>)>>

<ROUTINE V-COPULATE ("AUX" (LOVER <>))
	 <COND (<SET LOVER <FIND-IN ,HERE ,ACTORBIT "with">>
		<PERFORM ,V?FUCK .LOVER>
		<RTRUE>)
	       (T
		<PERFORM ,V?MAKE ,LOVE>
		<RTRUE>)>>

<ROUTINE V-COUNT ()
	 <IMPOSSIBLES>>

<ROUTINE V-CRAWL-UNDER ()
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
	        <TELL-HIT-HEAD>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-CROSS ()
	 <V-WALK-AROUND>>

<ROUTINE V-CUT ()
	 <COND (<NOT ,PRSI>
		<IMPOSSIBLES>)
	       (T
		<TELL
"To put it bluntly, neither" T ,PRSI " nor you are very sharp." CR>)>>

<ROUTINE V-DECODE ()
	 <TELL ,YOULL-HAVE-TO "figure it out yourself." CR>>

<ROUTINE V-DEFLATE ()
	 <IMPOSSIBLES>>

<ROUTINE V-DIG ()
	 <WASTES>>

<ROUTINE V-DISEMBARK ()
	 <COND (<NOT ,PRSO>
		<COND (<NOT <IN? ,PROTAGONIST ,HERE>>
		       <PERFORM-PRSA <LOC ,PROTAGONIST>>
		       <RTRUE>)
		      (T
		       <TELL ,LOOK-AROUND>)>)
	       (<EQUAL? ,P-PRSA-WORD ,W?TAKE> ;"since GET OUT is also TAKE OUT"
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<NOT <IN? ,PROTAGONIST ,PRSO>>
		<TELL ,LOOK-AROUND>
		<RFATAL>)
	       (<EQUAL? ,HERE ,CANAL>
		<PERFORM ,V?ENTER ,CANAL-OBJECT>
		<RTRUE>)
	       (T
		<MOVE ,PROTAGONIST ,HERE>
		<SETG OHERE <>>
		<TELL "You">
		<COND (<IN? ,SIDEKICK ,PRSO>
		       <MOVE ,SIDEKICK ,HERE>
		       <TELL " and " D ,SIDEKICK>)>
		<TELL " get o">
		<COND (<OFF-VEHICLE? ,PRSO>
		       <TELL "ff">)
		      (T
		       <TELL "ut of">)>
		<TELL T ,PRSO ".">
		<COND (<IN? ,SIDEKICK ,SECOND-SLAB>
		       <MOVE ,SIDEKICK ,HERE>
		       <TELL " You also ">
		       <COND (,SIDEKICKS-BODY-TIED-TO-SLAB
			      <TELL "untie " D ,SIDEKICK " and help ">
		       	      <HIM-HER>)
			     (T
			      <TELL "help " D ,SIDEKICK>)>
		       <TELL " up from" T ,SECOND-SLAB ".">)>
		<CRLF>)>>

<ROUTINE V-DRESS ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <COND (<FSET? ,PRSO ,FEMALEBIT>
			      <TELL "Sh">)
			     (T
			      <TELL "H">)>
		       <TELL "e is dressed!" CR>)
		      (T
		       <IMPOSSIBLES>)>)
	       (T
		<SETG PRSO ,ROOMS>
		<V-GET-DRESSED>)>>

<ROUTINE V-DRINK ()
	 <CANT-VERB-A-PRSO "drink">>

<ROUTINE V-DRINK-FROM ()
	 <IMPOSSIBLES>>

<ROUTINE V-DROP ()
	 <COND (<NOT <SPECIAL-DROP>>
		<COND (<OR <EQUAL? <LOC ,PROTAGONIST> ,BARGE ,RAFT>
			   <EQUAL? <LOC ,PROTAGONIST> ,TREE-HOLE ,CAGE>>
		       <MOVE ,PRSO <LOC ,PROTAGONIST>>)
		      (T
		       <MOVE ,PRSO ,HERE>)>
		<TELL "Dropped." CR>)>>

<ROUTINE SPECIAL-DROP () ;"used by drop and throw"
	 <COND (<IN-CATACOMBS>
		<REMOVE ,PRSO>
		<TELL "With a splash," T ,PRSO " is lost forever." CR>)
	       (<IN-SPACE?>
		<MOVE ,PRSO ,PROTAGONIST>
		<TELL
"In the absence of gravity," T ,PRSO " floats back into " 'HANDS "s." CR>)
	       (<EQUAL? ,HERE ,EXIT-SHOP>
		<MOVE ,PRSO ,DUST>
		<TELL "You lose" T ,PRSO " in the dust." CR>)
	       (<AND <PRSO? ,TORCH>
		     <FSET? ,TORCH ,ONBIT>
		     <IN? ,PROTAGONIST ,BARGE>>
		<PERFORM ,V?PUT ,TORCH ,BARGE>
		<RTRUE>)>>

<ROUTINE V-EAT ()
	 <COND (<AND <FSET? ,PRSO ,ACTORBIT>
		     <NOT ,GONE-APE>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<TELL "As you try," T ,PRSO " slaps you across the face.">
		<COND (<NOT <PRSO? ,MALE-GORILLA ,FEMALE-GORILLA>>
		       <TELL " \"Really, we hardly know each other.\"">)>
		<CRLF>)
	       (T
	 	<TELL
"While the foodstuffs of the universe are many and varied," A ,PRSO>
		<COND (<FSET? ,PRSO ,PLURALBIT>
		       <TELL " are">)
		      (T
		       <TELL " is">)>
		<TELL " not one of them." CR>)>>

<ROUTINE V-EMPTY ("AUX" OBJ NXT)
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,GROUND>)>
	 <COND (<NOT <FSET? ,PRSO ,CONTBIT>>
		<TELL ,HUH>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "But" T ,PRSO " isn't open." CR>)
	       (<NOT <FIRST? ,PRSO>>
		<TELL "But" T ,PRSO " is already empty!" CR>)
	       (<AND <PRSI? <FIRST? ,PRSO>>
		     <NOT <NEXT? ,PRSI>>>
		<TELL ,THERES-NOTHING "in" T ,PRSO " but" TR ,PRSI>)
	       (<IN-SPACE?>
		<TELL ,YOU-CANT "empty" T ,PRSO " without gravity!" CR>)
	       (T
		<SET OBJ <FIRST? ,PRSO>>
		<REPEAT ()
			<SET NXT <NEXT? .OBJ>>
			<COND (<NOT <EQUAL? .OBJ ,PROTAGONIST>>
			       <TELL D .OBJ ": ">
			       <COND (<AND <PRSI? ,TRELLIS>
					   <EQUAL? .OBJ ,LEAVES>>
				      <PERFORM ,V?PUT-ON ,LEAVES ,TRELLIS>)
				     (<FSET? .OBJ ,TAKEBIT>
				      <MOVE .OBJ ,PROTAGONIST>
				      <COND (<PRSI? ,HANDS>
					     <TELL "Taken." CR>)
					    (<PRSI? ,GROUND>
					     <PERFORM ,V?DROP .OBJ>)
					    (<FSET? ,PRSI ,SURFACEBIT>
					     <PERFORM ,V?PUT-ON .OBJ ,PRSI>)
					    (T
					     <PERFORM ,V?PUT .OBJ ,PRSI>)>)
				     (T
				      <YUKS>)>)>
			<COND (.NXT
			       <SET OBJ .NXT>)
			      (T
			       <RETURN>)>>)>>

<ROUTINE V-EMPTY-FROM ()
	 <COND (<IN? ,PRSO ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <MOVE ,PRSO ,PROTAGONIST>
		       <PERFORM ,V?DROP ,PRSO>
		       <RTRUE>)
		      (T
		       <YUKS>)>)
	       (T
		<NOT-IN>)>>

<ROUTINE V-ENTER ()
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<FSET? ,PRSO ,ACTORBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL-HIT-HEAD>)
	      (<ULTIMATELY-IN? ,PRSO>
	       <TELL ,HOLDING-IT>
	       <RTRUE>)
	      (T
	       <IMPOSSIBLES>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<FSET? ,PRSO ,UNTEEDBIT>
		<TELL "It looks just like" A ,PRSO ", whatever that is." CR>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<COND (<FIRST? ,PRSO>
		       <PERFORM ,V?LOOK-INSIDE ,PRSO>
		       <RTRUE>)
		      (T
		       <NOTHING-INTERESTING>
		       <TELL "about" TR ,PRSO>)>)
	       (<OR <FSET? ,PRSO ,DOORBIT>
		    <FSET? ,PRSO ,SURFACEBIT>>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It's closed." CR>)>)
	       (<FSET? ,PRSO ,LIGHTBIT>
		<TELL "It's o">
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ,PERIOD-CR>)
	       (<FSET? ,PRSO ,READBIT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,NARTICLEBIT>
		<SENSE-OBJECT "look">)
	       (<PROB 25>
		<TELL "Totally ordinary looking " D ,PRSO ,PERIOD-CR>)
	       (<PROB 60>
		<NOTHING-INTERESTING>
		<TELL "about" TR ,PRSO>)
	       (T
	        <PRONOUN>
		<TELL " look">
		<COND (<AND <NOT <FSET? ,PRSO ,PLURALBIT>>
			    <NOT <PRSO? ,ME>>>
		       <TELL "s">)>
		<TELL " like every other " D ,PRSO " you've ever seen." CR>)>>

<ROUTINE NOTHING-INTERESTING ()
	 <TELL ,THERES-NOTHING>
	 <COND (<PROB 25>
		<TELL "unusual">)
	       (<PROB 33>
		<TELL "noteworthy">)
	       (<PROB 50>
		<TELL "eye-catching">)
	       (T
		<TELL "special">)>
	 <TELL " ">>

<ROUTINE V-EXIT ()
	 <COND (<AND ,PRSO
		     <FSET? ,PRSO ,VEHBIT>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<NOT <IN-EXITABLE-VEHICLE?>>
		<DO-WALK ,P?OUT>)>>

<ROUTINE IN-EXITABLE-VEHICLE? ("AUX" AV)
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<OR <EQUAL? .AV ,RAFT ,BARGE ,CAGE>
		    <EQUAL? .AV ,TREE-HOLE>>
		<PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-FEED ()
	 <COND (<ULTIMATELY-IN? ,CHOCOLATE>
		<PERFORM ,V?GIVE ,CHOCOLATE ,PRSO>
		<RTRUE>)
	       (T
	 	<TELL "You have no food for" TR ,PRSO>)>>

<ROUTINE V-FILL ()
	 <COND (<AND <OR <FSET? ,PRSO ,CONTBIT>
			 <AND <PRSO? ,STAIN ,CREAM>
		     	      <FSET? ,STAIN ,MUNGBIT>>>
		     <OR <PRSI? ,WATER>
			 <GLOBAL-IN? ,WATER ,HERE>>>
		<WASTES>)
	       (<NOT ,PRSI>
		<TELL ,THERES-NOTHING "to fill it with." CR>)
	       (T 
		<IMPOSSIBLES>)>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <COND (<NOT .L>
		<PRONOUN>
		<TELL " could be anywhere!" CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You have it!" CR>)
	       (<IN? ,PRSO ,HERE>
		<TELL "Right in front of you." CR>)
	       (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    ;<PRSO? ,PSEUDO-OBJECT>>
		<V-DECODE>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "Looks as if" T .L " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? ,PRSO>
		     <NOT <IN? .L ,GLOBAL-OBJECTS>>>
		<COND (<FSET? .L ,SURFACEBIT>
		       <TELL "O">)
		      (<AND <FSET? .L ,VEHBIT>
			    <NOT <FSET? .L ,INBIT>>>
		       <TELL "O">)
		      (T
		       <TELL "I">)>
		<TELL "n" TR .L>)
	       (.WHERE
		<TELL "Beats me." CR>)
	       (T
		<V-DECODE>)>>

<ROUTINE V-FLUSH ()
	 <TELL "It's your brain that needs flushing." CR>>

<ROUTINE V-FOLLOW ()
	 <COND (<VISIBLE? ,PRSO>
		<TELL "But" T ,PRSO " is right here!" CR>)
	       (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<IMPOSSIBLES>)
	       (T
		<TELL "You have no idea where" T ,PRSO " is." CR>)>>

<GLOBAL FOLLOW-FLAG <>>

<ROUTINE I-FOLLOW ()
	 <SETG FOLLOW-FLAG <>>
	 <RFALSE>>

<ROUTINE PRE-FUCK ()
	 <COND (<G? ,ION-DEATH-COUNTER 0>
		<TELL "Not tonight; you have a headache." CR>)>>

<ROUTINE V-FUCK ()
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<TELL
"Shocking! What if your mother saw you typing inputs like that?" CR>)
	       (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL "Not in my game, you pansexual pervert!" CR>)
	       (<EQUAL? ,NAUGHTY-LEVEL 1>
		<TELL
"Unfortunately," T ,PRSO
" doesn't seem interested, and it takes two to tango." CR>)
	       (T
		<TELL
"A slap across the face alerts you that" T ,PRSO " isn't that hot to trot.
And not a goddam single cold shower in sight!" CR>)>>

<ROUTINE PRE-GIVE ()
	 <COND (<AND <VERB? GIVE>
		     <PRSO? ,HANDS>>
		<PERFORM ,V?SHAKE-WITH ,PRSI>
		<RTRUE>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-GET-DRESSED ()
	 <COND (<PRSO? ,ROOMS>
		<TELL "You are!" CR>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-GET-DRUNK ()
	 <COND (<NOT <PRSO? ,ROOMS>>
		<RECOGNIZE>)
	       (<EQUAL? ,HERE ,JOES-BAR>
		<PERFORM ,V?BUY ,BEER>
		<RTRUE>)
	       (T
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Here?" CR>)>>

<ROUTINE V-GET-UNDRESSED ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?TAKE-OFF ,GARMENT>
		<RTRUE>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-GIDDYAP ()
	 <COND (<IN? ,STALLION ,HERE>
		<PERFORM ,V?KICK ,STALLION>
		<RTRUE>)
	       (T
		<TELL ,HUH>)>>

<ROUTINE V-GIVE ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<TELL "Briskly," T ,PRSI " refuses your offer." CR>)
	       (T
		<TELL ,YOU-CANT "give" A ,PRSO " to" A ,PRSI "!" CR>)>>

<ROUTINE V-GIVE-UP ()
	 <COND (<PRSO? ,ROOMS>
		<V-QUIT>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-HELLO ()
       <COND (,PRSO
	      <TELL
"[The proper way to talk to characters in the story is PERSON, HELLO.]" CR>)
	     (T
	      <PERFORM ,V?TELL ,ME>
	      <RTRUE>)>>

;<ROUTINE V-HELP ()
	 <TELL
"If you're in a bind, maps and hint booklets are available from your
\"dealer,\" or via mail order with the form">
	 <IN-PACKAGE>
	 <CRLF>>

<ROUTINE V-HIDE ()
	 <TELL ,YOU-CANT "hide ">
	 <COND (,PRSO
		<TELL "t">)>
	 <TELL "here." CR>>

<ROUTINE V-HISS ()
	 <COND (<VISIBLE? ,FLYTRAP>
		<COND (<NOT <FSET? ,FLYTRAP ,MUNGBIT>> ;"prevent double score"
		       <INCREMENT-SCORE 2 15>)>
		<DEQUEUE I-FLYTRAP>
		<REMOVE ,FLYTRAP>
		<TELL
"The " 'FLYTRAP " assumes the hissing is a spray can of weed killer, dies
of fright, and is immediately consumed by parasites who live inside flytraps
waiting for just such an occasion." CR>)
	       (T
		<TELL "\"Ssss.\"" CR>)>>

<ROUTINE V-IN ("AUX" VEHICLE)
	 <DO-WALK ,P?IN>>

<ROUTINE V-INFLATE ()
	 <IMPOSSIBLES>>

<ROUTINE V-INHALE ()
	 <COND (<NOT ,PRSO>
		<TELL ,OK>)
	       (<PRSO? ,ROOMS>
		<TELL "You begin to get light-headed." CR>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <TELL "Relax." CR>>

<ROUTINE V-KISS ()
	<TELL "\"Smack.\"" CR>>

<ROUTINE V-KISS-ON ()
	 <V-KISS>>

<ROUTINE V-KNEEL ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?BOW>
		<SORE "waist">)
	       (<NOT <PRE-POUR>>
	 	<SORE "knee">)>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Silence answers back." CR>)
	       (T
		<HACK-HACK "Knocking on">)>>

<ROUTINE V-KWEEPA ()
	 <COND (<IN-CATACOMBS>
		<QUEUE I-GATOR 12>)>
	 <TELL
"A Martian hawk, hearing the cry of a possible mate, flies up and begins
squawking and flapping a mating ritual. As it pauses to catch its breath,
it takes a better look at you, rubs its eyes, and flies quickly away." CR>>

<ROUTINE V-LAND ()
	 <COND (<AND <NOT ,PRSO>
		     <EQUAL? <LOC ,PROTAGONIST> ,RAFT ,BARGE>>
		<PERFORM-PRSA <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
	 	<TELL ,HUH>)>>

<ROUTINE V-LAUGH ()
	 <TELL "\"Tee hee.\"" CR>>

<ROUTINE V-LAUNCH ()
	 <TELL "Your brain is out to launch." CR>>

<ROUTINE V-LEAP ()
	 <COND (<OR <PRSO? ,ROOMS>
		    <NOT ,PRSO>>
		<COND (<EQUAL? ,HERE ,ROOF>
		       <JIGS-UP
"You leap, and the gravity of Phobos is so weak that you sail up, up, and away!
You achieve escape velocity and sail into the icy depths of space.">)
		      (<EQUAL? ,HERE ,CLOSET>
		       <TELL "You still can't reach the shelf." CR>)
		      (<EQUAL? ,HERE ,ROCKY-CLIFFTOP ,MINARET>
		       <JIGS-UP "\"Aaaiieeee!\"">)
		      (T
		       <WEE>)>)
	       (<AND ,PRSO
		     <NOT <IN? ,PRSO ,HERE>>>
		<IMPOSSIBLES>)
	       (T
		<WEE>)>>

<ROUTINE V-LEAP-OFF ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?LEAP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LEAVE ()
	 <COND (<NOT ,PRSO>
		<SETG PRSO ,ROOMS>)>
	 <COND (<PRSO? ,ROOMS>
		<DO-WALK ,P?OUT>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LICK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)
	       (T
		<PERFORM ,V?TASTE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LIE-DOWN ()
	 <COND (<AND <EQUAL? ,HERE ,BEDROOM>
		     <PRSO? ,ROOMS>>
		<SETG PRSO ,BED>)>
	 <COND (<OR <FSET? ,PRSO ,VEHBIT>
		    <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
	        <WASTES>)>>

<ROUTINE V-LIMBER ()
	 <TELL "Ahhh. Nothing like a little muscle-loosening." CR>>

<ROUTINE PRE-LISTEN ()
	 <COND (<AND <FSET? ,EARS ,MUNGBIT>
		     <NOT ,GONE-APE>>
		<TELL "You hear the sound of ">
		<COND (<EQUAL? ,EARS ,HAND-COVER>
		       <TELL "sweating palms">)
		      (T
		       <TELL "rustling cotton">)>
		<TELL ,PERIOD-CR>)>>

<ROUTINE V-LISTEN ()
	 <COND (,PRSO
	 	<SENSE-OBJECT "sound">)
	       (<EQUAL? ,HERE ,BOUDOIR>
		<NOT-ALONE-ON-DIVAN>
		<CRLF>)
	       (T
		<TELL "You hear nothing of interest." CR>)>>

<ROUTINE V-LOCK ()
	 <YUKS>>

<ROUTINE PRE-LOOK ()
	 <COND (<AND <VERB? EXAMINE>
		     <EQUAL? ,P-PRSA-WORD ,W?DESCRIBE>
		     <PRSO? ,ODOR>>
		<RFALSE>)
	       (<PLAYER-CANT-SEE>
		<RTRUE>)>>

<ROUTINE V-LOOK ()
	 <COND (<EQUAL? ,HAND-COVER ,EYES>
		<UNIFORMLY-COLORED "Palm" "hands over your eyes">)
	       (<FSET? ,EYES ,MUNGBIT>
		<UNIFORMLY-COLORED "Eyelids" "eyes closed">)
	       (T
	 	<COND (<DESCRIBE-ROOM T>
	 	       <DESCRIBE-OBJECTS>)>
		<RTRUE>)>>

<ROUTINE UNIFORMLY-COLORED (ROOM-NAME STRING)
	 <TELL .ROOM-NAME " Room|
   This location is dim and uniformly colored, resembling what you see
when you have your " .STRING ". In fact, you have your "
.STRING ,PERIOD-CR>>

<ROUTINE V-LOOK-BEHIND ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>
	 <TELL "There is nothing behind" TR ,PRSO>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<PRSO? ,ROOMS>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL ,IT-SEEMS-THAT T ,PRSO " has">
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL ,PERIOD-CR>)>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<DESCRIBE-VEHICLE>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<TELL ,YOU-SEE>
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL " on" TR ,PRSO>)>
		<RTRUE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "All you can tell is that" T ,PRSO " is ">
		<OPEN-CLOSED ,PRSO>
		<TELL ,PERIOD-CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<SEE-INSIDE? ,PRSO>
		       <TELL ,YOU-SEE>
		       <COND (<NOT <DESCRIBE-NOTHING>>
			      <TELL " in" TR ,PRSO>)>
		       <RTRUE>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <COND (<PRE-TOUCH>
			      <RTRUE>)>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <DO-FIRST "open" ,PRSO>)>)
	       (<EQUAL? <GET ,P-ITBL ,P-PREP1> ,PR?IN ;,PR?INSIDE>
		<CANT-VERB-A-PRSO "look inside">)
	       (T
		<TELL
"Even Superman would have trouble seeing through" AR ,PRSO>)>>

<ROUTINE V-LOOK-OVER ()
	 <V-EXAMINE>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<ULTIMATELY-IN? ,PRSO>
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're wearing it!" CR>)
		      (T
		       <TELL ,HOLDING-IT>)>)
	       (T
		<NOTHING-INTERESTING>
		<TELL "under" TR ,PRSO>)>>

<ROUTINE V-LOOK-UP ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<EQUAL? ,HERE ,WELL-BOTTOM>
		       <TELL ,YOU-SEE " a dot of light." CR>)
		      (<IN-CATACOMBS>
		       <TELL ,ONLY-BLACKNESS>)
		      (<FSET? ,HERE ,INDOORSBIT>
		       <PERFORM ,V?EXAMINE ,CEILING>
		       <RTRUE>)
		      (T
		       <TELL "The sky is an inky black." CR>)>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOVE ()
	 <TELL "Not difficult, considering how lovable" T ,PRSO " ">
	 <COND (<FSET? ,PRSO ,PLURALBIT>
		<TELL "are">)
	       (T
		<TELL "is">)>
	 <TELL ,PERIOD-CR>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

<ROUTINE V-MAKE ()
	 <CANT-VERB-A-PRSO "make">>

<ROUTINE V-MAKE-LOVE ()
	 <COND (<PRSO? ,LOVE>
		<PERFORM ,V?FUCK ,PRSI>
		<RTRUE>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-MAKE-OUT ("AUX" KISSEE)
	 <COND (<NOT <PRSO? ,ROOMS>>
		<SET KISSEE ,PRSO>)
	       (<NOT <SET KISSEE <FIND-IN ,HERE ,ACTORBIT "with">>>
		<SET KISSEE ,ME>)>
	 <PERFORM ,V?KISS .KISSEE>
	 <RTRUE>>

<ROUTINE V-MAKE-WITH ()
	 <V-MAKE>>

<ROUTINE V-MARRY ()
	 <TELL "I doubt that" T ,PRSO " is the marrying type." CR>>

<ROUTINE V-MASTURBATE ()
	 <COND (<AND ,PRSO ;"for JERK OFF OBJECT (FIND RLANDBIT)"
		     <NOT <PRSO? ,ROOMS>>>
		<RECOGNIZE>)
	       (<EQUAL? ,NAUGHTY-LEVEL 0>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Don't you know that this causes blindness?" CR>)
	       (T
		<PERFORM ,V?FUCK ,ME>
		<RTRUE>)>>

<ROUTINE V-MEASURE ()
	 <COND (<OR <FSET? ,PRSO ,PARTBIT>
		    <PRSO? ,ME>>
		<TELL "Usual size." CR>)
	       (T
	 	<TELL "The same size as any other " D ,PRSO ,PERIOD-CR>)>>

<ROUTINE V-MOAN ()
	 <TELL "\"Ohhhh...\"" CR>>

<ROUTINE V-MOVE ()
	 <COND (<ULTIMATELY-IN? ,PRSO>
		<WASTES>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving" T ,PRSO " reveals nothing." CR>)
	       (<EQUAL? ,P-PRSA-WORD ,W?PULL>
		<HACK-HACK "Pulling">)
	       (T
		<CANT-VERB-A-PRSO "move">)>>

<ROUTINE V-MUNG ()
	 <COND (<PRSO? ,ROOMS> ;"break out"
		<COND (<IN? ,PROTAGONIST ,CAGE>
		       <PERFORM-PRSA ,CAGE>
		       <RTRUE>)
		      (T
		       <TELL "Argh! Pimples!" CR>)>)
	       (T
	 	<HACK-HACK "Trying to destroy">)>>

<ROUTINE V-NO ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<TELL "\"Too bad.\" ">
		<RIDDLE-DEATH>)
	       (<EQUAL? ,AWAITING-REPLY 2>
		<V-YES>)		
	       (T
		<YOU-SOUND "nega">)>>

<ROUTINE NO-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?NO ,W?NOPE>
		    <EQUAL? .WRD ,W?NAH ,W?UH-UH>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE V-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <FCLEAR ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now off." CR>
		       <NOW-DARK?>)
		      (T
		       <TELL "It isn't on!" CR>)>)
	       (T
		<CANT-TURN "ff">)>>

<ROUTINE V-ON ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Hopefully, your sexy body will do the trick." CR>)
	       (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "Okay," T ,PRSO " is now on." CR>
		       <NOW-LIT?>)>)
	       (T
		<CANT-TURN "n">)>>

<ROUTINE CANT-TURN (STRING)
	 <TELL ,YOU-CANT "turn that o" .STRING ,PERIOD-CR>>

<ROUTINE V-OPEN ()
	 <COND (<OR <FSET? ,PRSO ,SURFACEBIT>
		    <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,VEHBIT>>
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,OPENBIT>
		<TELL ,ALREADY-IS>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,LOCKEDBIT>
		       <TELL "It's locked. Very locked." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT> ;"important for CELL-DOOR desc"
		       <TELL "The " D ,PRSO " swings open." CR>)>)
	       (<FSET? ,PRSO ,CONTBIT>
		<FSET ,PRSO ,OPENBIT>
		<FSET ,PRSO ,TOUCHBIT>
		<COND (<OR <NOT <FIRST? ,PRSO>>
			   <FSET? ,PRSO ,TRANSBIT>>
		       <TELL "Opened." CR>)
		      (T
		       <TELL "Opening" T ,PRSO " reveals">
		       <COND (<NOT <DESCRIBE-NOTHING>>
			      <TELL ,PERIOD-CR>)>
		       <NOW-LIT?>)>)
	       (T
		<CANT-VERB-A-PRSO "open">)>>

<ROUTINE V-PASS () ;"for PASS WATER"
	 <TELL ,YOULL-HAVE-TO "say who you want to pass it to." CR>>

<ROUTINE V-PAY ()
	 <COND (<ULTIMATELY-IN? ,ONE-MARSMID-COIN>
		<PERFORM ,V?GIVE ,ONE-MARSMID-COIN ,PRSO>
		<RTRUE>)
	       (<ULTIMATELY-IN? ,TEN-MARSMID-COIN>
		<PERFORM ,V?GIVE ,TEN-MARSMID-COIN ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have no money!" CR>)>>

<ROUTINE V-PEE ()
	 <COND (<RUNNING? ,I-URGE>
		<COND (<EQUAL? ,HERE ,MENS-ROOM ,LADIES-ROOM>
		       <DEQUEUE I-URGE>
		       <QUEUE I-KIDNAPPING 5>
		       <COND (<IN? ,PROTAGONIST ,STOOL>
			      <MOVE ,PROTAGONIST ,HERE>
			      <SETG OHERE <>>
			      <TELL "[getting off the stool first]" CR>)>
		       <TELL "Ahhh...">
		       <NOTICE-PIZZA-ODOR>)
		      (T
		       <SETG AWAITING-REPLY 3>
		       <QUEUE I-REPLY 2>
		       <TELL "What, on the floor?" CR>)>)
	       (T
		<V-SHIT T>)>>

<ROUTINE V-PEE-IN ()
	 <TELL
"Miss Manners would be shocked." ;"next section punted to save space"
;" True; big deal. Miss Manners would be shocked if you put your shrimp fork
on the wrong side of your butter knife. Let me say instead that Ralph Eugene
O'Grady of Tampa, Florida would be shocked, and he frequently puts his shrimp
fork on the wrong side of his butter knife, and once he even put white wine
in a red wine glass!" CR>>

<ROUTINE V-PHONE ()
	 <COND (<EQUAL? ,HERE ,VIZICOMM-BOOTH>
		<V-CALL>)
	       (T
		<TELL ,YOU-CANT-SEE-ANY "phone here!" CR>)>>

<ROUTINE V-PICK ()
	 <CANT-VERB-A-PRSO "pick">>

<ROUTINE V-PICK-UP ()
	 <PERFORM ,V?TAKE ,PRSO ,PRSI>
	 <RTRUE>>

<ROUTINE V-PIN ()
	 <COND (,PRSI
		<TELL ,HUH>)
	       (<VISIBLE? ,CLOTHES-PIN>
		<PERFORM ,V?PUT-ON ,CLOTHES-PIN ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You have no pin." CR>)>>

<ROUTINE V-POINT ()
	 <TELL "That would be pointless." CR>>

<ROUTINE PRE-POUR ()
	 <COND (<IN-SPACE?>
		<TELL "There's no gravity!" CR>)>>

<ROUTINE V-POUR ()
	 <IMPOSSIBLES>>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing">>

<ROUTINE V-PUSH-DIR ()
	 <COND (<PRSI? ,INTDIR>
		<V-PUSH>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-PUSH-OFF ()
	 <COND (<AND <PRSO? ,ROOMS ,DOCK-OBJECT ,RAFT ,BARGE>
		     <NOT <IN? ,PROTAGONIST ,HERE>>>
		<PERFORM ,V?LAUNCH <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (T
		<TELL ,HUH>)>>

<ROUTINE PRE-PUT ()
	 <COND (<PRSO? ,COCK ,TITS ,CUNT>
		<RFALSE> ;"NAUGHTY-BITS-F handles")
	       (<PRSI? ,GROUND>
		<COND (<NOUN-USED ,W?STAIN ,STAIN>
		       <RFALSE>)
		      (<AND <PRSO? ,CREAM>
			    <NOT <EQUAL? <GET ,P-NAMW 0> ,W?JAR>>>
		       <RFALSE>)>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<PRSO? ,HANDS>
		<COND (<AND <VERB? PUT-ON PUT>
			    <FSET? ,PRSI ,PARTBIT>>
		       <RFALSE>)
		      (<VERB? PUT>
		       <PERFORM ,V?REACH-IN ,PRSI>
		       <RTRUE>)
		      (T
		       <IMPOSSIBLES>)>)
	       (<AND <NOT <FSET? ,PRSI ,PARTBIT>>
		     <PLAYER-CANT-SEE>>		     
		<RTRUE>)
	       (<ULTIMATELY-IN? ,PRSI ,PRSO>
		<COND (<AND <PRSO? ,BABY>
			    <PRSI? ,BLANKET>>
		       <TELL ,ALREADY-IS>)
		      (T
		       <TELL ,YOU-CANT "put" T ,PRSO>
		       <COND (<EQUAL? <GET ,P-ITBL ,P-PREP2> ,PR?ON>
			      <TELL " on">)
			     (T
			      <TELL " in">)>
		       <TELL T ,PRSI " when" T ,PRSI " is already ">
		       <COND (<FSET? ,PRSO ,SURFACEBIT>
			      <TELL "on">)
			     (T
			      <TELL "in">)>
		       <TELL T ,PRSO "!" CR>)>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,SOD>
		     <PRSI? ,HOLE>>
		<RFALSE>)
	       (<UNTOUCHABLE? ,PRSI>
		<CANT-REACH ,PRSI>)
	       (<IDROP>
		<RTRUE>)>>

<ROUTINE V-PUT ()
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL ,YOU-CANT "put" T ,PRSO " in" A ,PRSI "!" CR>)
	       (<OR <PRSI? ,PRSO>
		    <AND <ULTIMATELY-IN? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<TELL "How can you do that?" CR>)
	       (<FSET? ,PRSI ,DOORBIT>
		<TELL ,CANT-FROM-HERE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<THIS-IS-IT ,PRSI>
		<DO-FIRST "open" ,PRSI>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "But" T ,PRSO " is already in" TR ,PRSI>)
	       (<OR <FSET? ,PRSI ,ACTORBIT>
		    <PRSI? ,STALLION ,BABY>>
		<TELL ,HUH>)
	       (<AND <G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
			    <GETP ,PRSI ,P?SIZE>>
		    	 <GETP ,PRSI ,P?CAPACITY>>
		     <NOT <ULTIMATELY-IN? ,PRSO ,PRSI>>>
		<TELL "There's no room ">
		<COND (<FSET? ,PRSI ,SURFACEBIT>
		       <TELL "on">)
		      (T
		       <TELL "in">)>
		<TELL T ,PRSI " for" TR ,PRSO>)
	       (<AND <NOT <ULTIMATELY-IN? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (<AND <OR <PRSO? ,TORCH>
			 <ULTIMATELY-IN? ,TORCH ,PRSO>>
		     <FSET? ,TORCH ,ONBIT>
		     <PRSI? ,BASKET ,SACK>>
		<DO-FIRST "extinguish" ,TORCH>)
	       (<IN? ,PRSI ,ODD-MACHINE>
		<TELL ,ONLY-ONE-THING-IN-COMPARTMENT>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-AGAINST ()
	 <WASTES>>

<ROUTINE V-PUT-BEHIND ()
	 <WASTES>>

<ROUTINE V-PUT-NEAR ()
	 <WASTES>>

<ROUTINE V-PUT-ON ()
	 <COND (<PRSI? ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on" TR ,PRSI>)>>

<ROUTINE V-PUT-THROUGH ()
	 <COND (<FSET? ,PRSI ,DOORBIT>
		<COND (<FSET? ,PRSI ,OPENBIT>
		       <V-THROW>)
		      (T
		       <DO-FIRST "open" ,PRSI>)>)
	       (<AND <PRSI? <LOC ,PROTAGONIST>>
		     <EQUAL? ,P-PRSA-WORD ,W?THROW ,W?TOSS ,W?HURL>>
		<SETG PRSI <>>
		<V-THROW>)
	       (T
	 	<IMPOSSIBLES>)>>

<ROUTINE V-PUT-TO ()
	 <RECOGNIZE>>

<ROUTINE V-PUT-UNDER ()
         <WASTES>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with">>

<ROUTINE PRE-RAKE ()
	 <COND (<NOT <ULTIMATELY-IN? ,RAKE>>
		<TELL ,ONLY-WITH-A-RAKE>)>>

<ROUTINE V-RAKE ()
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,RAKE>)>
	 <COND (<PRSI? ,RAKE>
		<TELL "You'll never make it as a gardener." CR>)
	       (T
		<TELL ,ONLY-WITH-A-RAKE>)>>

<ROUTINE V-RAPE ()
	 <TELL "Unacceptably ungallant behavior." CR>>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <SET OBJ <FIRST? ,PRSO>>
	 <COND (<OR <FSET? ,PRSO ,ACTORBIT>
		    <FSET? ,PRSO ,SURFACEBIT>
		    <NOT <FSET? ,PRSO ,CONTBIT>>>
		<YUKS>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<DO-FIRST "open" ,PRSO>)
	       (<OR <NOT .OBJ>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL ,THERES-NOTHING "in" TR ,PRSO>)
	       (T
		<TELL "You feel something inside" TR ,PRSO>)>>

<ROUTINE V-READ ()
	 <COND (<FSET? ,PRSO ,READBIT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <CANT-VERB-A-PRSO "read">)>>

<ROUTINE V-RELIEVE ()
	 <TELL ,HUH>>

<ROUTINE V-REMOVE ()
	 <COND (<FSET? ,PRSO ,WEARBIT>
		<PERFORM ,V?TAKE-OFF ,PRSO>
		<RTRUE>)
	       (<AND <PRSO? ,HANDS>
		     ,HAND-COVER>
		<PERFORM ,V?UNCOVER ,HAND-COVER>
		<RTRUE>)
	       (<AND <PRSO? ,HANDS>
		     ,RAFT-HELD>
		<PERFORM ,V?DROP ,RAFT>
		<RTRUE>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-RETURN ("AUX" ACTOR)
	 <COND (<NOT ,PRSI>
		<COND (<SET ACTOR <FIND-IN ,HERE ,ACTORBIT "to">>
		       <PERFORM ,V?GIVE ,PRSO .ACTOR>
		       <RTRUE>)
		      (T
		       <NO-ONE-HERE "return it to">)>)
	       (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?PUT ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-RIP ()
	 <COND (<PRSO? ,SCRAP-OF-PAPER ,CODED-MESSAGE ,MATCHBOOK ,MAP>
		<WASTES>)
	       (T
	 	<TELL "Unrippable." CR>)>>

<ROUTINE V-ROLL ()
	 <TELL "A rolling " D ,PRSO " gathers no moss." CR>>

<ROUTINE V-RUB ()
	 <PERFORM ,V?TOUCH ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SAVE-SOMETHING ()
	 <TELL "Sorry, but" T ,PRSO " is beyond help." CR>>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<AND ,AWAITING-REPLY
		     <YES-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-YES>
		<STOP>)
	       (<AND ,AWAITING-REPLY
		     <NO-WORD <GET ,P-LEXV ,P-CONT>>>
		<V-NO>
		<STOP>)
	       (<RUNNING? ,I-SNEEZE>
		<RIDDLE-ANSWER>)
	       (<IN? ,HAREM-GUARD ,HERE>
		<PICK-WIFE>)
	       (<EQUAL? <GET ,P-LEXV ,P-CONT> ,W?KWEEPA>
		<V-KWEEPA>
		<STOP>)
	       (<AND <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?GIDDAP ,W?GIDDYAP>
		     <IN? ,STALLION ,HERE>>
		<V-GIDDYAP>
		<STOP>)
	       (<AND <OR <VISIBLE? ,BEM>
			 <VISIBLE? ,FLYTRAP>>
		     <OR <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?SCAT ,W?BOO>
			 <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?SCRAM ,W?SHOO>>>
		<V-SCAT>
		<STOP>)
	       (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address" T .V " directly." CR>
		<STOP>)
	       (T
		<PERFORM ,V?TELL ,ME>
		<STOP>)>>

<ROUTINE V-SCAT ("AUX" (SCATEE <>))
	 <COND (<VISIBLE? ,FLYTRAP>
		<SET SCATEE ,FLYTRAP>)
	       (<VISIBLE? ,BEM>
		<SET SCATEE ,BEM>)>
	 <COND (.SCATEE
		<TELL "A weak attempt to scare away" AR .SCATEE>)
	       (T
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
	 	<TELL "\"Scat\" to you too!" CR>)>>

<ROUTINE V-SCORE ("AUX" ACTOR) ;"old fashioned V-SCORE is now V-STATUS"
	 <COND (,PRSO
		<PERFORM ,V?FUCK ,PRSO>
		<RTRUE>)
	       (<EQUAL? ,NAUGHTY-LEVEL 0>
		<V-STATUS>)
	       (<SET ACTOR <FIND-IN <LOC ,PROTAGONIST> ,ACTORBIT "with">>
		<PERFORM ,V?FUCK .ACTOR>
		<RTRUE>)
	       (T
		<NO-ONE-HERE "score with">)>>

<ROUTINE V-SEARCH ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<V-SHAKE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<DESCRIBE-VEHICLE>)
	       (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<DO-FIRST "open" ,PRSO>)
	       (<FSET? ,PRSO ,CONTBIT>
		<TELL "You find">
		<COND (<NOT <DESCRIBE-NOTHING>>
		       <TELL ,PERIOD-CR>)>
		<RTRUE>)
	       (T
		<CANT-VERB-A-PRSO "search">)>>

<ROUTINE V-SET ()
	 <COND (<PRSO? ,ROOMS>
		<WEE>)
	       (<AND <PRSO? ,INTDIR>
		     <EQUAL? <LOC ,PROTAGONIST> ,BARGE ,RAFT>>
		<PERFORM-PRSA <LOC ,PROTAGONIST> ,INTNUM>
		<RTRUE>)
	       (<NOT ,PRSI>
		<COND (<FSET? ,PRSO ,TAKEBIT>
		       <HACK-HACK "Turning">)
		      (T
		       <TELL ,YNH TR ,PRSO>)>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "That wouldn't be polite." CR>)
	       (T
		<HACK-HACK "Shaking">)>>

<ROUTINE V-SHAKE-WITH ()
	 <COND (<NOT <PRSO? ,HANDS>>
		<RECOGNIZE>)
	       (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "I don't think" T ,PRSI " even has hands." CR>)
	       (T
		<PERFORM ,V?THANK ,PRSI>
		<RTRUE>)>>

<ROUTINE V-SHIT ("OPTIONAL" (NUMBER-ONE <>))
	 <TELL "You don't have to go ">
	 <COND (.NUMBER-ONE
		<TELL "wee-wee">)
	       (T
		<TELL "poo-poo">)>
	 <TELL " at the moment." CR>>

<ROUTINE V-SHOW ()
	 <TELL "It doesn't look like" T ,PRSI " is interested." CR>>

<ROUTINE V-SHUT-UP ()
	 <COND (<PRSO? ,ROOMS>
		<TELL "[I hope you're not addressing me...]" CR>)
	       (T
		<PERFORM ,V?CLOSE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SIGH ()
	 <TELL "\"Ahhhh...\"" CR>>

<ROUTINE V-SINK ()
	 <IMPOSSIBLES>>

<ROUTINE V-SIT ("AUX" VEHICLE)
	 <COND (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
               (T
		<WASTES>)>>

<ROUTINE V-SKIP ()
	 <COND (<AND <IN-CATACOMBS>
		     <IN? ,PROTAGONIST ,HERE>>
		<QUEUE I-CRABS 10>
		<TELL "Splash." CR>)
	       (T
		<WEE>)>>

<ROUTINE V-SLEEP ()
	 <TELL "You're not tired." CR>>

<ROUTINE PRE-SMELL ()
	 <COND (<AND <FSET? ,NOSE ,MUNGBIT>
		     <NOT ,GONE-APE>>
		<TELL ,YOU-CANT "smell a thing with " 'NOSE " blocked." CR>)>>

<ROUTINE V-SMELL ()
	 <COND (<NOT ,PRSO>
		<PERFORM-PRSA ,ODOR>
		<RTRUE>)
	       (T
		<SENSE-OBJECT "smell">)>>

<ROUTINE SENSE-OBJECT (STRING)
	 <PRONOUN>
	 <TELL " " .STRING>
	 <COND (<AND <NOT <FSET? ,PRSO ,PLURALBIT>>
		     <NOT <PRSO? ,ME>>>
		<TELL "s">)>
	 <TELL " just like" AR ,PRSO>>

<ROUTINE V-SPUT-ON ()
         <PERFORM ,V?PUT-ON ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SRUB ()
	 <PERFORM ,V?RUB ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-STAIN ()
	 <COND (<NOT ,PRSI>
		<COND (<AND <ULTIMATELY-IN? ,STAIN>
			    <NOT <FSET? ,STAIN ,UNTEEDBIT>>>
		       <APPLY-STAIN ,PRSO>)
		      (T
		       <TELL "You have no stain." CR>)>)
	       (<EQUAL? ,PRSI ,STAIN>
		<APPLY-STAIN ,PRSO>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-STAND ()
	 <COND (<EQUAL? ,P-PRSA-WORD ,W?HOLD> ;"for HOLD UP OBJECT"
		<WASTES>)
	       (<AND <EQUAL? ,P-PRSA-WORD ,W?GET>
		     <PRSO? ,ROOMS>
		     <EQUAL? ,HERE ,INNER-HAREM ,BOUDOIR>
		     <EQUAL? ,NAUGHTY-LEVEL 2>
		     ,MALE>
		<TELL "You're already quite hard." CR>)
	       (<AND <FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		     <NOT <EQUAL? <LOC ,PROTAGONIST> ,TREE-HOLE ,CAGE>>>
		<PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (<AND ,PRSO
		     <FSET? ,PRSO ,TAKEBIT>>
		<WASTES>)
	       (<AND <EQUAL? ,HERE ,INNER-HAREM>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<TELL D ,SULTANS-WIFE " tugs you back down." CR>)
	       (T
		<TELL "You're already standing." CR>)>>

<ROUTINE V-STAND-ON ()
	 <COND (<PRSO? ,STOOL>
		<PERFORM ,V?BOARD ,STOOL>
		<RTRUE>)
	       (T
	  	<WASTES>)>>

<ROUTINE V-STELL ()
	 <PERFORM ,V?TELL ,PRSI>
	 <RTRUE>>

<ROUTINE V-STHROW ()
	 <PERFORM ,V?THROW-TO ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SUCK ()
	 <COND (<OR <FSET? ,PRSO ,ACTORBIT>
		    <EQUAL? ,NAUGHTY-LEVEL 0>>
		<PERFORM ,V?EAT ,PRSO>
		<RTRUE>)
	       (T
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Done. Some turn-on, huh?" CR>)>>

<ROUTINE V-SUCKLE ()
	 <IMPOSSIBLES>>

;<ROUTINE V-SWHIP ()
	 <PERFORM ,V?WHIP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SWIM ()
	 <COND (<OR <PRSO? ,WATER>
		    <AND <NOT ,PRSO>
		    	 <GLOBAL-IN? ,WATER ,HERE>>>
		<TELL "This is no time for">)
	       (T
		<TELL "Your head must be">)>
	 <TELL " swimming." CR>>

<ROUTINE V-SWING ()
	 <COND (,PRSI
		<PERFORM ,V?KILL ,PRSI ,PRSO>
		<RTRUE>)
	       (T
		<TELL "\"Whoosh.\"" CR>)>>

<ROUTINE V-SWRAP ()
	 <PERFORM ,V?WRAP ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE PRE-TAKE ()
	 <COND (<AND <PRSO? ,HANDS>
		     ,PRSI
		     <PRSI? ,HAND-COVER>>
		<PERFORM ,V?UNCOVER ,HAND-COVER>
		<RTRUE>)
	       (<OR <AND <PRSO? ,CLOTHES-PIN>
			 <PRSI? ,NOSE>
			 <FSET? ,CLOTHES-PIN ,WORNBIT>>
		    <AND <PRSO? ,COTTON-BALLS>
			 <PRSI? ,EARS>
			 <FSET? ,COTTON-BALLS ,WORNBIT>>
		    <AND <PRSO? ,LIP-BALM>
			 <PRSI? ,MOUTH>
			 <FSET? ,LIP-BALM ,WORNBIT>>>
		<PERFORM ,V?REMOVE ,PRSO>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSO ,PARTBIT>>
		     <PLAYER-CANT-SEE>>
		<RTRUE>)
	       (<LOC-CLOSED>
		<RTRUE>)
	       (<IN? ,PROTAGONIST ,PRSO>
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n it!" CR>)
	       (<OR <IN? ,PRSO ,PROTAGONIST>
		    <AND <ULTIMATELY-IN? ,PRSO>
			 <NOT <FSET? ,PRSO ,TAKEBIT>>>>
		<COND (<AND <PRSO? ,COMIC-BOOK>
			    <PRSI? ,POCKET>>
		       <RFALSE>)
		      (<FSET? ,PRSO ,WORNBIT>
		       <TELL "You're already wearing">)
		      (T
		       <TELL "You already have">)>
		<TELL T ,PRSO ,PERIOD-CR>)
	       (<AND ,HAND-COVER
		     <NOT <PRSO? ,EYES ,EARS, NOSE>>>
		<TELL
,YOU-CANT "pick up anything while using " 'HANDS "s to cover" TR ,HAND-COVER>)
	       (<AND <IN? ,PRSO ,TREE-HOLE>
		     <IN? ,FLYTRAP ,TREE-HOLE>>
		<PERFORM ,V?REACH-IN ,TREE-HOLE>
		<RTRUE>)
	       (<NOT ,PRSI>
		<RFALSE>)
	       (<IN? ,PRSO ,PRSI>
		<RFALSE>)
	       (<PRSO? ,ME>
		<PERFORM ,V?DROP ,PRSI>
		<RTRUE>)
	       (<AND <PRSO? ,SHEET>
		     <PRSI? ,WINDOW>
		     ,SHEET-HANGING>
		<PERFORM ,V?MOVE ,SHEET>
		<RTRUE>)
	       (<AND <PRSO? ,SHEET>
		     <PRSI? ,BED>
		     <NOT <FSET? ,SHEET ,TOUCHBIT>>>
		<RFALSE>)
	       (<AND <PRSO? ,BABY ,BLANKET>
		     <PRSI? ,BABY ,BLANKET>
		     <IN? ,BLANKET ,BABY>>
		<PERFORM ,V?REMOVE ,BABY>
		<RTRUE>)
	       (<AND <PRSO? ,BLANKET>
		     <PRSI? ,BABY>
		     <IN? ,BLANKET ,BABY>>
		<RFALSE>)
	       (<NOT <IN? ,PRSO ,PRSI>>
		<NOT-IN>)
	       (T
		<SETG PRSI <>>
		<RFALSE>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<AND <PRSO? ,COTTON-BALLS> ;"possible as gorilla"
			    <FSET? ,COTTON-BALLS ,WORNBIT>>
		       <FCLEAR ,COTTON-BALLS ,WORNBIT>
		       <FCLEAR ,EARS ,MUNGBIT>)
		      (<AND <PRSO? ,CLOTHES-PIN> ;"possible as gorilla"
			    <FSET? ,CLOTHES-PIN ,WORNBIT>>
		       <FCLEAR ,CLOTHES-PIN ,WORNBIT>
		       <FCLEAR ,NOSE ,MUNGBIT>)>
		<TELL "Taken." CR>)>>

<ROUTINE V-TAKE-A-LEAK ()
	 <COND (<PRSO? ,ROOMS>
		<V-PEE>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-TAKE-A-SHIT ()
	 <COND (<PRSO? ,ROOMS>
		<V-SHIT>)
	       (T
		<RECOGNIZE>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<PRSO? ,ROOMS>
		<COND (<EQUAL? ,P-PRSA-WORD ,W?GET>
		       <COND (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
			      <TELL "[of" T <LOC ,PROTAGONIST> "]" CR>
			      <PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
			      <RTRUE>)
			     (<EQUAL? ,NAUGHTY-LEVEL 0>
			      <V-STAND>)
			     (T
			      <PERFORM ,V?FUCK ,ME>
			      <RTRUE>)>)
		      (T
		       <PERFORM-PRSA ,GARMENT>
		       <RTRUE>)>)
	       (<FSET? ,PRSO ,WORNBIT>
		<FCLEAR ,PRSO ,WORNBIT>
		<TELL "Okay, you're no longer wearing" TR ,PRSO>)
	       (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You aren't wearing" TR ,PRSO>)>>

<ROUTINE V-TAKE-WITH ()
	 <TELL "Sorry," T ,PRSI " is no help in getting" TR ,PRSO>>

<ROUTINE V-TASTE ()
	 <SENSE-OBJECT "taste">>

<ROUTINE V-TELL ()
	 <COND (<AND <PRSO? ,STALLION>
		     ,P-CONT>
		<SETG CLOCK-WAIT T>
		<SETG WINNER ,STALLION>
		<RTRUE>)
	       (<OR <FSET? ,PRSO ,ACTORBIT>
		    <AND <PRSO? ,INTNUM>
		     	 <IN? ,SULTANS-WIFE ,HERE>>>
		<COND (<AND <PRSO? ,INTNUM>
			    <NOT <EQUAL? ,P-NUMBER ,CHOICE-NUMBER>>>
		       <TELL "\"That's not my number!\"" CR>
		       <STOP>)
		      (,P-CONT
		       <COND (<PRSO? ,INTNUM>
			      <SETG WINNER ,SULTANS-WIFE>)
			     (T
		       	      <SETG WINNER ,PRSO>)>
		       <SETG CLOCK-WAIT T>
		       <RTRUE>)
		      (T
		       <TELL
"Hmmm ..." T ,PRSO " looks at you expectantly,
as if you seemed to be about to talk." CR>)>)
	       (<AND <PRSO? ,FLYTRAP ,BEM>
		     <OR <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?SCAT ,W?BOO>
			 <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?SCRAM ,W?SHOO>>>
		<V-SCAT>
		<STOP>)
	       (T
		<CANT-VERB-A-PRSO "talk to">
		<STOP>)>>

<ROUTINE V-TELL-ABOUT ()
	 <COND (<PRSO? ,ME>
		<PERFORM ,V?WHAT ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?SHOW ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-THANK ()
	 <COND (<NOT ,PRSO>
		<TELL "[Just doing my job.]" CR>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "\"You're welcome.\"" CR>)
	       (T
		<IMPOSSIBLES>)>>

<ROUTINE V-THROW ()
	 <COND (<NOT <SPECIAL-DROP>>
	 	<COND (<EQUAL? ,HERE ,CANAL>
		       <PERFORM ,V?PUT ,PRSO ,CANAL-OBJECT>
		       <RTRUE>)
		      (,PRSI
		       <MOVE ,PRSO ,HERE>
		       <TELL "You missed." CR>)
		      (T
		       <MOVE ,PRSO ,HERE>
		       <TELL "Thrown." CR>)>)>>

;<ROUTINE V-THROW-OVERBOARD ()
	 <COND (<AND <EQUAL? <LOC ,PROTAGONIST> ,BARGE ,RAFT>
		     <GLOBAL-IN? ,CANAL-OBJECT ,HERE>>
		<PERFORM ,V?PUT ,PRSO ,CANAL-OBJECT>
		<RTRUE>)
	       (T
		<TELL "One normally tries this on a boat." CR>)>>

<ROUTINE V-THROW-TO ()
	 <COND (<FSET? ,PRSI ,ACTORBIT>
		<PERFORM ,V?GIVE ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM ,V?THROW ,PRSO ,PRSI>
		<RTRUE>)>>

<ROUTINE V-THROW-UP ()
	 <COND (<PRSO? ,ROOMS>
		<V-VOMIT>)
	       (T
		<PERFORM ,V?THROW ,PRSO>
		<RTRUE>)>>

<ROUTINE V-TIE ()
	 <COND (<AND <OR <FSET? ,PRSO ,ACTORBIT>
			 <FSET? ,PRSI ,ACTORBIT>>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<TELL "Kinky!" CR>
		<RTRUE>)
	       (<EQUAL? ,P-PRSA-WORD ,W?TIE>
		<TELL
"You've tied" T ,PRSO "! In the third quarter, with forty seconds on the
clock, the score is " D ,PRSO " 17, player 17!!! But seriously, folks, y">)
	       (T ;"if you used STRAP instead of TIE"
		<TELL "Y">)>
	 <TELL "ou can't tie" TR ,PRSO>>

<ROUTINE V-TIE-TOGETHER ()
	 <IMPOSSIBLES>>

<ROUTINE PRE-TOUCH ()
	 <COND (<UNTOUCHABLE? ,PRSO>
		<CANT-REACH ,PRSO>)>>

<ROUTINE V-TOUCH ()
	 <COND (<LOC-CLOSED>
		<RTRUE>)
	       (<EQUAL? ,NAUGHTY-LEVEL 0>
		<HACK-HACK "Touching">)
	       (T
		<HACK-HACK "Fondling">)>>

<ROUTINE V-UNCOVER ()
	 <COND (<PRSO? ,HAND-COVER>
		<SENSE-AGAIN ,HAND-COVER>
		<SETG HAND-COVER <>>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?UNDRESS ,OBJECT>
		<RTRUE>)
	       (T
		<COND (<FSET? ,PRSO ,PLURALBIT>
		       <TELL "They're">)
		      (<FSET? ,PRSO ,FEMALEBIT>
		       <TELL "She's">)
		      (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "He's">)
		      (T
		       <TELL "It's">)>
		<TELL " not covered!" CR>)>>

<ROUTINE SENSE-AGAIN (BODY-PART) 
	 <FCLEAR .BODY-PART ,MUNGBIT>
	 <TELL "You can once again sense with" TR .BODY-PART>>

<ROUTINE V-UNDRESS ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <PERFORM ,V?FUCK ,PRSO>
		       <RTRUE>)
		      (T
		       <IMPOSSIBLES>)>)
	       (T
		<SETG PRSO ,ROOMS>
		<V-GET-UNDRESSED>)>>

<ROUTINE V-UNLOCK ()
	 <COND (,PRSI
		<IMPOSSIBLES>)
	       (<FSET? ,PRSO ,LOCKEDBIT>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Your nose is key-shaped, I suppose?" CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "But" T ,PRSO " isn't locked." CR>)
	       (T
		<YUKS>)>>

<ROUTINE V-UNROLL ()
	 <IMPOSSIBLES>>

<ROUTINE V-UNTIE ()
	 <IMPOSSIBLES>>

<ROUTINE V-USE ()
	 <TELL
,YOULL-HAVE-TO "be more specific about how you want to use" TR ,PRSO>>

<ROUTINE V-USE-QUOTES ()
	 <COND (<IN? ,HAREM-GUARD ,HERE>
		<PICK-WIFE ,PRSO>)
	       (T
	 	<SEE-MANUAL "say something \"out loud.\"">)>>

<ROUTINE V-VOMIT ()
	 <COND (<AND <IN? ,PIZZA ,HERE>
		     <FSET? ,PIZZA ,TOUCHBIT>>
		<TELL "Just keep trying to eat that " D ,PIZZA ,PERIOD-CR>)
	       (T
		<TELL
"You stick a finger down your throat, but to no avail." CR>)>>

<ROUTINE V-WALK ("AUX" AV VEHICLE PT PTS STR OBJ RM)
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<AND <PRSO? ,P?OUT>
		     <IN-EXITABLE-VEHICLE?>>
		<RTRUE>)
	       (<AND <PRSO? ,P?DOWN>
		     <EQUAL? .AV ,STOOL ,STALLION>>
		<PERFORM ,V?DISEMBARK .AV>
		<RTRUE>)
	       (<AND <PRSO? ,P?IN>
		     <EQUAL? ,HERE ,LABORATORY>>
		<PERFORM ,V?BOARD ,CAGE>
		<RTRUE>)
	       (<AND <PRSO? ,P?IN>
		     <NOT <GETPT ,HERE ,P?IN>>
		     <SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		     <NOT <ULTIMATELY-IN? .VEHICLE>>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (<AND ,RAFT-HELD
		     <NOT <IN? ,PROTAGONIST ,RAFT>>>
		<TELL
"If you want to walk away, you'll either have to take the raft
or let go of it!" CR>
		<RFATAL>)
	       (<AND <FSET? .AV ,VEHBIT>
		     <NOT <EQUAL? .AV ,STALLION>>>
		<COND (<AND <EQUAL? ,HERE ,CELL>
			    <EQUAL? .AV ,STOOL>
			    ,HOLE-OPEN
			    <EQUAL? ,PRSO ,P?UP>>
		       <HOLE-ENTER-F>
		       <RTRUE>)
		      (T
		       <NOT-GOING-ANYWHERE>)>)
	       (<OR <FSET? ,EYES ,MUNGBIT>
		    <EQUAL? ,HAND-COVER ,EYES>>
		<OPEN-YOUR-EYES!>
		<RFATAL>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GET .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <COND (<EQUAL? .RM ,ROOMS> ;"catacombs fake-move"
				     <RTRUE>)>
			      <GOTO .RM>)
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GET .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL ,CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GET .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GET .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <THIS-IS-IT .OBJ>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <THIS-IS-IT .OBJ>
			      <DO-FIRST "open" .OBJ>
			      <RFATAL>)>)>)
	       (T
		<COND (<PRSO? ,P?OUT ,P?IN>
		       <V-WALK-AROUND>)
		      (<OR <EQUAL? ,HERE ,WELL-BOTTOM ,FORGOTTEN-STOREHOUSE>
			   <EQUAL? ,HERE ,BURIAL-CHAMBER ,LADDER-ROOM>>
		       <TELL
"You wade into the dark, but find no passage in that direction." CR>)
		      (T
		       <TELL ,CANT-GO>)>
		<RFATAL>)>>

<ROUTINE NOT-GOING-ANYWHERE ("AUX" AV)
	 <SET AV <LOC ,PROTAGONIST>>
	 <TELL "You're not going anywhere until you get ">
	 <COND (<OFF-VEHICLE? .AV>
		<TELL "off">)
	       (T
		<TELL "out of">)>
	 <TELL TR .AV>
	 <RFATAL>>

<ROUTINE V-WALK-AROUND ()
	 <SETG AWAITING-REPLY 2>
	 <QUEUE I-REPLY 2>
	 <TELL "Did you have any particular direction in mind?" CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<EQUAL? ,PRSO ,INTDIR>
		<DO-WALK ,P-DIRECTION>)
	       (T
		<V-WALK-AROUND>)>>

;<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
	        <COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "He's">)
		      (T
		       <TELL "It's">)>
		<TELL " here!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<VISIBLE? ,PRSO>
		<V-FOLLOW>)
	       (T
	 	<TELL "You may be waiting quite a while." CR>)>>

<ROUTINE V-WEAR ()
         <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<CANT-VERB-A-PRSO "wear">)
	       (T
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,WORNBIT>
		       <TELL "already">)
		      (T
		       <MOVE ,PRSO ,PROTAGONIST>
		       <FSET ,PRSO ,WORNBIT>
		       <TELL "now">)>
		<TELL " wearing" TR ,PRSO>)>>

<ROUTINE V-WHAT ()
	 <TELL "Good question." CR>>

<ROUTINE V-WHERE ()
	 <V-FIND T>>

<ROUTINE V-WHIP ()
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<V-KILL>)
	       (T
	 	<TELL "Oooo! S & M! Love it!!!" CR>)>>

<ROUTINE V-WRAP ()
	 <WASTES>>

<ROUTINE V-YELL ()
	 <SORE "throat">
	 <STOP>>

<ROUTINE I-REPLY ()
	 <SETG AWAITING-REPLY <>>
	 <RFALSE>>

<GLOBAL AWAITING-REPLY <>>

<ROUTINE V-YES ()
	 <COND (<EQUAL? ,AWAITING-REPLY 1>
		<SETG AWAITING-REPLY <>>
		<SETG AWAITING-FAKE-ORPHAN T>
		<SETG SULTAN-COUNTER 0>
		<QUEUE I-SNEEZE 2>
		<DEQUEUE I-SULTAN>
		<TELL
"\"Here, then, is the riddle. Don't strain " 'HEAD "; no one's ever
gotten it right.\" You hear a growling snarl from somewhere nearby.|
   \"Some say I'm pointless,|
       yet many are obsessed by me.|
    I have caused heroic gambles|
       and sown endless frustration.|
    Uncounted deaths have I caused.|
       What am I?\"" CR>
		<COND (<IN? ,SIDEKICK ,HERE>
		       <TELL
"   " D ,SIDEKICK " steps briskly forward. \"That's easy!\" ">
		       <HE-SHE>
		       <TELL
" yells. \"A grapefruit!\" As the eunuchs snicker behind their weapons, the "
D ,SULTAN " cries \"Wrongo!\" and ">
		       <TIGER-EATS-SIDEKICK>
		       <TELL
"   \"Your turn to guess,\" says the " D ,SULTAN ", looking gleeful." CR>)>
		<RTRUE>)
	       (<EQUAL? ,AWAITING-REPLY 2>
		<TELL "That was just a rhetorical question." CR>)
	       (<EQUAL? ,AWAITING-REPLY 3>
		<V-PEE-IN>) 
	       (T
	 	<YOU-SOUND "posi">)>>

<ROUTINE YOU-SOUND (STRING)
	 <TELL "You sound rather " .STRING "tive." CR>>

<ROUTINE YES-WORD (WRD)
	 <COND (<OR <EQUAL? .WRD ,W?YES ,W?Y ,W?YUP>
		    <EQUAL? .WRD ,W?OK ,W?OKAY ,W?SURE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

;"subtitle object manipulation"

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" ;CNT OBJ)
	 <COND (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <YUKS>)>
		<RFATAL>)
	       (<PRE-TOUCH>
		<RFATAL>)
	       ;(<AND <NOT <ULTIMATELY-IN? ,PRSO>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,PROTAGONIST>> 100>>
		<COND (.VB
		       <TELL
"It's too heavy, considering your current load." CR>)>
		<RFATAL>)
	       (<G? <CCOUNT ,PROTAGONIST> 10>
		<COND (.VB
		       <TELL
"You're already juggling as many items as you could possibly carry." CR>)>
		<RFATAL>)>
	 <FSET ,PRSO ,TOUCHBIT>
	 <FCLEAR ,PRSO ,NDESCBIT>
	 <COND (<IN? ,PROTAGONIST ,PRSO>
		<RFALSE> ;"Hope this is right -- pdl 4/22/86")
	       (<AND <PRSO? ,RAFT>
		     ,RAFT-HELD>
		<SETG RAFT-HELD <>>)>
	 <MOVE ,PRSO ,PROTAGONIST>>

;"IDROP is called by PRE-GIVE and PRE-PUT.
  IDROP acts directly as PRE-DROP, PRE-THROW and PRE-PUT-THROUGH."
<ROUTINE IDROP ()
	 <COND (<PRSO? ,COCK ,CUNT ,TITS>
		<RFALSE>)
	       (<PRSO? ,HANDS>
		<COND (<VERB? DROP THROW GIVE>
		       <IMPOSSIBLES>)
		      (T
		       <RFALSE>)>)
	       (<AND <PRSO? ,POWER-SWITCH>
		     <VERB? THROW>>
		<RFALSE>)
	       (<AND <PRSO? ,HEAD>
		     <VERB? PUT>
		     <PRSI? ,HOLE>>
		<TELL "Hey wow! Vertigo city!" CR>)
	       (<AND <PRSO? ,ME>
		     <VERB? PUT>
		     <FSET? ,PRSI ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSI>
		<RTRUE>)
	       (<AND <PRSI? ,ME>
		     <VERB? PUT>
		     <FSET? ,PRSO ,ACTORBIT>>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-THROUGH>
		     <PRSO? ,SHEET>
		     <PRSI? ,WINDOW>>
		<RFALSE>)
	       (<PRSO? ,HAND-COVER> ;"for LET GO OF NOSE"
		<PERFORM ,V?UNCOVER ,PRSO>
		<RTRUE>)
	       (<AND <PRSO? ,NOSE>
		     <PRSI? ,CLOTHES-PIN>> ;"for PUT NOSE IN PIN"
		<RFALSE>)
	       (<PRSO? ,COMIC-BOOK>
		<COND (<PRSI? ,POCKET>
		       <TELL ,ALREADY-IS>)
		      (T
		       <PERFORM ,V?REMOVE ,COMIC-BOOK>
		       <RTRUE>)>)
	       (<AND <NOT <ULTIMATELY-IN? ,PRSO>>
		     <NOT <PRSO? ,LEAVES>>
		     <NOT <AND <PRSO? ,RAFT>
			       ,RAFT-HELD>>>
		<COND (<OR <PRSO? ,ME>
			   <FSET? ,PRSO ,PARTBIT>>
		       <IMPOSSIBLES>)
		      (<AND <PRSO? ,SOD>
			    <PRSI? ,HOLE>>
		       <RFALSE>)
		      (T
		       <TELL
"That's easy for you to say since you don't even have" TR ,PRSO>)>
		<RFATAL>)
	       (<AND <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<DO-FIRST "open" <LOC ,PRSO>>)
	       (<FSET? ,PRSO ,WORNBIT>
		<COND (<AND <VERB? PUT PUT-ON>
			    <OR <AND <PRSO? ,CLOTHES-PIN>
			    	     <PRSI? ,NOSE>>
		       		<AND <PRSO? ,COTTON-BALLS>
				     <PRSI? ,EARS>>
				<AND <PRSO? ,LIP-BALM>
			    	     <PRSI? ,MOUTH>>>>
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <DO-FIRST "remove" ,PRSO>)>)
	       (T
		<RFALSE>)>>

<ROUTINE CCOUNT	(OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WORNBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"Gets SIZE of supplied object, recursing to nth level."
<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<SET WT <+ .WT <WEIGHT .CONT>>>
			<COND (<NOT <SET CONT <NEXT? .CONT>>>
			       <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

;"subtitle describers"

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (VERB-IS-LOOK <>)
			"AUX" (FIRST-VISIT <>) (NUM 0))
	 <COND (<NOT ,LIT>
		<TELL ,TOO-DARK>
		<COND (<AND <EQUAL? ,HERE ,CLOSET>
			    <NOT <FSET? ,NOSE ,MUNGBIT>>>
		       <TELL " There's a distinctive odor here, though.">)>
		<CRLF>
		<RFALSE> ;"so DESCRIBE-CONTENTS of room isn't called")>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<COND (<NOT <EQUAL? ,HERE ,CANAL ,CATACOMBS ,LONG-CORRIDOR>>
		       <FSET ,HERE ,TOUCHBIT>)>
		<SET FIRST-VISIT T>)>
	 <TELL D ,HERE>
	 <SET NUM <CANAL-LOC>>
	 <COND (<EQUAL? .NUM 10>
		<TELL ", near the ">
		<COND (<EQUAL? ,NEARER-DOCK ,MY-KIND-OF-DOCK>
		       <TELL "ea">)
		      (T
		       <TELL "we">)>
		<TELL "st bank">)>
	 <COND (<AND <FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		     <NOT ,DONT-PRINT-VEHICLE>>
		<TELL ", ">
		<COND (<FSET? <LOC ,PROTAGONIST> ,INBIT>
		       <TELL "i">)
		      (T
		       <TELL "o">)>
		<TELL "n" T <LOC ,PROTAGONIST>>)>
	 <CRLF>
	 <COND (<OR .VERB-IS-LOOK
		    <EQUAL? ,VERBOSITY 2>
		    <AND .FIRST-VISIT
			 <EQUAL? ,VERBOSITY 1>>>
		<TELL "   ">
		<COND (<NOT <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <TELL <GETP ,HERE ,P?LDESC>>)>
		<CRLF>)>
	 <RTRUE>>

;"Print FDESCs, then DESCFCNs and LDESCs, then everything else. DESCFCNs
must handle M-OBJDESC? by RTRUEing (but not printing) if the DESCFCN would
like to handle printing the object's description. RFALSE otherwise. DESCFCNs
are responsible for doing the beginning-of-paragraph indentation."

<ROUTINE DESCRIBE-OBJECTS ("AUX" O STR (1ST? T) (AV <LOC ,WINNER>))
	 <SET O <FIRST? ,HERE>>
	 <COND (<NOT .O>
		<RFALSE>)>
	 <REPEAT () ;"FDESCS and MISC."
		 <COND (<NOT .O>
			<RETURN>)
		       (<AND <DESCRIBABLE? .O>
			     <NOT <FSET? .O ,TOUCHBIT>>
			     <SET STR <GETP .O ,P?FDESC>>>
			<TELL "   " .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <SET O <FIRST? ,HERE>>
	 <SET 1ST? T>
	 <REPEAT () ;"DESCFCNS"
		 <COND (<NOT .O>
			<RETURN>)
		       (<OR <NOT <DESCRIBABLE? .O>>
			    <AND <GETP .O ,P?FDESC>
				 <NOT <FSET? .O ,TOUCHBIT>>>>
			T)
		       (<AND <SET STR <GETP .O ,P?DESCFCN>>
			     <SET STR <APPLY .STR ,M-OBJDESC>>>
			<COND (<AND <FSET? .O ,CONTBIT>
				    <N==? .STR ,M-FATAL>>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)
		       (<SET STR <GETP .O ,P?LDESC>>
			<TELL "   " .STR>
			<COND (<FSET? .O ,CONTBIT>
			       <DESCRIBE-CONTENTS .O T <+ ,D-ALL? ,D-PARA?>>)>
			<CRLF>)>
		 <SET O <NEXT? .O>>>
	 <DESCRIBE-CONTENTS ,HERE <> 0>
	 <COND (<AND .AV <NOT <EQUAL? ,HERE .AV>>>
		<DESCRIBE-CONTENTS .AV <> 0>)>>

<CONSTANT D-ALL? 1> ;"print everything?"
<CONSTANT D-PARA? 2> ;"started paragraph?"

"<DESCRIBE-CONTENTS ,OBJECT-WHOSE-CONTENTS-YOU-WANT-DESCRIBED
		    level: -1 means only top level
			    0 means top-level (include crlf)
			    1 for all other levels
			    or string to print
		    all?: t if not being called from room-desc >"

<ROUTINE DESCRIBE-CONTENTS (OBJ "OPTIONAL" (LEVEL -1) (ALL? ,D-ALL?)
			    "AUX" (F <>) N (1ST? T) (IT? <>)
			    (START? <>) (TWO? <>) (PARA? <>))
  <COND (<EQUAL? .LEVEL 2>
	 <SET LEVEL T>
	 <SET PARA? T>
	 <SET START? T>)
	(<BTST .ALL? ,D-PARA?>
	 <SET PARA? T>)>
  <SET N <FIRST? .OBJ>>
  <COND (<OR .START?
	     <IN? .OBJ ,ROOMS>
	     <FSET? .OBJ ,ACTORBIT>
	     <AND <FSET? .OBJ ,CONTBIT>
		  <OR <FSET? .OBJ ,OPENBIT>
		      <FSET? .OBJ ,TRANSBIT>>
		  <FSET? .OBJ ,SEARCHBIT>
		  .N>>
	 <REPEAT ()
	  <COND (<OR <NOT .N>
		     <AND <DESCRIBABLE? .N>
			  <OR <BTST .ALL? ,D-ALL?>
			      <SIMPLE-DESC? .N>>>>
		 <COND
		  (.F
		   <COND
		    (.1ST?
		     <SET 1ST? <>>
		     <COND (<EQUAL? .LEVEL <> T>
			    <COND (<NOT .START?>
				   <COND (<NOT .PARA?>
					  <COND (<NOT <EQUAL? .OBJ
							      ,PROTAGONIST>>
						 <TELL "   ">)>
					  <SET PARA? T>)
					 (<EQUAL? .LEVEL T>
					  <TELL " ">)>
				   <COND (<EQUAL? .OBJ ,HERE>
					  <TELL ,YOU-SEE>)
					 (<EQUAL? .OBJ ,PROTAGONIST>
					  <TELL "You have">)
					 (<FSET? .OBJ ,SURFACEBIT>
					  <TELL "Sitting on" T .OBJ " is">)
					 (T
					  <TELL ,IT-SEEMS-THAT T .OBJ>
					  <COND (<FSET? .OBJ ,ACTORBIT>
						 <TELL " has">)
						(T
						 <TELL " contains">)>)>)>)
			   (<NOT <EQUAL? .LEVEL -1>>
			    <TELL .LEVEL>)>)
		    (T
		     <COND (.N
			    <TELL ",">)
			   (T
			    <TELL " and">)>)>
		   <TELL A .F>
		   <COND (<FSET? .F ,WORNBIT>
			  <COND (<EQUAL? .F ,LIP-BALM>
				 <TELL " (smeared all over your lips)">)
				(<EQUAL? .F ,COTTON-BALLS>
				 <TELL " (stuffed in " 'EARS ")">)
				(<EQUAL? .F ,CLOTHES-PIN>
				 <TELL " (pinned to " 'NOSE ")">)
				(T
				 <TELL " (being worn)">)>)
			 (<FSET? .F ,ONBIT>
			  <TELL " (providing light)">)
			 (<EQUAL? .F ,COMIC-BOOK>
			  <TELL " (stuck in your back pocket)">)>
		   <COND (<AND <NOT .IT?> <NOT .TWO?>>
			  <SET IT? .F>)
			 (T
			  <SET TWO? T>
			  <SET IT? <>>)>)>
		 <SET F .N>)>
	  <COND (.N
		 <SET N <NEXT? .N>>)>
	  <COND (<AND <NOT .F>
		      <NOT .N>>
		 <COND (<AND .IT?
			     <NOT .TWO?>>
			<THIS-IS-IT .IT?>)>
		 <COND (<AND .1ST? .START?>
			;<SET 1ST? <>>
			<TELL " nothing">
			<RFALSE>)>
		 <COND (<AND <NOT .1ST?>
			     <EQUAL? .LEVEL <> T>>
			<COND (<EQUAL? .OBJ ,HERE>
			       <TELL " here">)>
			<TELL ".">)>
		 <RETURN>)>>
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F>
			<RETURN>)
		       (<AND <FSET? .F ,CONTBIT>
			     <DESCRIBABLE? .F T>
			     <OR <BTST .ALL? ,D-ALL?>
				 <SIMPLE-DESC? .F>>>
			<COND (<DESCRIBE-CONTENTS .F T
						  <COND (.PARA?
							 <+ ,D-ALL? ,D-PARA?>)
							(T
							 ,D-ALL?)>>
			       <SET 1ST? <>>
			       <SET PARA? T>)>)>
		 <SET F <NEXT? .F>>>
	 <COND (<AND <NOT .1ST?>
		     <EQUAL? .LEVEL <> T>
		     <EQUAL? .OBJ ,HERE <LOC ,WINNER>>>
		<CRLF>)>
	 <NOT .1ST?>)>>

<ROUTINE DESCRIBABLE? (OBJ "OPT" (CONT? <>))
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,WINNER>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ <LOC ,WINNER>>
		     <NOT <EQUAL? ,HERE <LOC ,WINNER>>>>
		<RFALSE>)
	       (<AND <NOT .CONT?>
		     <FSET? .OBJ ,NDESCBIT>>
		<RFALSE>)	       
	       (<AND <EQUAL? .OBJ ,RAFT ,BARGE>
		     <EQUAL? ,HERE ,CANAL>
		     <NOT <ULTIMATELY-IN? .OBJ>>
		     <NOT <IN? .OBJ ,BARGE>>
	             <NOT <EQUAL? ,RAFT-LOC-NUM ,BARGE-LOC-NUM>>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE SIMPLE-DESC? (OBJ "AUX" STR)
	 <COND (<AND <GETP .OBJ ,P?FDESC>
		     <NOT <FSET? .OBJ ,TOUCHBIT>>>
		<RFALSE>)
	       (<AND <SET STR <GETP .OBJ ,P?DESCFCN>>
		     <APPLY .STR ,M-OBJDESC?>>
		<RFALSE>)
	       (<GETP .OBJ ,P?LDESC>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE DESCRIBE-VEHICLE () ;"for LOOK AT/IN vehicle when you're in it"
	 <COND (<PRSO? ,DIVAN>
		<NOT-ALONE-ON-DIVAN>
		<CRLF>)
	       (T
	 	<TELL "Other than yourself, you can see"> 
	 	<COND (<NOT <DESCRIBE-NOTHING>>
		       <COND (<FSET? ,PRSO ,INBIT>
			      <TELL " in">)
			     (T
			      <TELL " on">)>
		       <TELL TR ,PRSO>)>
		<RTRUE>)>>

<ROUTINE DESCRIBE-NOTHING ()
	 <COND (<DESCRIBE-CONTENTS ,PRSO 2>
	 	<COND (<NOT <IN? ,PROTAGONIST ,PRSO>>
		       <CRLF>)>
		<RTRUE>)
	       (T ;"nothing"
		<RFALSE>)>>

;"subtitle movement and death"

;<CONSTANT REXIT 0>
;<CONSTANT UEXIT 1>
;<CONSTANT NEXIT 2>
;<CONSTANT FEXIT 3>
;<CONSTANT CEXIT 4>
;<CONSTANT DEXIT 5>

;<CONSTANT NEXITSTR 0>
;<CONSTANT FEXITFCN 0>
;<CONSTANT CEXITFLAG 1>
;<CONSTANT CEXITSTR 1>
;<CONSTANT DEXITOBJ 1>
;<CONSTANT DEXITSTR 1>

<ROUTINE GOTO (NEW-LOC "OPTIONAL" (DONT-DESCRIBE-SIDEKICK <>) "AUX" OLD-HERE)
	 <COND (<AND <EQUAL? ,HERE ,THRONE-ROOM>
		     <NOT <FSET? ,THETA ,MUNGBIT>>>
		<FSET ,THETA ,MUNGBIT>
		<FSET ,THETA ,NDESCBIT>
		<FCLEAR ,THETA ,ACTORBIT>
		<FCLEAR ,THETA ,FEMALEBIT>
		<FCLEAR ,THETA ,NARTICLEBIT>
		<PUTP ,THETA ,P?SDESC "different-looking angle">
		<TELL
"As you leave, you hear behind you a sound like a" ,45-DEGREE-ANGLE " landing
on a pile of" ,45-DEGREE-ANGLE "s.">
		<EXPLETIVE>
		<TELL "Not again!\" you hear Mitre moan." CR CR>)>
	 <SET OLD-HERE ,HERE>
	 <OPEN-EYES-AND-REMOVE-HANDS>
	 <MOVE ,PROTAGONIST .NEW-LOC>
	 <SETG OHERE <>>
	 <COND (<IN? .NEW-LOC ,ROOMS>
		<SETG HERE .NEW-LOC>)
	       (T
		<SETG HERE <LOC .NEW-LOC>>)>
	 <SETG LIT <LIT? ,HERE>>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<AND <DESCRIBE-ROOM>
		     <NOT <EQUAL? ,VERBOSITY 0>>>
		<DESCRIBE-OBJECTS>)>
	 <COND (<AND <IN? ,SIDEKICK .OLD-HERE>
		     <IN? ,PROTAGONIST ,HERE> ;"don't, if you're in a vehicle"
		     <NOT .DONT-DESCRIBE-SIDEKICK>>
		<SIDEKICK-FOLLOWS-YOU>)>
	 <SETG HOLE-MOVE <>>
	 <RTRUE>>

<ROUTINE SIDEKICK-FOLLOWS-YOU ()
	 <COND (<EQUAL? ,HERE ,BOUDOIR>
		<MOVE ,SIDEKICK ,HERE>)
	       (T
		<MOVE ,SIDEKICK <LOC ,PROTAGONIST>>)>
	 <COND (,HOLE-MOVE
		<TELL "   A few seconds later, you ">
		<COND (<LIT? ,HERE>
		       <TELL "see ">)
		      (T
		       <TELL "feel ">)>
		<TELL
D ,SIDEKICK "'s " <PICK-ONE ,SIDEKICK-PARTS> " appear,
followed almost immediately by the rest of ">
		<HIM-HER>
		<TELL ,PERIOD-CR>)
	       (T
		<NORMAL-SIDEKICK-FOLLOW>)>>

<ROUTINE NORMAL-SIDEKICK-FOLLOW ()
	 <TELL "   " D ,SIDEKICK <PICK-ONE ,FOLLOWS> CR>>

<GLOBAL SIDEKICK-PARTS
	<LTABLE
	 0
	 "earlobe"
	 "nose"
	 "big toe"
	 "elbow"
	 "left buttock">>

<GLOBAL FOLLOWS
	<LTABLE
	 0
	 " trails along."
	 " follows you."
	 " enters just a few steps behind you."
	 " loyally stays at your side.">>

<ROUTINE JIGS-UP (DESC)
	 <TELL .DESC>
	 <TELL CR CR
"      ****  You have died  ****" CR>
	 <FINISH>>

;"subtitle useful utility routines"

<ROUTINE ACCESSIBLE? (OBJ "AUX" L) ;"revised 2/18/86 by SEM"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       ;(<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" L) ;"revised 5/2/84 by SEM and SWG"
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <SET L <LOC .OBJ>>
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE UNTOUCHABLE? (OBJ)
;"figures out whether, due to vehicle-related locations, object is touchable"
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       ;"next four clauses are special cases for LGOP"
	       (<OR <ULTIMATELY-IN? .OBJ ,SHELF>
		    <EQUAL? .OBJ ,SHELF>>
		<COND (<IN? ,PROTAGONIST ,STOOL>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<AND <ULTIMATELY-IN? .OBJ ,TREE-HOLE>
		     <NOT <IN? ,PROTAGONIST ,TREE-HOLE>>>
		<RTRUE>)
	       (<AND <ULTIMATELY-IN? .OBJ ,CAGE>
		     <NOT <IN? ,PROTAGONIST ,CAGE>>>
		<RTRUE>)
	       (<AND <IN? ,PROTAGONIST ,FIRST-SLAB>
		     <OR <NOUN-USED ,W?STRAP .OBJ>
			 <NOUN-USED ,W?STRAPS .OBJ>>>
		<RFALSE>)
	       (<IN? ,PROTAGONIST ,HERE>
		<RFALSE>)
	       (<OR <ULTIMATELY-IN? .OBJ <LOC ,PROTAGONIST>>
		    <EQUAL? .OBJ <LOC ,PROTAGONIST>>
		    <IN? .OBJ ,GLOBAL-OBJECTS> ;"me, hands, etc.">
		<RFALSE>)
	       ;"next four clauses are a special case for LGOP"
	       (<AND <EQUAL? .OBJ ,RAFT>
		     ,RAFT-HELD>
		<RFALSE>)
	       (<AND <EQUAL? .OBJ ,CANAL-OBJECT ,WATER ,BARGE>
		     <EQUAL? <LOC ,PROTAGONIST> ,BARGE ,RAFT>>
		<RFALSE>)
	       (<AND <PRSO? ,SHEET>
		     ,SHEET-TIED> ;"if it's tied you can reach it from bed"
		<RFALSE>)
	       (<AND <PRSO? ,SHEET>
		     <IN? ,PROTAGONIST ,BED>
		     <NOT <FSET? ,SHEET ,TOUCHBIT>>>
		;"sheet is not in the bed, but it's described as being so"
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TEE) ;"finds room on others side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET TEE <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TEE> ,DEXIT>
				    <EQUAL? <GET .TEE ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE ULTIMATELY-IN? (OBJ "OPTIONAL" (CONT <>)) ;"formerly HELD?"
	 <COND (<NOT .CONT>
		<SET CONT ,WINNER>)>
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ .CONT>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       ;(<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<ULTIMATELY-IN? <LOC .OBJ> .CONT>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND .OBJ
	      <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<INTBL? .OBJ1 .TEE ;<- <PTSIZE .TEE> 1>
			            </ <PTSIZE .TEE> 2>>)>>

<ROUTINE FIND-IN (WHERE FLAG-IN-QUESTION
		  "OPTIONAL" (STRING <>) "AUX" OBJ RECURSIVE-OBJ)
	 <SET OBJ <FIRST? .WHERE>>
	 <COND (<NOT .OBJ>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .OBJ .FLAG-IN-QUESTION>
			     <NOT <FSET? .OBJ ,INVISIBLE>>>
			<COND (.STRING
			       <TELL "[" .STRING T .OBJ "]" CR>)>
			<RETURN .OBJ>)
		       (<SET RECURSIVE-OBJ <FIND-IN .OBJ .FLAG-IN-QUESTION>>
			<RETURN .RECURSIVE-OBJ>)
		       (<NOT <SET OBJ <NEXT? .OBJ>>>
			<RETURN <>>)>>>

;<ROUTINE DIRECTION? (OBJ)
	 <COND (<OR <EQUAL? .OBJ ,P?NORTH ,P?SOUTH ,P?EAST>
		    <EQUAL? .OBJ ,P?WEST ,P?NE ,P?NW>
		    <EQUAL? .OBJ ,P?SE ,P?SW>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE NOW-DARK? ()
	 <COND (<AND ,LIT
		     <NOT <LIT? ,HERE>>>
		<SETG LIT <>>
		<TELL "   It is now too dark to see." CR>)>>

<ROUTINE NOW-LIT? ()
	 <COND (<AND <NOT ,LIT>
		     <LIT? ,HERE>>
		<SETG LIT T>
		<CRLF>
		<V-LOOK>)>>

<ROUTINE LOC-CLOSED ("AUX" (L <LOC ,PRSO>))
	 <COND (<AND <FSET? .L ,CONTBIT>
		     <NOT <FSET? .L ,OPENBIT>>
		     <FSET? ,PRSO ,TAKEBIT>>
		<DO-FIRST "open" .L>)
	       (T
		<RFALSE>)>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE STOP ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE ROB (WHO "OPTIONAL" (WHERE <>) "AUX" N X)
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<ZERO? .X>
			<RETURN>)>
		 <SET N <NEXT? .X>>
		 <MOVE .X .WHERE>
		 <SET X .N>>>

<ROUTINE WRONG-SEX-WORD (OBJ MALE-WORD FEMALE-WORD)
	 <COND (<NOT ,SEX-CHOSEN>
		<RFALSE>)
	       (<OR <AND ,MALE
			 <NOUN-USED .FEMALE-WORD .OBJ>>
		    <AND <NOT ,MALE>
			 <NOUN-USED .MALE-WORD .OBJ>>>
		<TELL "There's no">
		<COND (<EQUAL? .OBJ ,SIDEKICK>
		       <TELL " one by that name">)
		      (<PRSO? .OBJ>
		       <PRSO-PRINT>)
		      (T
		       <PRSI-PRINT>)>
		<TELL " here.">
		<COND (<NOT <EQUAL? ,NAUGHTY-LEVEL 0>>
		       <TELL
" [I see you've been playing both as a male and as a female! I guess
you're the type who goes both ways, eh? Nudge, nudge, wink, wink!]">)>
		<SETG P-WON <>>
		<CRLF>)
	       (T
		<RFALSE>)>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR T ,PRSO>
	 <HO-HUM>>

<ROUTINE HO-HUM ()
	 <TELL <PICK-ONE ,HO-HUM-LIST> CR>>

<GLOBAL HO-HUM-LIST
	<LTABLE
	 0 
	 " doesn't do anything."
	 " accomplishes nothing."
	 " has no desirable effect.">>		 

<ROUTINE YUKS ()
	 <TELL <PICK-ONE ,YUK-LIST> CR>>

<GLOBAL YUK-LIST
	<LTABLE
	 0 
	 "What a concept."
         "Nice try."
	 "You've gotta be kidding."
	 "Think again, humanoid.">>

<ROUTINE IMPOSSIBLES ()
	 <TELL <PICK-ONE ,IMPOSSIBLE-LIST> CR>>

<GLOBAL IMPOSSIBLE-LIST
	<LTABLE
	 0
	 "Fat chance."
	 "Imposterous!"
	 "Dream on."
	 "Prepossible!"
	 "It's the looney bin for you!"
	 "You have lost your mind.">>

<ROUTINE WASTES ()
	 <TELL <PICK-ONE ,WASTE-LIST> CR>>

<GLOBAL WASTE-LIST
	<LTABLE 0
"A bigger waste of time than selling green cheese to the man in the moon."
"It's not worth it. Believe me."
"Useless. Unhelpful. Nonproductivish. Ineffectivoid."
"There's another turn down the drain."
"Why bother?">>
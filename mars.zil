	"MARS for
		      LEATHER GODDESSES OF PHOBOS
	(c) Copyright 1986 Infocom, Inc.  All Rights Reserved."

<ROOM MARTIAN-DESERT
      (LOC ROOMS)
      (DESC "Martian Desert")
      (LDESC
"As you wander amidst these towering dunes of red Martian sand, you notice
three distinct pathways: north, east, and west.")
      (NORTH TO RUINED-CASTLE-1)
      (EAST TO RUINED-CASTLE-2)
      (WEST TO RUINED-CASTLE-3)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL DUNES)>

<GLOBAL CASTLES-SEEN 0>

<ROUTINE NAME-CASTLE ()
	 <COND (<FSET? ,HERE ,TOUCHBIT>
		<RFALSE>)>
	 <COND (<EQUAL? ,CASTLES-SEEN 0>
		<PUTP ,HERE ,P?SDESC "Ruin">)
	       (<EQUAL? ,CASTLES-SEEN 1>
		<PUTP ,HERE ,P?SDESC "Another Ruin">)
	       (<EQUAL? ,CASTLES-SEEN 2>
		<PUTP ,HERE ,P?SDESC "Yet Another Ruin">)>
	 <SETG CASTLES-SEEN <+ ,CASTLES-SEEN 1>>>

<ROUTINE CASTLE-NOTE ()
	 <COND (<EQUAL? ,CASTLES-SEEN 2>
		<TELL
"(There do seem to be quite a few of them around here, eh?) ">)
	       (<EQUAL? ,CASTLES-SEEN 3>
		<TELL
"(It's no wonder this section of Mars is considered the Ruined Castle
Capital of the Solar System.) ">)>>

<ROOM RUINED-CASTLE-1
      (LOC ROOMS)
      (DESC "Ruined Castle")
      (SDESC "")
      (SOUTH TO MARTIAN-DESERT)
      (OUT TO MARTIAN-DESERT)
      (NORTH TO THRONE-ROOM)
      (IN TO THRONE-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (ACTION RUINED-CASTLE-1-F)>

<ROUTINE RUINED-CASTLE-1-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<NAME-CASTLE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "You stand amongst the ruins of a mighty castle. ">
		<CASTLE-NOTE>
		<TELL
"The only part of the castle that is more than a pile of rubble is to the
north. A path leads out of the ruin to the south.">)>>

<ROOM THRONE-ROOM
      (LOC ROOMS)
      (DESC "Throne Room")
      (SOUTH TO RUINED-CASTLE-1)
      (OUT TO RUINED-CASTLE-1)
      (NORTH TO ROYAL-DOCKS)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (ACTION THRONE-ROOM-F)
      ;(THINGS <PSEUDO (ROYAL CROWN MITRE-CROWN-F)
		      (MITRE CROWN MITRE-CROWN-F)
		      (KING\'S CROWN MITRE-CROWN-F)
		      (GOLDEN HAIR GOWN-F)
		      (WHITE GOWN GOWN-F)
		      (FLOWING GOWN GOWN-F)>)>

<OBJECT MITRE-CROWN
      (LOC THRONE-ROOM) 
      (DESC "Mitre's crown")
      (SYNONYM CROWN)
      (ADJECTIVE ROYAL MITRE\'S KING\'S)
      (FLAGS NDESCBIT)
      (ACTION MITRE-CROWN-F)>

<OBJECT GOWN
      (LOC THRONE-ROOM)
      (DESC "flowing white gown")
      (SYNONYM HAIR GOWN)
      (ADJECTIVE GOLDEN FLOWING WHITE)
      (FLAGS NDESCBIT)
      (ACTION GOWN-F)>

<ROUTINE THRONE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<REMOVE ,MITRE> ;"this is supposed to make Mitre..."
		<MOVE ,MITRE ,HERE> ;"...the first object described."
		<TELL
"This is the " 'HERE " of the once-potent " 'MITRE ", of legendary fame.
Of course, the version you've probably heard is significantly warped from
What Really Happened.|
   In the diseased version of the legend commonly transmitted on Earth, Mitre
is called Midas. The King was granted his wish that everything he touched
would turn to gold. His greed caught up with him when he transformed even his
own daughter into gold.|
   " 'MITRE "'s wish was, in fact, that everything he touched would turn to"
,45-DEGREE-ANGLE "s. ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL "T">)
		      (T
		       <TELL
"No one has ever explained this strange wish; the most likely hypothesis
is a sexual fetish. In any case, t">)>
		<TELL
"he tale has a similar climax, with Mitre turning his own
daughter into a" ,45-DEGREE-ANGLE ".">)>>

<ROUTINE MITRE-CROWN-F ()
	 <COND (<VERB? TAKE>
		<TELL ,MORE-ROYAL-BLOOD>)
	       (<VERB? EXAMINE>
		<TELL "It's not very round for a crown." CR>)>>

<ROUTINE GOWN-F ()
	 <COND (<VERB? TAKE>
		<PERFORM-PRSA ,THETA>
		<RTRUE>)>>

<OBJECT MITRE
	(LOC THRONE-ROOM)
	(DESC "King Mitre")
	(DESCFCN MITRE-F)
	(SYNONYM KING MITRE)
	(ADJECTIVE KING)
	(FLAGS ACTORBIT NARTICLEBIT)
	(ACTION MITRE-F)>

<ROUTINE MITRE-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL "   King Mitre sits upon the throne, looking ">
		<COND (<FSET? ,THETA ,MUNGBIT>
		       <TELL
"dejected and lonely. Next to him is a pile of" ,45-DEGREE-ANGLE "s. One
stands out from the others, thanks to its golden hair and flowing white gown">)
		      (T
		       <TELL "delirious with joy">)>
		<TELL
". The main entrance of the throne room is to the south, but a
tight opening leads north.">)
	       (<EQUAL? ,MITRE ,WINNER>
		<COND (<OR <AND <VERB? WHAT>
				<PRSO? ,LGOP>>
			   <AND <VERB? TELL-ABOUT>
				<PRSO? ,ME>
				<PRSI? ,LGOP>>>
		       <TELL
"\"Leather fetishists, every one of them. Me, I'm not into fetishes.\"" CR>)
		      (<AND <VERB? CHEER>
			    <PRSO? ,ROOMS>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM-PRSA ,MITRE>
		       <SETG WINNER ,MITRE>
		       <RTRUE>)
		      (<AND <VERB? TOUCH>
			    <FSET? ,PRSO ,TAKEBIT>
			    <NOT <PRSO? ,GARMENT ,COMIC-BOOK>>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?GIVE ,PRSO ,MITRE>
		       <SETG WINNER ,MITRE>
		       <RTRUE>)
		      (T
			<TELL "\"I don't feel like talking. I'm too ">
			<COND (<FSET? ,THETA ,MUNGBIT>
		       	       <TELL "un">)>
			<TELL "happy.\"" CR>
			<STOP>)>)
	       (<VERB? EXAMINE>
		<TELL "The old king looks very ">
		<COND (<FSET? ,THETA ,MUNGBIT>
		       <TELL "down">)
		      (T
		       <TELL "up">)>
		<TELL
". His appearance is rather odd, since his clothes, his jewelry, his
crown, even his very throne, all have a rather angular appearance." CR>)
	       (<OR <AND <VERB? ASK-ABOUT>
			 <PRSI? ,THETA>>
		    <AND <VERB? SHOW>
			 <PRSO? ,THETA>>>
		<COND (<FSET? ,THETA ,MUNGBIT>
		       <TELL "The king weeps pitifully." CR>)
		      (T
		       <TELL "The king beams." CR>)>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,MITRE>>
		<REMOVE ,PRSO>
		<TELL
"As Mitre touches" T ,PRSO "," T ,PILE-OF-ANGLES " becomes a bit larger." CR>)
	       (<VERB? TOUCH>
		<TELL "It only works the other way." CR>)
	       (<AND <VERB? SHAKE-WITH>
		     <PRSO? ,HANDS>>
		<TELL
"As you join the other angles in the pile, life becomes very boring. Two
centuries later, following Mitre's death, the " 'PILE-OF-ANGLES " is sold to
a geometry teacher on Baffin Island, who uses you to demonstrate bisections,
trigonometric proofs, and basic picture framing techniques." CR>
		<FINISH>)>>

<OBJECT THETA
	(LOC THRONE-ROOM)
	(SDESC "different-looking angle")
	(LDESC
"Princess Theta stands demurely by her father's throne, buried up
to her thighs in forty-five degree angles.")
	(SYNONYM ANGLE PRINCE DAUGHTER THETA)
	(ADJECTIVE HIS DIFFERENT FORTY DEGREE NUMBER KING\'S DAUGHTER PRINCE)
	(GENERIC GENERIC-ANGLE-F)
	(FLAGS NDESCBIT MUNGBIT)
	(ACTION THETA-F)>

<ROUTINE THETA-F ()
	 <COND (<AND <ADJ-USED ,W?NUMBER>
		     <NOT <EQUAL? ,P-NUMBER 45>>>
		<NO-X-DEGREE-ANGLE> ;"will this really work?")
	       (<EQUAL? ,THETA ,WINNER>
		<COND (<OR <AND <VERB? WHAT>
				<PRSO? ,LGOP>>
			   <AND <VERB? TELL-ABOUT>
				<PRSO? ,ME>
				<PRSI? ,LGOP>>>
		       <TELL
"\"The travelling acrobatic troupe! I saw them while I was mooning on
Phobos. Their costumes are made of pure Chomperhide leather.\"" CR>)
		      (T
		       <TELL
"The princess, whose recent experience has made her more obtuse,
just looks at you dumbly." CR>)>)
	       (<AND <VERB? MEASURE>
		     <FSET? ,THETA ,MUNGBIT>>
		<PERFORM-PRSA ,PILE-OF-ANGLES>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,THETA ,MUNGBIT>
		       <TELL
"The angle has the sort of golden hair and satiny robes that one
normally associates with princesses." CR>)
		      (T
		       <TELL "The princess, once acute, is now cute." CR>)>)
	       (<VERB? TAKE KISS FUCK TOUCH BEND>
		<TELL
"Mitre growls, \"Keep " 'HANDS "s off my daughter.\"" CR>)
	       (<VERB? MARRY>
		<COND (<FSET? ,THETA ,MUNGBIT>
		       <WANT-CHILDREN "angular">)
		      (T
		       <TELL
"\"Only one of royal blood shall bisect ... er, wed ... my
Theta!\" bellows Mitre." CR>)>)>>

<ROUTINE WANT-CHILDREN (STRING)
	 <SETG AWAITING-REPLY 2>
	 <QUEUE I-REPLY 2>
	 <TELL "Would you really want " .STRING " children?" CR>>

<OBJECT EIGHTY-TWO-DEGREE-ANGLE
	(DESC "eighty-two degree angle")
	(NO-T-DESC "eighy-wo degree angle")
	(SYNONYM ANGLE)
	(ADJECTIVE EIGHTY EIGHY DEGREE NUMBER)
	(FLAGS TAKEBIT VOWELBIT)
	(GENERIC GENERIC-ANGLE-F)
	(ACTION EIGHTY-TWO-DEGREE-ANGLE-F)>

<ROUTINE EIGHTY-TWO-DEGREE-ANGLE-F ()
	 <COND (<AND <ADJ-USED ,W?NUMBER>
		     <NOT <EQUAL? ,P-NUMBER 82>>>
		<NO-X-DEGREE-ANGLE> ;"will this really work?")
	       (<AND <VERB? MEASURE>
		     <NOT <FSET? ,EIGHTY-TWO-DEGREE-ANGLE ,UNTEEDBIT>>>
		<TELL "82 degrees." CR>)>>

<ROUTINE NO-X-DEGREE-ANGLE ()
	 <TELL ,YOU-CANT-SEE-ANY N ,P-NUMBER " degree angle here!" CR>>

<ROUTINE GENERIC-ANGLE-F ()
	 <COND (<FSET? ,THETA ,MUNGBIT>
		<RFALSE>)
	       (T ;"the princess isn't an angle, at the moment"
	 	,EIGHTY-TWO-DEGREE-ANGLE)>>

<OBJECT PILE-OF-ANGLES
	(LOC THRONE-ROOM)
	(DESC "pile of angles")
	(SYNONYM PILE ANGLES)
	(ADJECTIVE FORTY DEGREE NUMBER)
	(FLAGS NDESCBIT)
	(ACTION PILE-OF-ANGLES-F)>

<ROUTINE PILE-OF-ANGLES-F ()
	 <COND (<AND <ADJ-USED ,W?NUMBER>
		     <NOT <EQUAL? ,P-NUMBER 45>>>
		<NO-X-DEGREE-ANGLE> ;"will this really work?")
	       (<VERB? COUNT>
		<TELL "Lots." CR>)
	       (<VERB? TAKE>
		<TELL "The " 'PILE-OF-ANGLES " is too big to carry.">
		<COND (<FSET? ,THETA ,MUNGBIT>
		       <TELL
" Besides, other than" T ,THETA ", none of them are interesting.">)>
		<CRLF>)
	       (<VERB? MEASURE>
		<TELL "45 degrees." CR>)>>

<ROOM RUINED-CASTLE-2
      (LOC ROOMS)
      (DESC "Ruined Castle")
      (SDESC "")
      (WEST TO MARTIAN-DESERT)
      (EAST TO MARTIAN-DESSERT)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL DULL-DUST)
      (ACTION RUINED-CASTLE-2-F)
      ;(THINGS <PSEUDO (<> DUST UNIMPORTANT-THING-F)
		      (SMALL CROWN FROG-CROWN-F)
		      (GOLD CROWN FROG-CROWN-F)
		      (FROG\'S CROWN FROG-CROWN-F)>)>

<OBJECT DULL-DUST
      (LOC LOCAL-GLOBALS)
      (DESC "dust")
      (SYNONYM DUST)
      (FLAGS NDESCBIT)
      (ACTION UNIMPORTANT-THING-F)>

<OBJECT FROG-CROWN
      (LOC RUINED-CASTLE-2) 
      (DESC "small gold crown")
      (SYNONYM CROWN)
      (ADJECTIVE SMALL GOLD FROG\'S)
      (FLAGS NDESCBIT)
      (ACTION FROG-CROWN-F)>

<ROUTINE FROG-CROWN-F ()
	 <COND (<VERB? TAKE>
		<TELL ,MORE-ROYAL-BLOOD>)
	       (<VERB? EXAMINE>
		<TELL "It's tiny." CR>)>>

<ROUTINE RUINED-CASTLE-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,RUINED-CASTLE-2 ,MUNGBIT>
		<NAME-CASTLE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "This ancient castle now lies in ruins. ">
		<CASTLE-NOTE>
		<TELL
"All that remains of its once-proud ramparts are dust and rubble, and an
occasional stone block. A path leads away from the ruin to the west">
		<UNCHARTABLE-DESERT "east">)>>

<ROUTINE UNCHARTABLE-DESERT (STRING)
	 <TELL ". To the " .STRING ": unchartable desert.">>

<OBJECT FROG
	(LOC RUINED-CASTLE-2)
	(DESC "frog")
	(LDESC
"Sitting on one of the stone blocks is a large green frog. Something about
it catches your eye.")
	(SYNONYM FROG PRINCE)
	(ADJECTIVE ENCHANTED LARGE GREEN)
	(ACTION FROG-F)>

<ROUTINE FROG-F ()
	 <COND (<OR <VERB? TELL LISTEN>
		    <AND <VERB? GIVE>
			 <PRSI? ,FROG>>>
		<TELL "\"Ribit.\"" CR>
		<COND (<VERB? TELL>
		       <STOP>)>
		<RTRUE>)
	       (<VERB? EAT TASTE SUCK SMELL>
		<TELL ,YECHH>)
	       (<VERB? EXAMINE>
		<TELL
"You realize what aroused your attention: the tiny gold crown on the frog's
head. The frog is otherwise totally ordinary. Ordinary for a frog, that is.
By any other measure it is a repulsive creature, with swollen eyes, oozing
warts, slimy skin, and a grating croak." CR>)
	       (<VERB? TOUCH>
		<TELL  "Huge, ugly warts cover every inch of " 'YOUR-BODY>
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL ", but">)
		      (T
		       <TELL ". Fortunately for your sex life,">)>
		<TELL " they quickly fade away." CR>)
	       (<VERB? MARRY>
		<WANT-CHILDREN "green">)
	       (<VERB? KISS>
		<TELL "You lean forward">
		<COND (<FSET? ,EYES ,MUNGBIT>
		       <TELL " with " 'EYES " ">
		       <COND (<EQUAL? ,EYES ,HAND-COVER>
			      <TELL "covered">)
			     (T
			      <TELL "closed">)>
		       <COND (<FSET? ,NOSE ,MUNGBIT>
			      <COND (<FSET? ,EARS ,MUNGBIT>
				     <TELL ",">)
				    (T
				     <TELL " and">)>
			      <TELL " " 'NOSE " shut">
			      <COND (<FSET? ,EARS ,MUNGBIT>
				     <COND (<FSET? ,MOUTH ,MUNGBIT>
				            <TELL ",">)
					   (T
				            <TELL " and">)>
				     <TELL " " 'EARS " ">
				     <COND (<EQUAL? ,EARS ,HAND-COVER>
					    <TELL "covered">)
					   (T
					    <TELL "stuffed up">)>
				     <COND (<FSET? ,MOUTH ,MUNGBIT>
					    <FROG-SEX-SCENE>
					    <RTRUE>)
					   (T
					    <TELL
,ABOUT-TO-KISS "the thought of slimy frog lips pressing against
your own makes you shudder away." CR>)>)
				    (T
				     <TELL
,ABOUT-TO-KISS "the creature lets loose a loud, croaking \"ribit.\" You
admit that you are incapable of kissing under such circumstances." CR>)>)
			     (T
			      <TELL
,ABOUT-TO-KISS "the stench of old pond scum overwhelms you,
and you lurch back, retching." CR>)>)
		      (T
		       <TELL
,ABOUT-TO-KISS "the sight of its green warts and slimy skin make it
impossible to continue." CR>)>)>>

<ROUTINE FROG-SEX-SCENE ()
	 <MOVE ,FROG ,LOCAL-GLOBALS>
	 <MOVE ,BLENDER ,HERE>
	 <INCREMENT-SCORE 17 17 T>
	 <OPEN-EYES-AND-REMOVE-HANDS>
	 <TELL
" and your lips smeared with balm. Planting " 'MOUTH " solidly against
the frog's, you kiss deeply. ">
	 <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		<TELL
"The kiss is surprisingly pleasant, until you notice that you're embracing a ">
		<COND (,MALE
		       <TELL "beautiful princess. Sh">)
		      (T
		       <TELL "handsome prince. H">)>
		<TELL
"e leaps back, blushing deeply. \"We're ... we're not married,\" ">
		<SHE-HE>
		<TELL " stammers. Then, still reddening, ">
		<SHE-HE>
		<TELL " vanishes into thin air! Y">)
	       (T
		<FSET ,RUINED-CASTLE-2 ,MUNGBIT> ;"for V-DIAGNOSE"
		<TELL
"When you feel a tongue sliding into " 'MOUTH ", revulsion gives way to
pleasure, as the no-longer-enchanted but quite enchanting prince">
	        <COND (,MALE
		       <TELL "ss">)>
		<TELL " presses against you. ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 1>
		       <TELL "Some time later, after the prince">
		       <COND (,MALE
			      <TELL "ss">)>
		       <TELL " has departed...">)
	       	      (T
		       <COND (,MALE
		       	      <TELL
"Rubbing her hot, naked body against yours, s">)
		      	     (T
		       	      <TELL
"As your arms grip his naked, muscular back, ">)>
		       <TELL
"he effortlessly slips off your " D ,GARMENT ". A warm and wild feeling springs
from your loins, spreading like a fiery potion through your veins. Within
moments you are joined in passionate love, and just as a quick and lustful
orgasm seems inevitable, a force crackles in the air, and you are alone, naked,
sweating, and unsatisfied.">)>
		<TELL CR "   As you gather up your garment and put it on, y">)>
	 <TELL "ou notice" A ,BLENDER " on the ground. " ,ITS-ENGRAVED>
	 <COND (<IN? ,SIDEKICK ,HERE>
		<TELL
" " D ,SIDEKICK " is at the other end of the ruin, sifting through some
rubble, oblivious to your \"experience.\"">)>
	 <CRLF>>

<OBJECT BLENDER
	(DESC "common household blender")
	(SYNONYM BLENDER MIXER ENGRAVING)
	(ADJECTIVE COMMON HOUSEHOLD)
	(FLAGS TAKEBIT LIGHTBIT READBIT)
	(SIZE 8)
	(ACTION BLENDER-F)>

<ROUTINE BLENDER-F ()
	 <COND (<VERB? READ>
		<COND (<NOT <EQUAL? ,NAUGHTY-LEVEL 0>>
		       <TELL "\"Dearest," CR>
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 2>
			      <TELL "   Sorry to leave so abruptly; p">)
			     (T
			      <TELL "   P">)>
		       <TELL "erhaps some day we will meet again">
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 2>
			      <TELL ", and finish what we began">)>
		       <TELL ". ">)
		      (T
		       <TELL "\"">)>
		<TELL
"Please accept this token of my gratitude for delivering me from
enchantment.\"" CR>)
	       (<VERB? EXAMINE>
		<COND (<NOUN-USED ,W?ENGRAVING ,BLENDER>
		       <PERFORM ,V?READ ,BLENDER>
		       <RTRUE>)
		      (T
		       <TELL ,ITS-ENGRAVED CR>)>)
	       (<VERB? ON>
		<TELL "\"Whirr.\"" CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL "It's empty." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,BLENDER>>
		<TELL "But" T ,PRSO " doesn't need blending." CR>)>>

<ROOM RUINED-CASTLE-3
      (LOC ROOMS)
      (DESC "Ruined Castle")
      (SDESC "")
      (EAST TO MARTIAN-DESERT)
      (NW TO HICKORY-AND-DICKORY-DOCK)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HOLE)
      (HOLE-DESTINATION BASEMENT)
      (ACTION RUINED-CASTLE-3-F)>

<ROUTINE RUINED-CASTLE-3-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<NAME-CASTLE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Wind whistles among the fallen archways, crumbled balustrades, and black
circle of this ruined castle. ">
		<CASTLE-NOTE>
		<TELL "Paths lead east and northwest through the rubble.">)>>

<ROOM HICKORY-AND-DICKORY-DOCK
	(LOC ROOMS)
	(DESC "Hickory & Dickory Dock")
	(LDESC
"This dock, which extends north into a broad canal, is crafted of fine
woods from across the solar system: hickory wood from the forests of
Earth, and dickory wood from the jungles of Venus. A path leads south.")
	(SOUTH TO RUINED-CASTLE-3)
	(NORTH SORRY "If you want to jump in the canal, say so.")
	(NE SORRY "If you want to jump in the canal, say so.")
	(NW SORRY "If you want to jump in the canal, say so.")
	(FLAGS RLANDBIT ONBIT)
	(GLOBAL CANAL-OBJECT DOCK-OBJECT WATER)>

<OBJECT MOUSE
	(LOC HICKORY-AND-DICKORY-DOCK)
	(DESC "mouse")
	(FDESC "You spot a little white marsmouse running along the dock.")
	(SYNONYM MOUSE MARSMOUSE)
	(ADJECTIVE SMALL WHITE)
	(SIZE 3)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION MOUSE-F)>

<ROUTINE MOUSE-F ()
	 <COND (<VERB? CLICK>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
	        <TELL "You expect maybe a window to open?" CR>)
	       (<AND <VERB? SHOW>
		     <PRSO? ,PAINTING>
		     <NOT <FSET? ,PAINTING ,UNTEEDBIT>>>
		<FCLEAR ,MOUSE ,TRYTAKEBIT>
		<FSET ,MOUSE ,TOUCHBIT>
		<QUEUE I-MOUSE 2>
		<TELL "The mouse freezes with fear." CR>)
	       (<AND <VERB? GIVE>
		     <PRSI? ,MOUSE>>
		<TELL "Marsmice, like earthmice, prefer cheese." CR>)
	       (<VERB? CATCH>
		<PERFORM ,V?TAKE ,MOUSE>
		<RTRUE>)
	       (<AND <TOUCHING? ,MOUSE>
		     <IN? ,MOUSE ,HERE>
		     <FSET? ,MOUSE ,TRYTAKEBIT>>
		<TELL "The little fellow scurries easily away from you." CR>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,P-PRSA-WORD ,W?CHASE>
		     <IN? ,MOUSE ,HERE>
		     <FSET? ,MOUSE ,TRYTAKEBIT>>
		<PERFORM ,V?TAKE ,MOUSE>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <NOT <FSET? ,MOUSE ,MUNGBIT>>
		     <L? <CCOUNT ,PROTAGONIST> 11>>
		<FSET ,MOUSE ,MUNGBIT>
		<INCREMENT-SCORE 14 9 T>
		<RFALSE>)
	       (<VERB? MEASURE>
		<TELL "Tiny." CR>)
	       (<VERB? TOUCH>
		<TELL "The mouse squeaks happily." CR>)>>

<ROUTINE I-MOUSE ()
	 <FSET ,MOUSE ,TRYTAKEBIT>
	 <COND (<IN? ,MOUSE ,RUINED-CASTLE-1>
	 	<FCLEAR ,MOUSE ,TOUCHBIT>)>
	 <COND (<IN? ,MOUSE ,HERE>
	 	<TELL "   The mouse relaxes and begins scampering about." CR>)
	       (T
		<RFALSE>)>>

<ROOM ROYAL-DOCKS
	(LOC ROOMS)
	(DESC "Royal Docks")
	(SOUTH TO THRONE-ROOM)
	(NORTH SORRY "If you want to jump in the canal, say so.")
	(NE SORRY "If you want to jump in the canal, say so.")
	(NW SORRY "If you want to jump in the canal, say so.")
	(IN TO THRONE-ROOM)
	(FLAGS RLANDBIT ONBIT)
	(GLOBAL CANAL-OBJECT DOCK-OBJECT WATER)
	(ACTION ROYAL-DOCKS-F)>

<ROUTINE ROYAL-DOCKS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL "This dock juts">)
		      (T
		       <TELL
"During the peak of King Mitre's reign, a cruel joke went around
the kingdom that Mitre's two greatest loves were his Royal Docks
and his Royal Ducks. The joke was never very good and has long
since been forgotten, and the ducks perished years ago from a
sexually transmitted disease, but the docks remain, jutting">)>
		<TELL
" into a wide Martian Canal which flows from west to east. Behind you,
to the south, is a ruined castle.">)>>

<OBJECT BARGE
	(LOC ROYAL-DOCKS)
	(DESC "royal barge")
	(DESCFCN BARGE-F)
	(SYNONYM BARGE BOAT GONDOLA CONTROL CONTROLS BUTTONS)
	(ADJECTIVE ROYAL WOODEN CEDAR CEDARWOOD SIMPLE)
	(GENERIC GENERIC-BARGE-F)
	(FLAGS INBIT VEHBIT CONTBIT SEARCHBIT OPENBIT)
	(CAPACITY 200)
	(ACTION BARGE-F)>

<ROUTINE BARGE-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL
"   A barge, hand-crafted from fine Martian cedarwood, is ">
		<COND (<EQUAL? ,HERE ,CANAL>
		       <TELL "floating nearby.">)
		      (T
		       <TELL "moored at the end of the dock.">)>)
	       (<AND <EQUAL? ,HERE ,CANAL>
		     <IN? ,PROTAGONIST ,RAFT>
		     <NOT <EQUAL? ,RAFT-LOC-NUM ,BARGE-LOC-NUM>>>
		<CANT-SEE ,BARGE>)
	       (<VERB? SINK>
		<TELL
"The barge is unsinkable. (Then again, so was the Titanic.)" CR>)
	       (<VERB? UNTIE LAUNCH>
		<TELL "The barge isn't moored">
		<COND (<NOT <IN? ,BARGE ,CANAL>>
		       <TELL " with ropes">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? EXAMINE>
		<COND (<OR <NOUN-USED ,W?CONTROL ,BARGE>
			   <NOUN-USED ,W?CONTROLS ,BARGE>
			   <NOUN-USED ,W?BUTTONS ,BARGE>>
		       <TELL
"The controls consist of a " 'ORANGE-BUTTON ", and a " 'PURPLE-BUTTON
". Both buttons have writing on them." CR>)
		      (T
		       <TELL
"This large barge could host a host of royal guests.">
		       <COND (<NOT <EQUAL? ,HERE ,CANAL>>
			      <TELL
" The barge rests immobile at the dockside, despite a strong current
and no visible mooring lines.">)>
		       <TELL
" There are some simple controls on the side of the barge">
		       <COND (<NOT <EQUAL? ,HERE ,CANAL>>
			      <TELL " nearest the dock">)>
		       <TELL ,PERIOD-CR>)>)
	       (<VERB? READ>
		<PERFORM-PRSA ,ORANGE-BUTTON>
		<PERFORM-PRSA ,PURPLE-BUTTON>
		<RTRUE>)
	       (<AND <VERB? PUSH>
		     <OR <NOUN-USED ,W?CONTROL ,BARGE>
			 <NOUN-USED ,W?CONTROLS ,BARGE>
			 <NOUN-USED ,W?BUTTONS ,BARGE>>>
		<PERFORM-PRSA ,ORANGE-BUTTON>
		<TELL "   ">
		<PERFORM-PRSA ,PURPLE-BUTTON>
		<RTRUE>)
	       (<VERB? SET>
		<TELL ,NO-STEERING>)
	       (<AND <VERB? BOARD TAKE>
		     <EQUAL? ,HERE ,CANAL>
		     <IN? ,PROTAGONIST ,RAFT>>
		<MOVE ,PROTAGONIST ,BARGE>
		<SETG OHERE <>>
		<TELL "Grabbing onto the barge, you">
		<AND-SIDEKICK ,BARGE>
		<MOVE ,RAFT ,PROTAGONIST>
		<SETG RAFT-HELD <>>
		<TELL " climb in" ,KEEP-IT-FROM-FLOATING-AWAY>)
	       (<AND <VERB? PUT-ON>
		     <PRSI? ,BARGE>>
		<PERFORM ,V?PUT ,PRSO ,BARGE>
		<RTRUE>)
	       (<VERB? SMELL>
		<NO-SCRATCH-N-SNIFF "aged cedarwood">) 
	       (<AND <VERB? SHAKE>
		     <IN? ,PROTAGONIST ,BARGE>>
		<SHAKE-BOAT>)
	       (<VERB? LAND>
		<SETG AWAITING-REPLY 2>
		<QUEUE I-REPLY 2>
		<TELL "Read any " 'ORANGE-BUTTON "s lately?" CR>)>>

<ROUTINE GENERIC-BARGE-F ()
	 <RETURN ,BARGE>>

<ROUTINE SHAKE-BOAT ()
	 <TELL "You knock yourself overboard." CR CR>
	 <PERFORM ,V?BOARD ,CANAL-OBJECT>
	 <RTRUE>>

<OBJECT ORANGE-BUTTON
	(LOC GLOBAL-OBJECTS)
	(DESC "huge orange button")
	(SYNONYM BUTTON)
	(ADJECTIVE LARGE ORANGE)
	(FLAGS NDESCBIT)
	(ACTION ORANGE-BUTTON-F)>

<ROUTINE ORANGE-BUTTON-F ("AUX" ATBARGE)
	 <SET ATBARGE <CHECK-BARGE-LOC>>
	 <COND (<F? .ATBARGE>
	        <CANT-SEE ,ORANGE-BUTTON>)
	       (<AND <==? .ATBARGE ,RAFT>
		     <TOUCHING? ,ORANGE-BUTTON>>
		<CANT-REACH ,PRSO>)>
	 <COND (<VERB? READ EXAMINE>
		<TELL "The " 'ORANGE-BUTTON " reads: MagnetoMoor O">
		<COND (,MOORING-ON
		       <TELL "n">)
		      (T
		       <TELL "ff">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? PUSH>
		<COND (,MOORING-ON
		       <SETG MOORING-ON <>>)
		      (T
		       <SETG MOORING-ON T>)>
		<TELL ,WRITING-CHANGES ".">
		<COND (<AND <NOT <IN? ,BARGE ,CANAL>>
			    <NOT ,MOORING-ON>
			    <NOT <EQUAL? ,HERE ,ICY-DOCK>>>
		       <MOVE ,BARGE ,CANAL>
		       <COND (<AND ,RAFT-HELD
				   <IN? ,PROTAGONIST ,BARGE>>
			      <MOVE ,RAFT ,CANAL>
			      <SETG RAFT-LOC-NUM ,BARGE-LOC-NUM>)>
		       <FCLEAR ,BARGE ,NDESCBIT>
		       <QUEUE I-CANAL -1>
		       <TELL " The barge s">
		       <COND (,BARGE-UNDER-POWER
			      <TELL "hoot">)
			     (T
			      <TELL "lide">)>
		       <TELL
"s away from the dock, into the deeper waters of the canal." CR>
		       <COND (<IN? ,PROTAGONIST ,BARGE>
			      <CRLF>
			      <GOTO ,BARGE>)>
		       <RTRUE>)
		      (<NOT <BARGE-DOCKS>>
		       <CRLF>)>
		<RTRUE>)>>

<ROUTINE CHECK-BARGE-LOC ()
	<COND (<OR <IN? ,PROTAGONIST ,BARGE>
		   <AND <NOT <IN? ,BARGE ,CANAL>>
			<==? <LOC ,BARGE> <LOC ,PROTAGONIST>>>
		   <AND <==? ,HERE ,CANAL> ;"in raft"
			<IN? ,BARGE ,CANAL>
			<==? ,BARGE-LOC-NUM ,RAFT-LOC-NUM>>>
	       <RETURN ,BARGE>)
	      (<==? ,HERE ,CANAL>
	       <COND (<BARGE-VISIBLE-AT-DOCK>
		      <RETURN ,RAFT>)
		     (T
		      <RETURN <>>)>)
	      (T
	       <RETURN <>>)>>

<OBJECT PURPLE-BUTTON
	(LOC GLOBAL-OBJECTS)
	(DESC "huge purple button")
	(SYNONYM BUTTON)
	(ADJECTIVE LARGE PURPLE)
	(FLAGS NDESCBIT)
	(ACTION PURPLE-BUTTON-F)>

<ROUTINE PURPLE-BUTTON-F ("AUX" ATBARGE)
	 <SET ATBARGE <CHECK-BARGE-LOC>>
	 <COND (<F? .ATBARGE>
	        <CANT-SEE ,PURPLE-BUTTON>)
	       (<AND <==? .ATBARGE ,RAFT>
		     <TOUCHING? ,PURPLE-BUTTON>>
		<CANT-REACH ,PRSO>)>
	 <COND (<VERB? READ EXAMINE>
		<TELL "The " 'PURPLE-BUTTON " reads: ">
		<COND (,BARGE-UNDER-POWER
		       <TELL "Full Speed Ahead">)
		      (T
		       <TELL "Go With The Flow">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? PUSH>
		<TELL ,WRITING-CHANGES>
		<COND (,BARGE-UNDER-POWER
		       <SETG BARGE-UNDER-POWER <>>)
		      (T
		       <SETG BARGE-UNDER-POWER T>
		       <COND (<AND <IN? ,PROTAGONIST ,RAFT>
				   <EQUAL? ,HERE ,CANAL>>
			      <BARGE-FORGES-AHEAD>)>)>
		<TELL ,PERIOD-CR>)>>

<ROUTINE BARGE-FORGES-AHEAD ()
	 <COND (<AND <L? ,BARGE-LOC-NUM 16>
		     ,MOORING-ON>
		<SETG BARGE-LOC-NUM 15>
		<MOVE ,BARGE ,WATTZ-UPP-DOCK>)
	       (T
		<SETG BARGE-LOC-NUM 36>
	 	<MOVE ,BARGE ,ICY-DOCK>)>
	 <TELL
". The barge, under power, forges ahead and disappears from sight">>

<GLOBAL MOORING-ON T>

<GLOBAL BARGE-UNDER-POWER <>>

<GLOBAL BARGE-LOC-NUM 1>

<GLOBAL RAFT-LOC-NUM 10>

<GLOBAL BARGE-WAIT <>>

<GLOBAL RAFT-WAIT <>>

<GLOBAL NEARER-DOCK <>>

<ROUTINE CANAL-LOC ()
	 <COND (<NOT <EQUAL? ,HERE ,CANAL>>
		<RFALSE>)
	       (<IN? ,PROTAGONIST ,BARGE>
		<RETURN ,BARGE-LOC-NUM>)
	       (T
		<RETURN ,RAFT-LOC-NUM>)>>

<ROUTINE SET-RAFT-LOC ()
	 <COND (<EQUAL? ,HERE ,CANAL> ;"you're in the barge"
		<SETG RAFT-LOC-NUM ,BARGE-LOC-NUM>)
	       (<EQUAL? ,HERE ,HICKORY-AND-DICKORY-DOCK>
		<SETG RAFT-LOC-NUM -1>)
	       (<EQUAL? ,HERE ,ROYAL-DOCKS>
		<SETG RAFT-LOC-NUM 1>)
	       (<EQUAL? ,HERE ,BABY-DOCK>
		<SETG RAFT-LOC-NUM 6>)
	       (<EQUAL? ,HERE ,DONALD-DOCK>
		<SETG RAFT-LOC-NUM 7>)
	       (<EQUAL? ,HERE ,WATTZ-UPP-DOCK>
		<SETG RAFT-LOC-NUM 15>)
	       (T
		<SETG RAFT-LOC-NUM 10>)>>

<OBJECT CANAL-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "canal")
	(SYNONYM CANAL)
	(ADJECTIVE MARTIAN SMALL WIDE)
	(ACTION CANAL-OBJECT-F)>

<ROUTINE CANAL-OBJECT-F ()
	 <COND (<ADJ-USED ,W?SMALL>
		<UNIMPORTANT-THING-F>)
	       (<AND <EQUAL? ,HERE ,DUNETOP ,MINARET>
		     <TOUCHING? ,CANAL-OBJECT>>
		<CANT-REACH ,CANAL-OBJECT>)
	       (<VERB? BOARD ENTER SWIM CRAWL-UNDER>
		<COND (<UNTOUCHABLE? ,CANAL-OBJECT>
		       <CANT-REACH ,CANAL-OBJECT>)
		      (<EQUAL? ,HERE ,ICY-DOCK>
		       <TELL "The current sucks you under">
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 2>
			      <TELL ", which really sucks">)>
		       <JIGS-UP ".">)
		      (T
		       <TELL
"In The Canal|
   As you swim in the cool waters of the canal, a slimy tentacle touches you,
convincing you that it's safer back ">)>
		<COND (<EQUAL? <LOC ,PROTAGONIST> ,RAFT ,BARGE>
		       <TELL "in" TR <LOC ,PROTAGONIST>>)
		      (T
		       <TELL "on the dock." CR>)>
		<CRLF>
		<DESCRIBE-ROOM>)
	       (<VERB? CROSS>
		<PERFORM ,V?ENTER ,CANAL-OBJECT>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,P-PRSA-WORD ,W?THROW>
		     <PRSO? ,RAFT>
		     <NOT <FSET? ,RAFT ,UNTEEDBIT>>
		     <NOT <IN? ,PROTAGONIST ,RAFT>>>
		<MOVE ,RAFT ,HERE>
		<SETG RAFT-HELD T>
		<PERFORM ,V?DROP ,RAFT>
		<RTRUE>)
	       (<AND <VERB? PUT THROW>
		     <PRSI? ,CANAL-OBJECT>>
		<COND (<PRSO? ,RAFT>
		       <COND (<OR <FSET? ,RAFT ,UNTEEDBIT>
				  <FSET? ,RAFT ,MUNGBIT>>
			      <REMOVE ,RAFT>
			      <TELL "It sinks like a stone.">
			      <COND (<FSET? ,RAFT ,UNTEEDBIT>
				     <TELL
" I guess a raf doesn't float nearly as well as a raft.">)>
			      <CRLF>)
			     (<OR ,RAFT-HELD
				  <IN? ,RAFT ,CANAL>>
			      <TELL ,ALREADY-IS>)
			     (T
			      <TELL "The raft is now ">
			      <COND (<EQUAL? ,HERE ,ICY-DOCK>
				     <MOVE ,RAFT ,HERE>
				     <TELL "in the water" ,PINNED>)
				    (T
				     <SETG RAFT-HELD T>
				     <MOVE ,RAFT ,HERE>
				     <COND (<EQUAL? ,HERE ,CANAL>
					   <SETG RAFT-LOC-NUM ,BARGE-LOC-NUM>)>
				     <TELL "bobbing in the canal.">
				     <COND (<OR <NOT <EQUAL? ,HERE ,CANAL>>
						,BARGE-UNDER-POWER>
					    <TELL
" If you weren't holding it, it would surely be ">
					    <COND (<EQUAL? ,HERE ,CANAL>
						   <TELL "left behind.">)
						  (T
						   <TELL "carried away.">)>)>
				     <CRLF>)>)>)
		      (T
		       <REMOVE ,PRSO>
		       <COND (<AND <PRSO? ,TORCH>
				   <FSET? ,TORCH ,ONBIT>>
			      <TELL "\"Phfffft!">)
			     (T
		       	      <TELL "\"Glub.">)>
		       <TELL "\" ">
		       <COND (<FSET? ,PRSO ,PLURALBIT>
			      <TELL "They're">)
			     (T
			      <TELL "It's">)>
		       <TELL " gone">
		       <COND (<OR <PRSO? ,BABY>
				  <ULTIMATELY-IN? ,BABY ,PRSO>>
			      <TELL ", you heartless baby murderer, you">)>
		       <TELL ,PERIOD-CR>)>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM-PRSA ,WATER>
		<RTRUE>)>>

<OBJECT DOCK-OBJECT
	(LOC LOCAL-GLOBALS)
	(DESC "dock")
	(SYNONYM DOCK PIER)
	(ADJECTIVE SAND-COVERED SMALL BABY ABANDONED ROYAL)
	(ACTION DOCK-OBJECT-F)>

<ROUTINE DOCK-OBJECT-F ("AUX" NUM DOCK-ROOM)
	 <SET NUM <CANAL-LOC>>
	 <COND (<AND <EQUAL? ,HERE ,CANAL>
		     <NOT <EQUAL? .NUM -1 1 6>>
		     <NOT <EQUAL? .NUM 7 10 15>>>
		<CANT-SEE ,DOCK-OBJECT>
		<RTRUE>)>
	 <COND (<AND <EQUAL? ,HERE ,DUNETOP ,MINARET>
		     <TOUCHING? ,DOCK-OBJECT>>
		<TELL ,CANT-FROM-HERE>)
	       (<AND <VERB? TAKE BOARD>
		     <EQUAL? ,HERE ,CANAL>
		     <IN? ,PROTAGONIST ,RAFT>>
		<TELL
"You lunge for the dock and secure a handhold. An agile clamber places you">
		<AND-SIDEKICK>
		<TELL " on the dock" ,KEEP-IT-FROM-FLOATING-AWAY CR>
		<SETG RAFT-WAIT <>>
		<SETG DONT-PRINT-VEHICLE T> ;"to supress ,IN THE RAFT"
		<SET DOCK-ROOM <SET-DOCK-ROOM ,RAFT-LOC-NUM>>
		<GOTO .DOCK-ROOM>
		<SETG DONT-PRINT-VEHICLE <>>
		<COND (<IN? ,SIDEKICK ,RAFT>
		       <MOVE ,SIDEKICK ,HERE>)>
		<MOVE ,RAFT ,HERE>)
	       (<VERB? BOARD>
		<COND (<EQUAL? ,HERE ,CANAL>
		       <DO-FIRST "land">)
		      (<IN? ,PROTAGONIST ,HERE>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		       <RTRUE>)>)
	       (<AND <VERB? TAKE-OFF>
		     <EQUAL? ,P-PRSA-WORD ,W?GET>>
		<PERFORM ,V?BOARD ,CANAL-OBJECT>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,DOCK-OBJECT>
		     <NOT <EQUAL? ,HERE ,CANAL>>>
		<PERFORM ,V?PUT-ON ,PRSO ,GROUND>
		<RTRUE>)
	       (<VERB? LEAP-OFF>
		<COND (<EQUAL? ,HERE ,DUNETOP ,CANAL>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <PERFORM ,V?ENTER ,CANAL-OBJECT>
		       <RTRUE>)>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)
	       (<AND <VERB? EXAMINE>
		     <NOT <EQUAL? ,HERE ,CANAL ,MINARET ,DUNETOP>>>
		<V-LOOK>)>>

<GLOBAL DONT-PRINT-VEHICLE <>>

<OBJECT DUNES
	(LOC LOCAL-GLOBALS)
	(DESC "sand dunes")
	(SYNONYM DUNE DUNES SAND)
	(ADJECTIVE SAND RED REDDISH TOWERING SCULPTED MARTIAN IMPASSABLE)
	(FLAGS NARTICLEBIT PLURALBIT)
	(ACTION DUNES-F)>

<ROUTINE DUNES-F ()
	 <COND (<AND <EQUAL? ,HERE ,MINARET>
		     <TOUCHING? ,DUNES>>
		<CANT-REACH ,DUNES>)
	       (<VERB? CLIMB CLIMB-UP>
		<COND (<EQUAL? ,HERE ,DUNETOP>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,CANALVIEW-MALL ,DONALD-DOCK>
		       <DO-WALK ,P?UP>)
		      (T
		       <TELL "This dune is too steep." CR>)>)
	       (<AND <VERB? CLIMB-DOWN>
		     <EQUAL? ,HERE ,DUNETOP>>
		<DO-WALK ,P?DOWN>)>>

<ROOM CANAL
      (LOC ROOMS)
      (DESC "Martian Canal")
      (NORTH SORRY "If you want to jump in the canal, say so.")
      (NE SORRY "If you want to jump in the canal, say so.")
      (EAST SORRY "If you want to jump in the canal, say so.")
      (SE SORRY "If you want to jump in the canal, say so.")
      (SOUTH SORRY "If you want to jump in the canal, say so.")
      (SW SORRY "If you want to jump in the canal, say so.")
      (WEST SORRY "If you want to jump in the canal, say so.")
      (NW SORRY "If you want to jump in the canal, say so.")
      (FLAGS ONBIT)
      (GLOBAL CANAL-OBJECT DOCK-OBJECT WATER DUNES SIGN BUOY)
      (ACTION CANAL-F)
      ;(THINGS <PSEUDO (RED BUOY BUOY-F)
		      (WARNING BUOY BUOY-F)
		      (SWAYING BUOY BUOY-F)
		      (ROYAL BARGE BARGE-FROM-CANAL-F)
		      (WOODEN BARGE BARGE-FROM-CANAL-F)
		      (ORANGE BUTTON BARGE-FROM-CANAL-F)
		      (PURPLE BUTTON BARGE-FROM-CANAL-F)>)>

<ROUTINE CANAL-F (RARG "AUX" NUM DOCK-DIR)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<SET NUM <CANAL-LOC>>
		<SET DOCK-DIR <SET-DOCK-DIR .NUM>>
		<TELL
"The " D <LOC ,PROTAGONIST> " rocks gently in the current of a wide canal.">
		<COND (<OR <EQUAL? .NUM 1 7 15>
			   <EQUAL? .NUM -1 6>
			   <AND <EQUAL? .NUM 10>
				<IN? ,PROTAGONIST ,RAFT>>>
		       <TELL " A dock is ">
		       <COND (<IN? ,PROTAGONIST ,RAFT>
			      <TELL "close enough to grab">)
			     (T
			      <TELL "visible">)>
		       <TELL " on the " .DOCK-DIR "ern shore.">)
		      (<EQUAL? .NUM 10>
		       <TELL " There are docks on both banks.">)
		      (T
		       <TELL " The banks of the canal are steep and sandy.">)>
		<COND (<BARGE-VISIBLE-AT-DOCK>
		       <TELL " A " 'BARGE " is moored to the dock">
		       <COND (<EQUAL? .NUM 10>
			      <TELL " on the ">
			      <COND (<IN? ,BARGE ,ABANDONED-DOCK>
				     <TELL "we">)
				    (T
				     <TELL "ea">)>
			      <TELL "stern shore">)>
		       <TELL ".">)>
		<COND (<EQUAL? .NUM 5 12 29>
		       <TELL
" A smaller canal flows diagonally into this one, and the
channel widens slightly to accommodate the heavier flow.">)
		      (<EQUAL? .NUM 9 10>
		       <TELL " Just ">
		       <COND (<EQUAL? .NUM 9>
			      <TELL "ahead">)
			     (T
			      <TELL "behind">)>
		       <TELL ", the canal curves sharply to the ">
		       <COND (<EQUAL? .NUM 9>
			      <TELL "south.">)
			     (T
			      <TELL "west.">)>)>
		<COND (<EQUAL? .NUM 4 5 8>
		       <TELL
" Sculpted reddish " 'DUNES " rise into view beyond the banks of the canal.">)>
		<COND (<PROB 15>
		       <TELL
" The dark clouds of a sandstorm are visible on the horizon.">)>
		<COND (<EQUAL? .NUM 15>
		       <TELL
" A red warning buoy is anchored nearby. A sign atop the swaying
buoy shows a skull and crossbones.">)>
		<COND (<AND <G? .NUM 12>
			    <L? .NUM 32>>
		       <COND (<EQUAL? .NUM 31>
			      <TELL CR "   ">
			      <DESCRIBE-POWER-TRANSMITTER 31>
			      <COND (<NOT <FSET? ,POWER-TRANSMITTER ,TOUCHBIT>>
				     <FSET ,POWER-TRANSMITTER ,TOUCHBIT>
				     <TELL CR
"   As the " D <LOC ,PROTAGONIST> " passes through the beam, you feel a
tingling from every cell in " 'YOUR-BODY ".">)>)
			     (T
			      <TELL " ">
			      <DESCRIBE-POWER-TRANSMITTER .NUM>)>)>
		<RTRUE>)>>

<OBJECT BARGE-FROM-RAFT
      (LOC CANAL)
      (DESC "royal barge")
      (SYNONYM BARGE BUTTONS)
      (ADJECTIVE ROYAL WOODEN)
      (GENERIC GENERIC-BARGE-F)
      (FLAGS NDESCBIT)
      (ACTION BARGE-FROM-RAFT-F)>

<ROUTINE BARGE-FROM-RAFT-F ()
	 <COND (<NOT <BARGE-VISIBLE-AT-DOCK>>
		<CANT-SEE ,PRSO>)
	       (<TOUCHING? ,PRSO>
		<CANT-REACH ,PRSO>)>>

<ROUTINE BARGE-VISIBLE-AT-DOCK ("AUX" NUM)
	 <SET NUM <CANAL-LOC>>
	 <COND (<OR <AND <EQUAL? .NUM 1>
			 <IN? ,BARGE ,ROYAL-DOCKS>>
		    <AND <EQUAL? .NUM 6>
			 <IN? ,BARGE ,BABY-DOCK>>
		    <AND <EQUAL? .NUM 7>
			 <IN? ,BARGE ,DONALD-DOCK>>
		    <AND <EQUAL? .NUM 10>
			 <EQUAL? <LOC ,BARGE> ,MY-KIND-OF-DOCK
				 ,ABANDONED-DOCK>>
		    <AND <EQUAL? .NUM 15>
			 <IN? ,BARGE ,WATTZ-UPP-DOCK>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT BUOY
      (LOC LOCAL-GLOBALS)
      (DESC "red warning buoy")
      (SYNONYM BUOY)
      (ADJECTIVE SWAYING RED WARNING)
      (FLAGS NDESCBIT)
      (ACTION BUOY-F)>

<ROUTINE BUOY-F ("AUX" NUM)
	 <SET NUM <CANAL-LOC>>
	 <COND (<AND <NOT <EQUAL? .NUM 15>>
		     <NOT <EQUAL? ,HERE ,WATTZ-UPP-DOCK>>>
		<CANT-SEE ,BUOY>)
	       (<VERB? READ EXAMINE>
		<PERFORM ,V?READ ,SIGN>
		<RTRUE>)
	       (<VERB? TAKE OPEN>
		<TELL ,YOU-CANT>
		<COND (<VERB? TAKE>
		       <TELL "take">)
		      (T
		       <TELL "open">)>
		<TELL " a buoy! Where'd you get such a silly idea?" CR>)
	       (<TOUCHING? ,BUOY>
		<CANT-REACH ,BUOY>)>>

<ROUTINE I-CANAL ("AUX" (NUM 0) (MOVED <>))
	 <COND (<AND <NOT <IN? ,BARGE ,CANAL>>
		     <NOT <IN? ,RAFT ,CANAL>>>
		<DEQUEUE I-CANAL>
		<RFALSE>)>
	 ;<COND (,DEBUG
		<COND (<IN? ,BARGE ,CANAL>
		       <TELL
"[Barge is in canal. BARGE-LOC-NUM = " N ,BARGE-LOC-NUM ".]" CR>)>
		<COND (<IN? ,RAFT ,CANAL>
		       <TELL
"[Raft is in canal. RAFT-LOC-NUM = " N ,RAFT-LOC-NUM ".]" CR>)>)>
	 <COND (<IN? ,BARGE ,CANAL>
		<COND (<OR ,BARGE-UNDER-POWER
			   ,BARGE-WAIT>
		       <COND (<IN? ,PROTAGONIST ,BARGE>
			      <SET MOVED T>)>
		       <SETG BARGE-WAIT <>>
		       <COND (<AND ,RAFT-HELD
				   <IN? ,RAFT ,CANAL>
				   <IN? ,PROTAGONIST ,BARGE>>
			      <SETG RAFT-LOC-NUM <+ ,RAFT-LOC-NUM 1>>)>
		       <SETG BARGE-LOC-NUM <+ ,BARGE-LOC-NUM 1>>)
		      (T
		       <SETG BARGE-WAIT T>)>)>
	 <COND (<AND <IN? ,RAFT ,CANAL>
		     <NOT ,RAFT-HELD> ;"barge clause, above, updates raft loc">
		<COND (,RAFT-WAIT
		       <COND (<IN? ,PROTAGONIST ,RAFT>
			      <SET MOVED T>)>
		       <SETG RAFT-WAIT <>>
		       <SETG RAFT-LOC-NUM <+ ,RAFT-LOC-NUM 1>>)
		      (T
		       <SETG RAFT-WAIT T>)>)>
	 <SET NUM <CANAL-LOC>>
	 <COND (<AND <EQUAL? .NUM 31>
		     <NOT <QUEUED? ,I-ION-DEATH>>>
		<COND (<IN? ,SIDEKICK <LOC ,PROTAGONIST>>
		       <SETG SIDEKICK-IONIZED T>)>
		<QUEUE I-ION-DEATH 6>)>
	 <COND (<L? .NUM 17>
		<PUTP ,POWER-TRANSMITTER ,P?SDESC "metallic glint">)
	       (<G? .NUM 30>
		<PUTP ,POWER-TRANSMITTER ,P?SDESC "giant rusted structure">)
	       (T
		<PUTP ,POWER-TRANSMITTER ,P?SDESC "metal structure">)>
	 <COND (<NOT <EQUAL? ,HERE ,CANAL>>
		<COND (<G? ,BARGE-LOC-NUM 36>
		       <MOVE ,BARGE ,ICY-DOCK>
		       <COND (,RAFT-HELD
			      <MOVE ,RAFT ,ICY-DOCK>)>)>
		<COND (<G? ,RAFT-LOC-NUM 36>
		       <MOVE ,RAFT ,ICY-DOCK>)>
		<BARGE-DOCKS>
		<RFALSE>)
	       (<NOT .MOVED>
		<RFALSE>)>
	 <TELL "   The " D <LOC ,PROTAGONIST> " ">
	 <COND (<EQUAL? .NUM 10>
		<COND (<AND ,BARGE-UNDER-POWER
			    <IN? ,PROTAGONIST ,BARGE>>
		       <SETG NEARER-DOCK ,MY-KIND-OF-DOCK>
		       <TELL "chugs quickly">)
		      (T
		       <SETG NEARER-DOCK ,ABANDONED-DOCK>
		       <TELL "drifts slowly">)>
		<TELL " around the bend, ending up near the ">
		<COND (<AND ,BARGE-UNDER-POWER
			    <IN? ,PROTAGONIST ,BARGE>>
		       <TELL "ea">)
		      (T
		       <TELL "we">)>
		<TELL "stern bank of">)
	       (T
		<COND (<AND ,BARGE-UNDER-POWER
			    <IN? ,PROTAGONIST ,BARGE>>
		       <TELL "barges">)
		      (T
		       <TELL "drifts">)>
		<TELL " further down">)>
	 <TELL " the canal.">
	 <COND (<EQUAL? .NUM 36>
		<TELL
" A wide dock spans the canal to the south. The " D <LOC ,PROTAGONIST>
" butts up against it" ,PINNED CR>
		<COND (<AND <IN? ,PROTAGONIST ,RAFT>
			    <IN? ,BARGE ,CANAL>
			    <EQUAL? ,BARGE-LOC-NUM 36>>
		       <MOVE ,BARGE ,ICY-DOCK>)
		      (<AND <IN? ,PROTAGONIST ,BARGE>
			    <IN? ,RAFT ,CANAL>
			    <EQUAL? ,RAFT-LOC-NUM 36>>
		       <MOVE ,BARGE ,ICY-DOCK>)>
		<MOVE <LOC ,PROTAGONIST> ,ICY-DOCK>
		<GOTO <LOC ,PROTAGONIST>>
		<RTRUE>)>
	 <COND (<OR <EQUAL? ,HAND-COVER ,EYES>
		    <FSET? ,EYES ,MUNGBIT>>
		<TELL " " ,YOU-CANT "see a thing, of course." CR>)
	       (T
		<CRLF> <CRLF>
	 	<DESCRIBE-ROOM>)>
	 <COND (<AND <EQUAL? ,BARGE-LOC-NUM ,RAFT-LOC-NUM>
		     <IN? ,RAFT ,CANAL>
		     <IN? ,BARGE ,CANAL>>
		<COND (<IN? ,PROTAGONIST ,RAFT>
		       <BARGE-F ,M-OBJDESC>
		       <CRLF>)
		      (T
		       <RAFT-F ,M-OBJDESC>
		       <CRLF>)>)>
	 <BARGE-DOCKS T>
	 <RTRUE>>

<OBJECT POWER-TRANSMITTER
	(LOC CANAL)
	(SDESC "")
	(SYNONYM GLINT STRUCTURE MACHINE TOWER)
	(ADJECTIVE LARGE METAL METALLIC POWER LOOMING RUSTED MARTIAN)
	(FLAGS NDESCBIT)
	(GENERIC GENERIC-MACHINE-F)
	(ACTION POWER-TRANSMITTER-F)>

<ROUTINE POWER-TRANSMITTER-F ("AUX" (NUM 0))
	 <SET NUM <CANAL-LOC>>
	 <COND (<OR <G? .NUM 31>
		    <L? .NUM 13>>
		<CANT-SEE ,POWER-TRANSMITTER>)
	       (<VERB? EXAMINE>
		<DESCRIBE-POWER-TRANSMITTER .NUM>
		<CRLF>)
	       (<TOUCHING? ,POWER-TRANSMITTER>
		<CANT-REACH ,POWER-TRANSMITTER>)>>

<ROUTINE DESCRIBE-POWER-TRANSMITTER (NUM)
	 <COND (<EQUAL? .NUM 31>
		<TELL
"The " D <LOC ,PROTAGONIST> " is now passing the metal structure that has been
looming closer for the last hour. Its size and power are overwhelming; a relic
of Martian technology at its height. Vacuum tubes the size of telephone booths
produce power that was once beamed all over Mars. But now, in the twilight of
the planet's civilization, the machine's base has rusted away. The massive
tower now shoots its ion power beam uselessly across the canal, into the sand
of the opposite bank.">)
	       (<L? .NUM 17>
		<TELL "You spy a metallic glint, far ahead.">)
	       (<G? .NUM 27>
		<TELL
"A massive machine, unlike anything you've ever seen, rises from
the shore, looming closer with each passing minute.">)
	       (T
		<TELL
"A metal structure, glinting in the weak Martian sunlight,
is visible at the edge of the canal">
		<COND (<L? .NUM 21>
		       <TELL ", but far, far ahead.">)
		      (<L? .NUM 24>
		       <TELL " far ahead of you.">)
		      (T
		       <TELL ", a bit too far to make out any details.">)>)>>

<CONSTANT ION-TABLE
	<TABLE
	 "" ;"zero slot"
	 "slight"
	 "worsening"
	 "splitting"
	 "fantastically unbelievable ultra-awesome migraine">>

<GLOBAL ION-DEATH-COUNTER 0>

<GLOBAL SIDEKICK-IONIZED <>>

<ROUTINE I-ION-DEATH ()
	 <SETG ION-DEATH-COUNTER <+ ,ION-DEATH-COUNTER 1>>
	 <TELL "   ">
	 <COND (<G? ,ION-DEATH-COUNTER 4>
		<JIGS-UP
"Your anatomy, in absorbing a dose of superionized energy in translethal
levels, has ultimately equalized this submolecular environmental imbalance
by fulminating a cataclysmic exothermic reaction. Or to put it in lay
terms, you've just blown up.">)
	       (T
		<COND (<FSET? ,POWER-TRANSMITTER ,MUNGBIT>
		       <QUEUE I-ION-DEATH 2> ;"so you can't win with headache")
		      (T
		       <QUEUE I-ION-DEATH 6>)>
		<V-DIAGNOSE>
		<COND (<AND ,SIDEKICK-IONIZED
			    <VISIBLE? ,SIDEKICK>
			    <EQUAL? ,ION-DEATH-COUNTER 3>>
		       <TELL
"   " D ,SIDEKICK " says, \"My head is pounding! I wish we
had some aspirin.\"" CR>)>
		<RTRUE>)>>

<ROUTINE BARGE-DOCKS ("OPTIONAL" (CALLED-BY-INT <>) "AUX" DOCK-ROOM DOCK-DIR)
	 <COND (<AND ,MOORING-ON
		     <IN? ,BARGE ,CANAL>
		     <OR <EQUAL? ,BARGE-LOC-NUM 7 10 15>
			 <EQUAL? ,BARGE-LOC-NUM 1 6>>>
		<COND (.CALLED-BY-INT
		       <TELL "  ">)>
	 	<SET DOCK-ROOM <SET-DOCK-ROOM ,BARGE-LOC-NUM>>
	 	<SET DOCK-DIR <SET-DOCK-DIR ,BARGE-LOC-NUM>>
	 	<COND (<IN? ,BARGE ,HERE>
		       <TELL
" The barge drifts toward the dock on the " .DOCK-DIR
"ern shore, butting against it with a loud \"clank.\"">
		       <COND (<IN? ,PROTAGONIST ,BARGE>
			      <CRLF> ;"because room desc comes next")>
		       <CRLF>)>
		<MOVE ,BARGE .DOCK-ROOM>
	 	<COND (<IN? ,PROTAGONIST ,BARGE>
		       <COND (,RAFT-HELD
		       	      <MOVE ,RAFT .DOCK-ROOM>)>
		       <GOTO ,BARGE>)>		
	 	<SETG BARGE-WAIT <>>
		<RTRUE>)
	       (T
	 	<RFALSE>)>>

<ROUTINE SET-DOCK-ROOM (NUM)
	 <COND (<EQUAL? .NUM -1>
		<RETURN ,HICKORY-AND-DICKORY-DOCK>)
	       (<EQUAL? .NUM 1>
		<RETURN ,ROYAL-DOCKS>)
	       (<EQUAL? .NUM 6>
		<RETURN ,BABY-DOCK>)
	       (<EQUAL? .NUM 7>
		<RETURN ,DONALD-DOCK>)
	       (<EQUAL? .NUM 15>
		<RETURN ,WATTZ-UPP-DOCK>)
	       (<EQUAL? ,NEARER-DOCK ,MY-KIND-OF-DOCK>
		<RETURN ,MY-KIND-OF-DOCK>)
	       (T
		<RETURN ,ABANDONED-DOCK>)>>

<ROUTINE SET-DOCK-DIR (NUM)
	 <COND (<EQUAL? .NUM -1 1 7>
		<RETURN "south">)
	       (<EQUAL? .NUM 6>
		<RETURN "north">)
	       (<EQUAL? .NUM 15>
		<RETURN "west">)
	       (<EQUAL? ,NEARER-DOCK ,MY-KIND-OF-DOCK>
		<RETURN "east">)
	       (T
		<RETURN "west">)>>

<ROOM BABY-DOCK
      (LOC ROOMS)
      (DESC "Baby Dock")
      (LDESC
"This tiny dock, partly buried by drifting sand, extends south into the canal.
A break in the sand forms a trail to the north.")
      (SOUTH SORRY "If you want to jump in the canal, say so.")
      (SE SORRY "If you want to jump in the canal, say so.")
      (SW SORRY "If you want to jump in the canal, say so.")
      (NORTH TO AMONG-THE-DUNES)
      (FLAGS ONBIT)
      (GLOBAL CANAL-OBJECT DOCK-OBJECT WATER DUNES)>

<ROOM AMONG-THE-DUNES
      (LOC ROOMS)
      (DESC "Among the Dunes")
      (LDESC
"You are in a tiny basin, protected by dunes from the fierce Martian winds.
The dunes are impassable, except to the south.")
      (SOUTH TO BABY-DOCK)
      (FLAGS RLANDBIT ONBIT NARTICLEBIT)
      (GLOBAL DUNES)
      (ACTION AMONG-THE-DUNES-F)>

<GLOBAL WIFE-NUMBER 0>

<ROUTINE AMONG-THE-DUNES-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,AMONG-THE-DUNES ,TOUCHBIT>>>
		<REPEAT () ;"last digit can't be zero -- number gets reversed"
			<SETG WIFE-NUMBER <+ 100 <RANDOM 8270>>>
			<COND (<AND <NOT <EQUAL? <MOD ,WIFE-NUMBER 10> 0>>
				    <NOT <PALINDROME-NUMBER? ,WIFE-NUMBER>>>
			       <RETURN>)>>)>>

<ROUTINE PALINDROME-NUMBER? (NUM)
	 <COND (<G? .NUM 999> ;"for four digit numbers, this returns true
				anytime the first and last digit are equal;
				it doesn't bother checking the middle pair"
		<COND (<EQUAL? </ .NUM 1000> <MOD .NUM 10>>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? </ .NUM 100> <MOD .NUM 10>>
		<RTRUE>)
	       (T
		<RFALSE>)>> 

<OBJECT LIP-BALM
	(LOC AMONG-THE-DUNES)
	(DESC "stick of lip balm")
	(NO-T-DESC "sick of lip balm")
	(FDESC
"The alien may have died of acute chapped lips (a perennial problem in the
arid Martian climate). If so, it was a sudden death, for the lip balm near
the body is completely unused.")
	(SYNONYM STICK BALM CHAPSTICK GLOSS)
	(ADJECTIVE LIP SICK)
	(FLAGS TAKEBIT)
	(SIZE 2)
	(ACTION LIP-BALM-F)>

<ROUTINE LIP-BALM-F ()
	 <COND (<FSET? ,LIP-BALM ,UNTEEDBIT>
		<RFALSE>)
	       (<OR <AND <VERB? PUT-ON>
			 <PRSI? ,MOUTH>>
		    <VERB? WEAR>>
		<COND (<FSET? ,LIP-BALM ,WORNBIT>
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <MOVE ,LIP-BALM ,PROTAGONIST>
		       <FSET ,LIP-BALM ,WORNBIT>
		       <FSET ,MOUTH ,MUNGBIT>
		       <TELL
"You coat your lips with the glistening balm, using up the whole stick." CR>)>)
	       (<AND <VERB? EXAMINE>
		     <FSET? ,LIP-BALM ,WORNBIT>>
		<PERFORM-PRSA ,MOUTH>
		<RTRUE>)
	       (<AND <VERB? REMOVE CLEAN>
		     <FSET? ,LIP-BALM ,WORNBIT>>
		<MOVE ,LIP-BALM ,LOCAL-GLOBALS>
		<FCLEAR ,MOUTH ,MUNGBIT>
		<TELL "You wipe away the lip balm." CR>)>>

<OBJECT CODED-MESSAGE
	(LOC AMONG-THE-DUNES)
	(DESC "coded message")
	(FDESC
"Lying next to the body, partially buried in the sand,
is a strange coded message.")
	(SYNONYM MESSAGE CODE)
	(ADJECTIVE STRANGE CODED)
	(FLAGS TAKEBIT READBIT BURNBIT)
	(SIZE 2)
	(ACTION CODED-MESSAGE-F)>

<ROUTINE CODED-MESSAGE-F ()
	 <COND (<VERB? READ EXAMINE>
;"YOUR MISSION IS TO CONTACT (WIFE) (HUSBAND) NUMBER (N) OF THE
(SULTAN) (SULTANESS) AND GET THE SECRET MAP --
IDENTIFY YOURSELF TO (HIM) (HER) BY ASKING (HIM) (HER) TO KISS YOUR KNEECAPS"
;"to translate, replace every letter with the letter three before it --
D becomes A, E becomes B, and so forth. Then reverse the entire note."
		<TELL "VSDFHHQN UXRB VVLN RW ">
		<COND (,MALE
		       <TELL "UH">)
		      (T
		       <TELL "PL">)>
		<TELL "K JQLNVD BE ">
		<COND (,MALE
		       <TELL "UH">)
		      (T
		       <TELL "PL">)>
		<TELL "K RW IOHVUXRB BILWQHGL -- SDP WHUFHV HKW WHJ GQD ">
		<COND (<NOT ,MALE>
		       <TELL "VVH">)>
		<TELL "QDWOXV HKW IR ">
		<REVERSE-NUMBER ,WIFE-NUMBER>
		<TELL " UHEPXQ ">
		<COND (,MALE
		       <TELL "HILZ">)
		      (T
		       <TELL "GQDEVXK">)>
		<TELL " WFDWQRF RW VL QRLVVLP UXRB" CR>)>>

<ROUTINE REVERSE-NUMBER (NUM)
	 <REPEAT ()
		 <PRINTN <MOD .NUM 10>>
		 <SET NUM </ .NUM 10>>
		 <COND (<EQUAL? .NUM 0>
			<RETURN>)>>>

<OBJECT MESSENGER
	(LOC AMONG-THE-DUNES)
	(DESC "dead alien")
	(FDESC
"A strange alien, probably a member of one of the ancient warrior
races of Mars, lies dead at the base of a dune.")
	(SYNONYM ALIEN SPY BODY)
	(ADJECTIVE STRANGE ALIEN DEAD)
	(ACTION MESSENGER-F)>

<ROUTINE MESSENGER-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "It's dead. Very dead." CR>)
	       (<VERB? FUCK KISS>
		<TELL
"Is there even a word for this sort of perverse behavior? Necro-xeno-philia?
Xeno-necro-philia? Grosso-sicko-philia?" CR>)
	       (<AND <VERB? PUT-ON>
		     <PRSO? ,LIP-BALM>>
		<TELL "Too late." CR>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)
	       (<VERB? ALARM>
		<TELL "This guy's not resting, he's deceased!" CR>)>>

<ROOM DONALD-DOCK
      (LOC ROOMS)
      (DESC "Donald Dock")
      (LDESC
"This dock, on the south shore of the canal, is named after Don Donald, the
first resident of Mars. There are no paths leading inland, but a tall dune
to the south is less steep than the others.")
      (NORTH SORRY "If you want to jump in the canal, say so.")
      (NE SORRY "If you want to jump in the canal, say so.")
      (NW SORRY "If you want to jump in the canal, say so.")
      (SOUTH TO DUNETOP)
      (UP TO DUNETOP)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CANAL-OBJECT DOCK-OBJECT WATER DUNES)>

<ROOM DUNETOP
      (LOC ROOMS)
      (DESC "Dunetop")
      (LDESC
"From this vantage, you can see the canal curving south, a bit downstream from
here. Just after this bend, two docks flank the canal: an opulent dock on the
east bank, and a dilapidated one on the closer shore.|
   You could slide down the dune to the north or the east.")
      (NORTH TO DONALD-DOCK)
      (EAST TO CANALVIEW-MALL)
      (DOWN SORRY "East or north?")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL DUNES CANAL-OBJECT DOCK-OBJECT)
      (ACTION DUNETOP-F)>

<ROUTINE DUNETOP-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <EQUAL? ,TITS-COUNTER 0>>
		<QUEUE I-TITS -1>)>>

<GLOBAL TITS-COUNTER 0>

<ROUTINE I-TITS ()
	 <SETG TITS-COUNTER <+ ,TITS-COUNTER 1>>
	 <COND (<NOT <EQUAL? ,NAUGHTY-LEVEL 2>>
		<DEQUEUE I-TITS>
		<RFALSE>)
	       (<EQUAL? ,TITS-COUNTER 4>
		<TELL
"   [A warning for any Jerry Falwell groupies who are miraculously still
playing: we'll be using the word \"tits\" in five turns or so. Please
consult the manual for the proper way to stop playing.]" CR>)
	       (<EQUAL? ,TITS-COUNTER 7>
		<TELL
"   [Only a few turns until the \"tits\" reference! Use QUIT now if
you might be offended!]" CR>)
	       (<EQUAL? ,TITS-COUNTER 9>
		<TELL
"   [Last warning! The word \"tits\" will appear in the very next turn!
This is your absolutely last chance to avoid seeing \"tits\" used!!!]" CR>)
	       (<EQUAL? ,TITS-COUNTER 10>
		<DEQUEUE I-TITS>
		<TELL
"   A hyperdimensional traveller suddenly appears out of thin air.
\"My sister has tremendous breasts,\" says the traveller and, without
further explanation, vanishes">
		<COND (<NOT <FSET? ,NOSE ,MUNGBIT>>
		       <TELL
", leaving only a vague trace of interdimensional ozone">)>
		<TELL ".|
   [Oh, regarding the use of \"tits,\" we changed our mind at the last minute.
Everyone agreed it was too risque.]" CR>)
	       (T
		<RFALSE>)>>

<ROOM ABANDONED-DOCK
      (LOC ROOMS)
      (DESC "Abandoned Dock")
      (LDESC
"This dock is in remarkably good shape, considering that it hasn't been painted
in fifteen thousand years. A wide canal, flowing south, lies to the east, and
an opening between the dunes leads west.")
      (WEST TO CANALVIEW-MALL)
      (EAST SORRY "If you want to jump in the canal, say so.")
      (NE SORRY "If you want to jump in the canal, say so.")
      (SE SORRY "If you want to jump in the canal, say so.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CANAL-OBJECT DOCK-OBJECT WATER DUNES)>

<ROOM CANALVIEW-MALL
      (LOC ROOMS)
      (DESC "Canalview Mall")
      (LDESC
"As with all Martian civilization, this once-fashionable shopping center has
fallen upon hard times; the only store to have endured the fifteen-millenia
recession lies to the south. The canal is still as visible as it was when
scheming marketeers misnamed the mall generations ago -- in other words, not
at all. A path leads east, and a dune to the west seems mountable.")
      (EAST TO ABANDONED-DOCK)
      (WEST TO DUNETOP)
      (UP TO DUNETOP)
      (SOUTH TO EXIT-SHOP)
      (GLOBAL DUNES)
      (FLAGS RLANDBIT ONBIT)
      ;(THINGS <PSEUDO (<> STORE OUTSIDE-SHOP-F)
		      (<> SHOP OUTSIDE-SHOP-F)>)>

<OBJECT OUTSIDE-SHOP
      (LOC CANALVIEW-MALL) 
      (DESC "shop")
      (SYNONYM SHOP STORE)
      (ADJECTIVE EXIT)
      (FLAGS NDESCBIT)
      (ACTION OUTSIDE-SHOP-F)>

<ROUTINE OUTSIDE-SHOP-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<DO-WALK ,P?SOUTH>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<TELL ,LOOK-AROUND>)>>

<ROUTINE INSIDE-SHOP-F ()
	 <COND (<VERB? DISEMBARK LEAVE EXIT>
		<DO-WALK ,P?NORTH>)
	       (<VERB? BOARD WALK-TO ENTER>
		<TELL ,LOOK-AROUND>)
	       (<VERB? SEARCH>
		<PERFORM-PRSA ,DUST>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<V-LOOK>)>>

<ROOM EXIT-SHOP
      (LOC ROOMS)
      (DESC "Exit Shop")
      (LDESC
"This store is in good shape only relative to the other shops in the mall; for
example, the last time it was vacuumed, humans were just inventing writing. The
dust nearly covers the proprietor, who sits forlornly in the corner beneath a
faded sign. An exit is barely visible through the dust to the north.")
      (NORTH TO CANALVIEW-MALL)
      (OUT TO CANALVIEW-MALL)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL SIGN)
      (ACTION EXIT-SHOP-F)
      ;(THINGS <PSEUDO (<> STORE INSIDE-SHOP-F)
		      (<> SHOP INSIDE-SHOP-F)>)>

<OBJECT INSIDE-SHOP
      (LOC EXIT-SHOP) 
      (DESC "shop")
      (SYNONYM STORE SHOP)
      (ADJECTIVE EXIT)
      (FLAGS NDESCBIT)
      (ACTION INSIDE-SHOP-F)>

<ROUTINE EXIT-SHOP-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,PROPRIETOR ,TOUCHBIT>>>
		<FSET ,PROPRIETOR ,TOUCHBIT>
		<TELL
"   " ,PROPRIETOR-STIRS "Don't get many customers these days, since they
abandoned the dock. In fact, you're only the third in the last hundred and
fifty centuries.\" He slips back into a drowse." CR>)>>

<OBJECT PROPRIETOR
	(LOC EXIT-SHOP)
	(DESC "proprietor")
	(SYNONYM PROPRIETOR OWNER)
	(ADJECTIVE FORLORN DROWSY)
	(FLAGS ACTORBIT NDESCBIT)
	(ACTION PROPRIETOR-F)>

<ROUTINE PROPRIETOR-F ()
	 <COND (<EQUAL? ,PROPRIETOR ,WINNER>
		<COND (<OR <AND <VERB? WHAT>
				<PRSO? ,LGOP>>
			   <AND <VERB? TELL-ABOUT>
				<PRSO? ,ME>
				<PRSI? ,LGOP>>>
		       <TELL
"\"A bunch of deadbeats! Never pay their bills -- I've had to
repossess God knows how many exits!\"" CR>)
		      (T
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?ALARM ,PROPRIETOR>
		       <STOP>)>)
	       (<VERB? ALARM>
		<TELL
,PROPRIETOR-STIRS "E" ,BOUGHT-AND-SOLD ",\" he
mumbles, \"e" ,BOUGHT-AND-SOLD ".\" A moment later, he nods off." CR>)
	       (<OR <VERB? BARTER-WITH>
		    <AND <VERB? ASK-FOR>
			 <PRSI? ,EXIT-OBJECT>>>
		<PERFORM ,V?BUY ,EXIT-OBJECT>
		<RTRUE>)
	       (<AND <VERB? GIVE SHOW>
		     <PRSO? ,TEN-MARSMID-COIN>>
		<TELL
"\"Humph? Eh, oh, sorry, no change for a ten. And the Mall Merchants
Association would have my license if I accepted an overpayment. Try again
in a year ... or two ... grunt snore.\"" CR>)
	       (<AND <VERB? GIVE SHOW>
		     <PRSO? ,ONE-MARSMID-COIN>>
		<REMOVE ,ONE-MARSMID-COIN>
		<MOVE ,TUBE ,DUST>
		<INCREMENT-SCORE 5 12>
		<TELL
"The proprietor slowly focuses one eye on the coin. \"Not much in stock
these days,\" he explains. \"My supplier went bankrupt ninety thousand years
ago.\" He takes the coin and starts to hand you a cardboard tube, but his
eye drifts out of focus again, and he drops it wearily into the dust." CR>)
	       (<AND <VERB? GIVE SHOW>
		     <PRSO? ,FLEXIBLE-HOLE>>
		<TELL
,PROPRIETOR-STIRS "Don't think I could sell such an out-of-date model. No one
wants exits anymore, anyway. Don't know why I bother ... to stay in business
... zzzz.\"" CR>)>>

<OBJECT EXIT-OBJECT
	(LOC GLOBAL-OBJECTS)
	(DESC "exit")
	(SYNONYM EXIT EGRESS)
	(FLAGS VOWELBIT)
	(ACTION EXIT-OBJECT-F)>

<ROUTINE EXIT-OBJECT-F ()
	 <COND (<VERB? BUY>
		<COND (<EQUAL? ,HERE ,EXIT-SHOP>
		       <TELL "\"One marsmid, please, grunt snore zzz.\"" CR>)
		      (<FSET? ,EXIT-SHOP ,TOUCHBIT>
		       <TELL "This isn't an ">
		       <PRINTD ,EXIT-SHOP>
		       <TELL "!" CR>)
		      (T
		       <TELL "Buy an exit?!?!" CR>)>)
	       (<AND <VERB? BUY-WITH>
		     <PRSI? ,ONE-MARSMID-COIN ,TEN-MARSMID-COIN>>
		<PERFORM ,V?GIVE ,PRSI ,PROPRIETOR>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <IN? ,TUBE ,DUST>
		     <EQUAL? ,HERE ,EXIT-SHOP>>
		<TELL "It's lost in the dust." CR>)>>

<OBJECT DUST
	(LOC EXIT-SHOP)
	(DESC "dust")
	(SYNONYM DUST)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION DUST-F)>

<ROUTINE DUST-F ("AUX" (X <>))
	 <COND (<VERB? SEARCH REACH-IN DIG LOOK-INSIDE RAKE>
		<COND (<SET X <FIRST? ,DUST>>
		       <MOVE .X ,PROTAGONIST>
		       <THIS-IS-IT .X>
		       <TELL "You grasp" A .X "!" CR>)
		      (T
		       <TELL
"You sift through the dust but find nothing." CR>)>)
	       (<VERB? ENTER BOARD>
		<TELL "You're already up to your neck in dust." CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,DUST>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<VERB? CLEAN MOVE BLOW>
		<TELL "You'd need a plow to move this dust." CR>)>>

<OBJECT TUBE
	(DESC "tube")
	(NO-T-DESC "ube")
	(SYNONYM TUBE UBE)
	(ADJECTIVE CARDBOARD MAILING NARROW)
	(FLAGS CONTBIT SEARCHBIT TAKEBIT BURNBIT)
	(CAPACITY 2)>

<OBJECT FLEXIBLE-HOLE
	(LOC TUBE)
	(DESC "flexible black circle")
	(SYNONYM CIRCLE HOLE EXIT)
	(ADJECTIVE FLEXIBLE BLACK PORTABLE)
	(FLAGS TAKEBIT)
	(SIZE 1)
	(ACTION FLEXIBLE-HOLE-F)>

<ROUTINE FLEXIBLE-HOLE-F ("AUX" (SIDEKICK-VISIBLE <>))
	 <COND (<VERB? EXAMINE>
		<TELL
"The " 'FLEXIBLE-HOLE " looks just like a portable version of the
\"holes\" you've been encountering all over the solar system." CR>)
	       (<VERB? MEASURE>
		<TELL "The " D ,HOLE " is two feet across." CR>)
	       (<AND <VERB? REACH-IN TOUCH LOOK-INSIDE>
		     <IN? ,FLEXIBLE-HOLE ,TUBE>>
		<COND (<MEANT-OTHER-HOLE>
		       <RTRUE>)>
		<NOT-ON-GROUND ,FLEXIBLE-HOLE>)
	       (<VERB? REACH-IN TOUCH>
		<TELL ,HAND-DWINDLES>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,STARING-INTO-VOID>)
	       (<AND <VERB? PUT PUT-ON>
		     <PRSI? ,FLEXIBLE-HOLE>>
		<COND (<EQUAL? <LOC ,FLEXIBLE-HOLE> ,HERE ,RAFT ,BARGE>
		       <MOVE ,PRSO ,BOUDOIR>
		       <NON-DIMENSIONAL-JOURNEY>)
		      (<MEANT-OTHER-HOLE>
		       <RTRUE>)
		      (T
		       <NOT-ON-GROUND ,FLEXIBLE-HOLE>)>)
	       (<VERB? STAND-ON ENTER BOARD>
		<COND (<ULTIMATELY-IN? ,FLEXIBLE-HOLE>
		       <COND (<MEANT-OTHER-HOLE>
			      <RTRUE>)>
		       <TELL ,HOLDING-IT>)
		      (<AND <NOT <IN? ,PROTAGONIST ,HERE>>
			    <NOT <IN? ,FLEXIBLE-HOLE <LOC ,PROTAGONIST>>>>
		       <NOT-GOING-ANYWHERE>)
		      (<NOT <OR <EQUAL? <LOC ,FLEXIBLE-HOLE> ,HERE ,TREE-HOLE>
				<EQUAL? <LOC ,FLEXIBLE-HOLE> ,RAFT ,BARGE>>>
		       <COND (<MEANT-OTHER-HOLE>
			      <RTRUE>)>
		       <NOT-ON-GROUND ,FLEXIBLE-HOLE>)
		      (<AND ,SIDEKICK-TRIP-FLAG
			    <QUEUED? ,I-SIDEKICK-OUT-WINDOW>>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <COND (<VISIBLE? ,SIDEKICK>
			      <SET SIDEKICK-VISIBLE T>)>
		       <FALL-THROUGH-HOLE>
		       <GOTO ,BOUDOIR> ;"begin the endgame!"
		       <COND (<QUEUED? ,I-ION-DEATH> ;"radiated, you can't win"
			      <FSET ,POWER-TRANSMITTER ,MUNGBIT> ;"speed it up"
			      <QUEUE I-ION-DEATH 1>)>
		       <COND (.SIDEKICK-VISIBLE
			      <SETG HOLE-MOVE T>
			      <SIDEKICK-FOLLOWS-YOU>)>
		       <RTRUE>)>)>>

<ROUTINE MEANT-OTHER-HOLE () ;"if portable and nonportable hole both present"
	 <COND (<OR <AND <PRSO? ,FLEXIBLE-HOLE>
			 <EQUAL? <GET ,P-ADJW 0> ,W?FLEXIBLE ,W?PORTABLE>>
		    <AND <PRSI? ,FLEXIBLE-HOLE>
			 <EQUAL? <GET ,P-ADJW 1> ,W?FLEXIBLE ,W?PORTABLE>>>
		<RFALSE>)
	       (<NOT <GLOBAL-IN? ,HOLE ,HERE>>
		<RFALSE>)
	       (<PRSO? ,FLEXIBLE-HOLE>
		<PERFORM-PRSA ,HOLE ,PRSI>
		<RTRUE>)
	       (T
		<PERFORM-PRSA ,PRSO ,HOLE>
		<RTRUE>)>>

<ROOM MY-KIND-OF-DOCK
      (LOC ROOMS)
      (DESC "My Kinda Dock!")
      (SDESC "Now THIS Is My Kind of Dock")
      (LDESC
"If I owned a pier on a major Martian canal, I'd want it to look just like
this one -- handsome, well-proportioned, and amply endowed with jade and
ivory. I could probably live without the alabaster stair which leads up at
the end of the dock, to the east.")
      (WEST SORRY "If you want to jump in the canal, say so.")
      (SW SORRY "If you want to jump in the canal, say so.")
      (NW SORRY "If you want to jump in the canal, say so.")
      (EAST TO MAIN-HALL-OF-PALACE)
      (UP TO MAIN-HALL-OF-PALACE)
      (FLAGS ONBIT NARTICLEBIT)
      (GLOBAL CANAL-OBJECT DOCK-OBJECT WATER STAIRS LIGHT)
      ;(THINGS <PSEUDO (<> LIGHT UNIMPORTANT-THING-F)>)>

<ROOM MAIN-HALL-OF-PALACE
      (LOC ROOMS)
      (DESC "Main Hall of Palace")
      (LDESC
"A shaft of sunlight penetrates the stained glass windows and glistens off a
large reflecting pool, filling this huge entry hall with a seductive pattern
of tantalizing colors. Gleaming marble pillars rise majestically from the pool
to support a towering, arched roof. You are on a branching pathway suspended
above the pool, leading toward shadowy archways in every direction.")
      (NORTH SORRY
"As you approach, you realize that the archway in this direction is merely
a design on a solid wall.")
      (NE TO AUDIENCE-CHAMBER)
      (EAST TO ORIENTAL-GARDEN)
      (SE SORRY
"As you approach, you realize that the archway in this direction is merely
a design on a solid wall.")
      (SOUTH TO LAUNDRY-ROOM)
      (SW SORRY
"As you approach, you realize that the archway in this direction is merely
a design on a solid wall.")
      (WEST TO MY-KIND-OF-DOCK)
      (NW SORRY
"As you approach, you realize that the archway in this direction is merely
a design on a solid wall.")
      (DOWN TO MY-KIND-OF-DOCK)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL WATER STAIRS WINDOW LIGHT)
      ;(THINGS <PSEUDO (<> LIGHT UNIMPORTANT-THING-F)>)>

<ROOM LAUNDRY-ROOM
      (LOC ROOMS)
      (DESC "Laundry Room")
      (NORTH TO MAIN-HALL-OF-PALACE)
      (OUT TO MAIN-HALL-OF-PALACE)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (ACTION LAUNDRY-ROOM-F)
      ;(THINGS <PSEUDO (DIRTY LAUNDRY UNIMPORTANT-THING-F)
		      (<> BRA UNIMPORTANT-THING-F)
		      (<> BRAS UNIMPORTANT-THING-F)
		      (<> BRASSIERE UNIMPORTANT-THING-F)
		      (<> JOCKSTRAP UNIMPORTANT-THING-F)>)>

<OBJECT DIRTY-LAUNDRY
      (LOC LAUNDRY-ROOM)
      (DESC "laundry")
      (SYNONYM BRA BRAS BRASSIERE JOCKSTRAP LAUNDRY)
      (ADJECTIVE DIRTY)
      (FLAGS NDESCBIT)
      (ACTION UNIMPORTANT-THING-F)>

<ROUTINE LAUNDRY-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"One of the less pleasant aspects of running a palace is the sheer volume
of dirty laundry its occupants produce. Why, the 8379 ">
		<COND (,MALE
		       <TELL "wive">)
		      (T
		       <TELL "husband">)>
		<TELL
"s alone could keep a crew of cleaners sleepless. Add in the servants, cooks,
gardeners, stablehands, jesters, visiting nobles, brothers-in-law in virtual
permanent residence... Suffice it to say that there's ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL "quite">)
		      (T
		       <TELL "one hell of">)>
		<TELL
" a lot of dirty laundry here. You can barely see the exit to the north
through it all.">)>>

<OBJECT CLOTHES-PIN
	(LOC LAUNDRY-ROOM)
	(DESC "clothes pin")
	(NO-T-DESC "clohes pin")
	(FDESC
"Today must be drying day at the laundry, since there's only one clothes
pin left.")
	(SYNONYM PIN)
	(ADJECTIVE CLOTHES CLOHES)
	(FLAGS TAKEBIT BURNBIT)
	(SIZE 2)
	(ACTION CLOTHES-PIN-F)>

<ROUTINE CLOTHES-PIN-F ()
	 <COND (<FSET? ,CLOTHES-PIN ,UNTEEDBIT>
		<RFALSE>)
	       (<AND <VERB? PUT-ON PIN>
		     <PRSO? ,CLOTHES-PIN>>
		<COND (<NOT <PRSI? ,NOSE>>
		       <WASTES>)
		      (,GONE-APE
		       <TELL ,DEXTERITY>)
		      (<FSET? ,CLOTHES-PIN ,WORNBIT>
		       <TELL ,SENILITY-STRIKES>)
		      (T
		       <MOVE ,CLOTHES-PIN ,PROTAGONIST>
		       <FSET ,CLOTHES-PIN ,WORNBIT>
		       <FSET ,NOSE ,MUNGBIT>
		       <TELL "You pin your proboscis." CR>)>)
	       (<AND <VERB? PUT>
		     <PRSO? ,NOSE>>
		<PERFORM ,V?PUT-ON ,CLOTHES-PIN ,NOSE>
		<RTRUE>)
	       (<AND <VERB? TIE>
		     <EQUAL? ,P-PRSA-WORD ,W?ATTACH>
		     <PRSO? ,CLOTHES-PIN>
		     ,PRSI>
		<PERFORM ,V?PUT-ON ,CLOTHES-PIN ,PRSI>
		<RTRUE>)
	       (<AND <VERB? TAKE-WITH>
		     <EQUAL? ,P-PRSA-WORD ,W?HOLD>
		     <PRSO? ,NOSE>>
		<PERFORM ,V?PUT-ON ,CLOTHES-PIN ,NOSE>
		<RTRUE>)
	       (<AND <VERB? REMOVE TAKE-OFF>
		     <FSET? ,CLOTHES-PIN ,WORNBIT>>
		<COND (,GONE-APE
		       <PERFORM ,V?TAKE ,CLOTHES-PIN>
		       <RTRUE>)>
		<OPEN-EYES-AND-REMOVE-HANDS>
		<FCLEAR ,CLOTHES-PIN ,WORNBIT>
		<SENSE-AGAIN ,NOSE>)>>

<ROOM ORIENTAL-GARDEN
      (LOC ROOMS)
      (DESC "Oriental Garden")
      (LDESC
"These twisted trees and elegant footbridges are even more beautiful than the
gardens of the most lavish Fu Manchu films. Paths from the north, southeast,
and west meet at a large well of hand-carved stone in the center of the
garden.")
      (WEST TO MAIN-HALL-OF-PALACE)
      (NORTH TO AUDIENCE-CHAMBER)
      (SE TO BASE-OF-TOWER)
      (DOWN PER WELL-ENTER-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL TREE WELL-OBJECT)
      ;(THINGS <PSEUDO (LARGE WELL WELL-F)
		      (STONE WELL WELL-F)>)>

<OBJECT WELL-OBJECT
      (LOC LOCAL-GLOBALS)
      (DESC "well")
      (SYNONYM WELL)
      (ADJECTIVE LARGE STONE)
      (FLAGS NDESCBIT)
      (ACTION WELL-F)>

<ROUTINE WELL-ENTER-F ()
	 <TELL
"You climb down the well for a long distance. Near the bottom the
handholds end, so you">
	 <AND-SIDEKICK ,WELL-BOTTOM>
	 <TELL " leap the rest of the way, landing on" A ,HOLE ". ">
	 <SETG HERE ,WELL-BOTTOM>
	 <MOVE ,PROTAGONIST ,WELL-BOTTOM>
	 <SETG OHERE <>>
	 <PERFORM ,V?STAND-ON ,HOLE>
	 <RFALSE>>

<ROUTINE WELL-F ()
	 <COND (<VERB? LOOK-INSIDE REACH-IN>
		<TELL "Handholds lead downward!" CR>)
	       (<VERB? CLIMB-DOWN CLIMB CLIMB-UP BOARD ENTER>
		<COND (<EQUAL? ,HERE ,WELL-BOTTOM>
		       <DO-WALK ,P?UP>)
		      (T
		       <WELL-ENTER-F>)>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <PRSI? ,WELL-OBJECT>
		     <EQUAL? ,HERE ,ORIENTAL-GARDEN>>
		<MOVE ,PRSO ,BARGE>
		<COND (<PRSO? ,TORCH>
		       <TORCH-OFF>)>
		<TELL "It drops out of sight." CR>)>>

<OBJECT TOWER
	(LOC LOCAL-GLOBALS)
	(DESC "tower")
	(SYNONYM TOWER MINARET)
	(ADJECTIVE SLENDER TALL)
	(ACTION TOWER-F)>

<ROUTINE TOWER-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD CLIMB CLIMB-UP>
		<COND (<EQUAL? ,HERE ,BASE-OF-TOWER>
		       <DO-WALK ,P?UP>)
		      (<EQUAL? ,HERE ,MINARET>
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? DISEMBARK LEAVE EXIT>
		<COND (<EQUAL? ,HERE ,BASE-OF-TOWER>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?DOWN>)>)>>

<ROOM BASE-OF-TOWER
      (LOC ROOMS)
      (DESC "Base of Tower")
      (LDESC
"A slender tower protrudes magnificently above the palace grounds. A stair
winds up into the tower and an oriental garden spreads out to the northwest.")
      (UP TO MINARET)
      (NW TO ORIENTAL-GARDEN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL STAIRS TOWER)>

<ROOM MINARET
      (LOC ROOMS)
      (DESC "Minaret")
      (LDESC
"By standing erect at the parapet of this mighty tower, you command an exciting
view. Below, gardens and courtyards intermingle with the palace buildings,
forming a fertile oasis in the Martian desert. Off to the west, docks straddle
a deep canal. On the far shore, sand dunes lap at crumbling buildings. On the
top step of a winding stair is a black circle.")
      (DOWN TO BASE-OF-TOWER)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HOLE STAIRS TOWER CANAL-OBJECT WATER DUNES DOCK-OBJECT)
      (HOLE-DESTINATION CRAMPED-SPACE)>

<ROOM AUDIENCE-CHAMBER
      (LOC ROOMS)
      (DESC "Audience Chamber")
      (WEST PER AUDIENCE-CHAMBER-EXIT-F)
      (IN PER AUDIENCE-CHAMBER-EXIT-F)
      (SOUTH PER AUDIENCE-CHAMBER-EXIT-F)
      (SW PER AUDIENCE-CHAMBER-EXIT-F)
      (GLOBAL HAREM-OBJECT)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (ACTION AUDIENCE-CHAMBER-F)
      ;(THINGS <PSEUDO (<> HAREM HAREM-OBJECT-F)
		      (<> WIFE MATE-F)
		      (<> HUSBAND MATE-F)>)>

<OBJECT HAREM-OBJECT
      (LOC LOCAL-GLOBALS)
      (DESC "harem")
      (SYNONYM HAREM)
      (FLAGS NDESCBIT)
      (ACTION HAREM-OBJECT-F)>

<OBJECT WIFE-NOT-HERE
      (LOC AUDIENCE-CHAMBER)
      (DESC "wife")
      (SYNONYM WIFE)
      (FLAGS NDESCBIT)
      (ACTION WIFE-NOT-HERE-F)>

<OBJECT HUSBAND-NOT-HERE
      (LOC AUDIENCE-CHAMBER)
      (DESC "husband")
      (SYNONYM HUSBAND)
      (FLAGS NDESCBIT)
      (ACTION HUSBAND-NOT-HERE-F)>

<ROUTINE AUDIENCE-CHAMBER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The good news is that this hall is intoxicatingly beautiful, laid with the
snow-white fur of the rare Martian Velvetworm and endowed with platinum arches
and balustrades. Silky curtains embrace openings to the south, southwest,
and west.|
   The bad news is that no ">
		<COND (<NOT ,MALE>
		       <TELL "wo">)>
		<TELL
"man has ever entered the " D ,HERE " of" T ,SULTAN " and departed alive.">)
	       (<AND <EQUAL? .RARG ,M-END>
		     <NOT <FSET? ,SULTAN ,TOUCHBIT>>>
		<FSET ,SULTAN ,TOUCHBIT>
		<QUEUE I-SULTAN -1>)>>

<ROUTINE AUDIENCE-CHAMBER-EXIT-F ()
	 <COND (<NOT ,RIDDLE-ANSWERED>
		<TELL "\"Rule violation! Rule violation!\" ">
		<RIDDLE-DEATH>)
	       (<PRSO? ,P?SOUTH>
		,ORIENTAL-GARDEN)
	       (<PRSO? ,P?SW>
		,MAIN-HALL-OF-PALACE)
	       (<OR <G? ,CHOICE-NUMBER 0>
		    <EQUAL? ,HAREM-GUARD-COUNTER 5> ;"he's stormed off">
		,HAREM)
	       (<RUNNING? ,I-HAREM-GUARD>
		<QUEUE I-HAREM-GUARD 2>
		<TELL
"\"Hey!\" The " 'HAREM-GUARD " pushes you back. \"Pick a number first!" CR>
		<RFALSE>)
	       (T
		<QUEUE I-HAREM-GUARD 2>
		<MOVE ,HAREM-GUARD ,AUDIENCE-CHAMBER>
		<SETG AWAITING-FAKE-ORPHAN T>
		<TELL "A well-armed ">
		<COND (,MALE
		       <TELL "fe">)>
		<TELL
"male guard blocks you. \"Congratulations on your performance,\" ">
		<SHE-HE>
		<TELL
" says in a bored voice. You wonder how the guard can be so unmoved by your
historic feat. As though sensing your thoughts, the guard says, \"The "
D ,SULTAN " likes to pretend that no one's ever gotten the riddle, but
someone got it last year, the word spread around, and now everyone knows
the answer. You're the twelfth winner this week already. ">
		<HE-SHE T>
		<TELL
" sent away to Maude's House of Riddles on Ganymede for a new one, but the
mail is so slow...\" The guard shakes ">
		<HER-HIS>
		<TELL " head. \"Well, pick a ">
		<COND (,MALE
		       <TELL "wife">)
		      (T
		       <TELL "husband">)>
		<TELL
"; any number from 1 to 8379. Don't waste
time thinking; they're all clones anyway.\" ">
		<SHE-HE T>
		<TELL " looks at you expectantly." CR>
		<RFALSE>)>>

<OBJECT RIDDLE
	(LOC AUDIENCE-CHAMBER)
	(DESC "riddle")
	(SYNONYM RIDDLE)
	(FLAGS NDESCBIT)>

<ROUTINE HUSBAND-NOT-HERE-F ()
	 <COND (<AND <VERB? PICK>
		     <IN? ,HAREM-GUARD ,HERE>>
		<I-HAREM-GUARD T>)
	       (<AND <NOT <PRSO-MOBY-VERB?>>
		     <NOT <PRSI-MOBY-VERB?>>>
		<CANT-SEE ,HUSBAND-NOT-HERE>)>>

<ROUTINE WIFE-NOT-HERE-F ()
	 <COND (<AND <VERB? PICK>
		     <IN? ,HAREM-GUARD ,HERE>>
		<I-HAREM-GUARD T>)
	       (<AND <NOT <PRSO-MOBY-VERB?>>
		     <NOT <PRSI-MOBY-VERB?>>>
		<CANT-SEE ,WIFE-NOT-HERE>)>>

<OBJECT HAREM-GUARD
	(DESC "harem guard")
	(LDESC
"A guard stands by the entrance to the harem, apparently waiting for
a response from you.")
	(SYNONYM GUARD)
	(ADJECTIVE HAREM)
	(FLAGS ACTORBIT)
	(ACTION HAREM-GUARD-F)>

<ROUTINE HAREM-GUARD-F ()
	 <COND (<EQUAL? ,HAREM-GUARD ,WINNER>
		<COND (<AND <VERB? ANSWER-KLUDGE>
			    <PRSO? ,INTNUM>>
		       <PICK-WIFE ,INTNUM>)
		      (T
		       <I-HAREM-GUARD T>)>)
	       (<AND <VERB? FOLLOW>
		     <EQUAL? ,FOLLOW-FLAG 13 14>>
		<DO-WALK ,P?WEST>)>>

<GLOBAL HAREM-GUARD-COUNTER 0>

<ROUTINE I-HAREM-GUARD ("OPTIONAL" (CALLED-BY-HAREM-GUARD-F <>))
	 <SETG HAREM-GUARD-COUNTER <+ ,HAREM-GUARD-COUNTER 1>>
	 <COND (.CALLED-BY-HAREM-GUARD-F
	 	<QUEUE I-HAREM-GUARD 2>)
	       (T
		<QUEUE I-HAREM-GUARD -1>)>
	 <COND (<OR <NOT <EQUAL? ,HERE ,AUDIENCE-CHAMBER>>
		    <G? ,CHOICE-NUMBER 0>>
		<SETG AWAITING-FAKE-ORPHAN <>>
		<DEQUEUE I-HAREM-GUARD>
		<REMOVE ,HAREM-GUARD>
		<RFALSE>)>
	 <COND (<NOT .CALLED-BY-HAREM-GUARD-F>
		<TELL "   ">)>
	 <TELL "\"">
	 <COND (<EQUAL? ,HAREM-GUARD-COUNTER 5>
		<REMOVE ,HAREM-GUARD>
		<SETG FOLLOW-FLAG 14>
		<QUEUE I-FOLLOW 2>
		<DEQUEUE I-HAREM-GUARD>
		<SETG AWAITING-FAKE-ORPHAN <>>
		<TELL
"I'm not waiting around anymore! You blew it, sucker.\" The
guard storms angrily away." CR>)
	       (T
		<TELL "Ahem? A number...?\" says" T ,HAREM-GUARD>
		<COND (<EQUAL? ,HAREM-GUARD-COUNTER 4>
		       <TELL " with growing impatience">)>
		<TELL ,PERIOD-CR>)>>

<ROUTINE PICK-WIFE ("OPTIONAL" (OBJ <>) "AUX" DUPE)
	 <COND (<OR <EQUAL? .OBJ ,INTNUM>
		    <EQUAL? <NUMBER? ,P-CONT> ,W?NUMBER>>
		<COND (<L? ,P-NUMBER 1>
		       <TELL ,GIMME-TROUBLE>)
		      (<G? ,P-NUMBER 8379>
		       <TELL "\"There're only 8379 of 'em.\"" CR>)
		      (<SET DUPE <INTBL? ,P-NUMBER ,WRONG-ANSWERS 8>>
		       <TELL
"\"You already asked for that one, dodo-brain!\"" CR>)
		      (<OR <EQUAL? ,P-NUMBER ,WIFE-NUMBER>
			   <PROB ,HAREM-PROB>>
		       <SETG CHOICE-NUMBER ,P-NUMBER>
		       <SETG AWAITING-FAKE-ORPHAN <>>
		       <SETG FOLLOW-FLAG 13>
		       <QUEUE I-FOLLOW 2>
		       <REMOVE ,HAREM-GUARD>
		       <QUEUE I-HAREM 5>
		       <TELL
"The guard, walking off, says, \"I'll summon that one. You may enter.\"" CR>)
		      (T
		       <PUT ,WRONG-ANSWERS </ ,HAREM-PROB 15> ,P-NUMBER>
		       <SETG HAREM-PROB <+ ,HAREM-PROB 15>>
		       <TELL "The guard consults a list. \"">
		       <COND (<PROB 25>
			      <TELL "Traded to the Du">
			      <COND (,MALE
				     <TELL "ke">)
				    (T
				     <TELL "chess">)>
			      <TELL
" of Deimos for two eunuchs and a jester to be named later">)
			     (T
			      <TELL <PICK-ONE ,EXCUSES>>)>
		       <TELL ". Pick another number.\"" CR>)>)
	       (T
		<TELL "[Please give your selection in numerical form.]" CR>)>
	 <QUEUE I-HAREM-GUARD 2>
	 <STOP>>

<GLOBAL HAREM-PROB 0>

<GLOBAL CHOICE-NUMBER 0>

<GLOBAL WRONG-ANSWERS
	<TABLE 0 0 0 0 0 0 0 0>>

<GLOBAL EXCUSES
	<LTABLE 0
"Oops, deceased"
"Vacationing on Ceres"
"Bad case of harem fever">>

<OBJECT SULTAN
	(LOC AUDIENCE-CHAMBER)
	(SDESC "")
	(DESCFCN SULTAN-F)
	(SYNONYM SULTAN SULTANESS)
	(FLAGS ACTORBIT)
	(ACTION SULTAN-F)>

<ROUTINE SULTAN-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL "   The " D ,SULTAN " is here,">
		<COND (,RIDDLE-ANSWERED
		       <ARGUING-WITH-LEGAL-ADVISOR>)
		      (T
		       <TELL " enthroned.">)>)
	       (<EQUAL? ,SULTAN ,WINNER>
		<COND (<AND <VERB? TELL-ABOUT>
			    <PRSO? ,ME>
			    <PRSI? ,LGOP>>
		       <TELL
"\"They were exiled from Leather Island in the Caribbean, after cheating in
the Miss Leather Island beauty pageant; the silicone injectionist spilled the
beans. Now they rule all of Phobos. Hmmph! They call that hunk of rock a
Sultanate? Those bimbos never told a decent riddle in their lives!\"" CR>)
		      (<VERB? WHAT WHERE>
		       <TELL "\"I ask the riddles around here!\"" CR>)
		      (<AND <VERB? YES>
			    <EQUAL? ,AWAITING-REPLY 1>>
		       <V-YES>)
		      (<AND <VERB? NO>
			    <EQUAL? ,AWAITING-REPLY 1>>
		       <V-NO>)
		      (<AND <VERB? ANSWER-KLUDGE USE-QUOTES>
			    ,AWAITING-FAKE-ORPHAN
			    <NOT ,RIDDLE-ANSWERED>>
		       <COND (<NOT <PRSO? ,RIDDLE>>
			      <RIDDLE-ANSWER>
			      <RTRUE>)>
		       <SETG RIDDLE-ANSWERED T>
		       <DEQUEUE I-SNEEZE>
		       <INCREMENT-SCORE 8 11>
		       <TELL
"The " D ,SULTAN " looks crestfallen. \"Yes, that's right.\" The "
D ,SULTAN " is struck by a thought. \"Can we kill ">
		       <HIM-HER>
		       <TELL " anyway?\" ">
		       <HE-SHE T>
		       <TELL " begins">
		       <ARGUING-WITH-LEGAL-ADVISOR>
		       <TELL
" This might be a good time to make a beeline for the harem to the west." CR>)
		      (T
		       <TELL "The " D ,SULTAN " ignores you." CR>
		       <STOP>)>)
	       (<AND <NOT ,RIDDLE-ANSWERED>
		     <OR <TOUCHING? ,SULTAN>
			 <AND <VERB? THROW>
			      <PRSI? ,SULTAN>>>>
		<DO-WALK ,P?WEST>)
	       (<AND <VERB? GIVE SHOW>
		     <PRSO? ,CODED-MESSAGE>>
		<TELL "\"A spy! A spy!\" ">
		<RIDDLE-DEATH>)
	       (<AND <VERB? LISTEN>
		     ,RIDDLE-ANSWERED>
		<TELL "The " D ,SULTAN " is">
		<ARGUING-WITH-LEGAL-ADVISOR>
		<CRLF>)>>

<ROUTINE ARGUING-WITH-LEGAL-ADVISOR ()
	 <TELL " arguing loudly with one of ">
	 <HIS-HER>
	 <TELL " legal advisors.">>

<GLOBAL SULTAN-COUNTER 0>

<ROUTINE I-SULTAN ()
	 <SETG SULTAN-COUNTER <+ ,SULTAN-COUNTER 1>>
	 <TELL "   ">
	 <COND (<G? ,SULTAN-COUNTER 1>
		<COND (<EQUAL? ,SULTAN-COUNTER 4>
		       <TELL "\"Have this bore devoured.\" ">
		       <RIDDLE-DEATH>)
		      (T
		       <TELL "\"I grow impatient. ">)>)
	       (T
		<SETG AWAITING-REPLY 1>
		<TELL
"\"Ah,\" says" T ,SULTAN ", \"a visitor. This is pleasing;
it was turning out to be a very dull morning.\" ">
		<HE-SHE T>
		<TELL " clears ">
		<HIS-HER>
		<TELL
" throat. \"The rules: I will pose a riddle. If you answer it correctly,
you may spend one hour with any of my ">
		<COND (,MALE
		       <TELL "wive">)
		      (T
		       <TELL "husband">)>
		<TELL "s.">
		<YOU-WILL-DIE "you answer incorrectly">
		<YOU-WILL-DIE "you do not answer">
		<YOU-WILL-DIE "you enter the harem before answering">
		<YOU-WILL-DIE "you attempt to leave">
		<YOU-WILL-DIE "you touch me in any way">
		<YOU-WILL-DIE "I happen to sneeze">
		<YOU-WILL-DIE "any situation not covered by the rules occurs">
		<TELL "\" ">
		<HE-SHE T>
		<SETG AWAITING-REPLY 1>
		<TELL
" motions to one of the palace eunuchs. \"Go tell the animal tenders
not to feed the tigers yet.\" Pause. \"">)>
	 <TELL "Are you ready?\"" CR>>

<ROUTINE YOU-WILL-DIE (STRING)
	 <TELL " If " .STRING ", you will die.">>

<ROUTINE RIDDLE-DEATH ()
	 <JIGS-UP
"You never actually notice where the tiger comes from, only that it seems
very very very very ferocious.">>

<ROUTINE I-SNEEZE ()
	 <QUEUE I-SNEEZE -1>
	 <SETG SULTAN-COUNTER <+ ,SULTAN-COUNTER 1>>
	 <TELL "   The " D ,SULTAN>
	 <COND (<EQUAL? ,SULTAN-COUNTER 4>
		<TELL " convulses. \"Achoooooo!!!!\" ">
		<RIDDLE-DEATH>)
	       (<EQUAL? ,SULTAN-COUNTER 3>
		<TELL " is squinting and drawing in quick gasps of air!" CR>)
	       (<EQUAL? ,SULTAN-COUNTER 2>
		<TELL " is rubbing ">
		<HIS-HER>
		<TELL " nose with the back of ">
		<HIS-HER>
		<TELL " hand." CR>)
	       (T
		<TELL " is twitching ">
		<HIS-HER>
		<TELL " nose." CR>)>>

<GLOBAL RIDDLE-ANSWERED <>>

<ROUTINE RIDDLE-ANSWER ()
	 <COND (<AND <NOT ,P-CONT>
		     <NOT ,PRSO>>
		<SETG PRSO ,SULTAN>
		<V-TELL> "if you just said SAY or ANSWER with nothing after")
	       (<AND ,P-CONT
		     <OR <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?RIDDLE>
		    	 <EQUAL? <GET ,P-LEXV <+ ,P-CONT 2>> ,W?RIDDLE>>>
		<SETG WINNER ,SULTAN>
		<PERFORM ,V?ANSWER-KLUDGE ,RIDDLE>
		<SETG WINNER ,PROTAGONIST>
		<STOP>)
	       (<OR <AND ,P-CONT 
		     	 <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?SEX ,W?LOVE>>
		    <PRSO? ,LOVE>>
		<TELL "\"Good guess! It's wrong, though.\" ">
		<RIDDLE-DEATH>)
	       (T
		<TELL "\"Wrongo!\" ">
		<RIDDLE-DEATH>)>>

<ROOM HAREM
      (LOC ROOMS)
      (DESC "Harem")
      (EAST TO AUDIENCE-CHAMBER)
      (OUT TO AUDIENCE-CHAMBER)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL ODOR HAREM-OBJECT)
      (ODOR "")
      (ODOR-NUMBER 4)
      (ACTION HAREM-F)
      ;(THINGS <PSEUDO (<> HAREM HAREM-OBJECT-F)>)>

<ROUTINE HAREM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a sensuous location of silks and satins and furs.
A draped exit leads east.">
		<COND (<NOT <FSET? ,NOSE ,MUNGBIT>>
		       <TELL " A pleasant odor">
		       <COND (<FSET? ,HERE ,SMELLEDBIT>
			      <TELL " of " <GETP ,HERE ,P?ODOR>>)>
		       <TELL " tickles mischievously at " 'NOSE ".">)>
		<RTRUE>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,SIDEKICK ,HERE>
		     <QUEUED? ,I-HAREM>>
		;"this can happen if you answer the riddle before ever
	          meeting sidekick, then go back, get him, and enter harem"
		<TELL
"   A " 'HAREM-GUARD " grabs " D ,SIDEKICK ". \"You didn't
answer the riddle!\" ">
		<TIGER-EATS-SIDEKICK>)
	       (<EQUAL? .RARG ,M-SMELL>
		<TELL ,IT-SEEMS-THAT T ,SULTAN " likes h">
		<COND (,MALE
		       <TELL "is wives">)
		      (T
		       <TELL "er husbands">)>
		<TELL " to wear fine " <GETP ,HERE ,P?ODOR> ".">)>>

<ROUTINE TIGER-EATS-SIDEKICK ()
	 <REMOVE ,SIDEKICK>
	 <SETG FOLLOW-FLAG 2>
	 <QUEUE I-FOLLOW 2>
	 <SETG SIDEKICK-EATEN T>
	 <TELL
D ,SIDEKICK " is led away. As you hear, from nearby, a fierce roar
followed by a blood-curdling scream">
	 <MEMORIAM>>

<ROUTINE I-HAREM ()
	 <COND (<EQUAL? ,HERE ,HAREM>
		<TELL
"   A figure, completely cloaked in veils of silk, enters and beckons
you deeper into the harem" ,ELLIPSIS>
		<GOTO ,INNER-HAREM>
		<THIS-IS-IT ,SULTANS-WIFE>
		<FCLEAR ,SULTANS-WIFE ,NDESCBIT>
		<QUEUE I-HOUR 60>
		<TELL "   " D ,SULTANS-WIFE>
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL " sits down at the far end of the room." CR>)
		      (T
		       <TELL " touches a button at the shoulder of ">
		       <HER-HIS>
		       <TELL " tunic and it slowly floats to the floor. ">
		       <SHE-HE T>
		       <TELL
" pulls you down onto the furs, whispering in a husky voice, \"For
an hour, I am yours.\"" CR>)>)
	       (T
		<RFALSE>)>>

<ROUTINE I-HOUR ()
	 <COND (<EQUAL? ,HERE ,INNER-HAREM>
		<TELL
"   \"The hour is over,\" sighs " D ,SULTANS-WIFE
", reluctantly leading you out of the " 'HERE ,ELLIPSIS>
		<GOTO ,HAREM>)
	       (T
		<RFALSE>)>>

<ROUTINE HAREM-OBJECT-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,AUDIENCE-CHAMBER>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,HAREM ,INNER-HAREM>
		       <TELL ,LOOK-AROUND>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,AUDIENCE-CHAMBER>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?OUT>)>)
	       (<AND <VERB? EXAMINE>
		     <NOT <EQUAL? ,HERE ,AUDIENCE-CHAMBER>>>
		<V-LOOK>)
	       (<AND <VERB? SMELL>
		     <NOT <EQUAL? ,HERE ,AUDIENCE-CHAMBER>>>
		<PERFORM-PRSA ,ODOR>
		<RTRUE>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)>>

<ROOM INNER-HAREM
      (LOC ROOMS)
      (DESC "Inner Harem")
      (DOWN PER CATACOMBS-ENTER-F)
      (SE PER INNER-HAREM-EXIT-F)
      (OUT PER INNER-HAREM-EXIT-F)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL ODOR HAREM-OBJECT)
      (ACTION INNER-HAREM-F)
      ;(THINGS <PSEUDO (<> HAREM HAREM-OBJECT-F)>)>

<ROUTINE INNER-HAREM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This luxurious bedroom, presumably one of many throughout the
harem, is appointed with a multitude of exotic furs, warm to the
touch as though still alive. ">
		<COND (<NOT <FSET? ,NOSE ,MUNGBIT>>
		       <TELL
"The heady aroma of " <GETP ,HAREM ,P?ODOR>
" and incense mingle in the air. ">)>
		<TELL "There's an exit to the southeast">
		<COND (,CATACOMBS-OPEN
		       <TELL " and a secret passage leads downward">)>
		<TELL ".">)>>

<ROUTINE INNER-HAREM-EXIT-F ()
	 <COND (<AND <ULTIMATELY-IN? ,MAP>
		     <VISIBLE? ,MAP>>
		<TELL "As" T ,SULTANS-WIFE>
		<JIGS-UP " forewarned, the guards reduce you to three dots.">)
	       (T
		,HAREM)>>

<OBJECT SULTANS-WIFE
	(LOC INNER-HAREM)
	;"DESC handled by a special clause in DPRINT because of wife/husband #"
	(DESCFCN SULTANS-WIFE-F)
	(SYNONYM HUSBAND WIFE)
	(ADJECTIVE SULTAN\'S SULTAN SULTANESS)
	(FLAGS ACTORBIT NARTICLEBIT NDESCBIT)
	(ACTION SULTANS-WIFE-F)>

<ROUTINE SULTANS-WIFE-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<EQUAL? .OARG ,M-OBJDESC?>
		       <RTRUE>)>
		<TELL "   " D ,SULTANS-WIFE " is here">
		<COND (<NOT <EQUAL? ,NAUGHTY-LEVEL 0>>
		       <TELL ", lying seductively naked on a bed of furs">)>
		<TELL ".">)
	       (<EQUAL? ,WINNER ,SULTANS-WIFE>
		<COND (<OR <AND <VERB? KISS>
				<PRSO? ,KNEECAPS>
				<NOT ,CATACOMBS-OPEN>>
			   <AND <VERB? KISS-ON>
				<PRSO? ,ME>
				<PRSI? ,KNEECAPS>
				<NOT ,CATACOMBS-OPEN>>>
		       <COND (<EQUAL? ,CHOICE-NUMBER ,WIFE-NUMBER>
			      <MOVE ,MAP ,HERE>
			      <MOVE ,TORCH ,HERE>
			      <QUEUE I-TORCH 23>
			      <DEQUEUE I-HOUR>
			      <SETG CATACOMBS-OPEN T>
			      <OPEN-EYES-AND-REMOVE-HANDS>
			      <TELL
"\"Oh,\" whispers " D ,SULTANS-WIFE ", \"you're from
the rebels! Here's" T ,MAP ",\" ">
			      <SHE-HE>
			      <TELL
" says, laying" A ,MAP " at your feet, \"and here's" A ,TORCH ",\" ">
			      <SHE-HE>
			      <TELL
" says, lighting" A ,TORCH " and placing it next to the map. ">
			      <SHE-HE T>
			      <TELL
" moves some furs to reveal a secret entrance leading downwards. \"The
only way out is through the catacombs -- if you come back this way with"
T ,MAP "," T ,HAREM-GUARD "s will...\"" CR>)
			     (T
			      <TELL "\"I'm not into that kinky stuff.\"" CR>)>)
		      (<AND <VERB? KISS SUCK FUCK EAT LICK BLOW TAKE TOUCH>
			    <EQUAL? ,NAUGHTY-LEVEL 0>
			    <PRSO? ,ME ,COCK>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?FUCK ,SULTANS-WIFE>
		       <SETG WINNER ,SULTANS-WIFE>
		       <RTRUE>)
		      (<AND <VERB? KISS>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM-PRSA ,SULTANS-WIFE>
		       <SETG WINNER ,SULTANS-WIFE>
		       <RTRUE>)
		      (<AND <VERB? FUCK TAKE>
			    <PRSO? ,ME>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?FUCK ,SULTANS-WIFE>
		       <SETG WINNER ,SULTANS-WIFE>
		       <RTRUE>)
		      (<AND <VERB? EAT LICK BLOW SUCK>
			    <PRSO? ,ME ,COCK>>
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 1>
			      <TELL ,MISSIONARY-ONLY>)
			     (T
		       	      <TELL
D ,SULTANS-WIFE " nods eagerly and slides downward. Skillful tongue-work soon
has you squirming on the edge of orgasm... Eventually, spent and satisfied,
you take " D ,SULTANS-WIFE " lovingly into your arms." CR>)>)
		      (<OR <AND <VERB? WHAT>
				<PRSO? ,LGOP>>
			   <AND <VERB? TELL-ABOUT>
				<PRSO? ,ME>
				<PRSI? ,LGOP>>>
		       <TELL
"\"That's the code name of the cadre who lead the rebel underground. It is
said they have pledged their lives and souls to the revolution!\"" CR>)
		      (T
		       <TELL "\"Shhh... ">
		       <COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       	      <TELL
"It's past bedtime for the children of" T ,SULTAN "! You'll wake them!\"" CR>
		       	      <STOP>)
			     (T
		       	      <TELL
"Let " 'YOUR-BODY " do the talking,\" says " D ,SULTANS-WIFE
", reaching out toward you." CR>
		       	      <STOP>)>)>)
	       (<WRONG-SEX-WORD ,SULTANS-WIFE ,W?WIFE ,W?HUSBAND>
		<STOP>)
	       (<AND <VERB? THANK>
		     ,CATACOMBS-OPEN>
		<TELL
D ,SULTANS-WIFE " gives you a grand salute. \"For the revolution!\"" CR>)
	       (<AND <VERB? KISS TOUCH FUCK TAKE>
		     <EQUAL? ,NAUGHTY-LEVEL 0>>
		<TELL
"Instead, you decide to get to know " D ,SULTANS-WIFE
" better, so you engage ">
		<HER-HIM>
		<TELL
" in a stimulating discussion about " <PICK-ONE ,DISCUSSION-TOPICS> CR>)
	       (<VERB? EAT>
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <V-FUCK>)
		      (<EQUAL? ,NAUGHTY-LEVEL 1>
		       <TELL ,MISSIONARY-ONLY>)
		      (T
		       <TELL D ,PRSO " arches ">
		       <HER-HIS>
		       <TELL
" body to meet you, passionately stroking your neck and shoulders." CR>)>)
	       (<AND <VERB? UNDRESS>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<SHE-HE T>
		<TELL " is!" CR>)
	       (<VERB? DRESS>
		<TELL "You must be from Massachusetts." CR>)
	       (<VERB? KISS TOUCH TAKE>
		<TELL
D ,SULTANS-WIFE " moans softly and draws closer to you." CR>)
	       (<VERB? FUCK>
		<COND (,WIFE-FUCKED
		       <TELL
"You shouldn't wear yourself out. [Besides, do you think there's infinite
room on this disk for long, lurid descriptions of sex acts?]" CR>
		       <RTRUE>)>
		<SETG WIFE-FUCKED T>
		<TELL D ,SULTANS-WIFE " draws you into ">
		<HER-HIS>
		<TELL " arms. ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 2>
		       <TELL "As " 'HANDS "s explore h">
		       <COND (,MALE
			      <TELL "er soft, rounded">)
			     (T
			      <TELL "is firm, strong">)>
		       <TELL
" body, a faint sweaty, musky odor triggers a passionate fire
within you, and you find yourself ">
		       <COND (,MALE
			      <TELL "ris">)
			     (T
			      <TELL "warm">)>
		       <TELL
"ing to the occasion. Your lovemaking is slow and gentle, and as you reach
a crescendo of pleasure, you cry out softly, passionately, and repeatedly.
\"Oh,\" moans " D ,SULTANS-WIFE ", \"say my number again ... say it in
French...\"" CR>)>
		<TELL
"Much later, you and " D ,SULTANS-WIFE " fall back upon the furs,
basking in the aura of postcoital bliss." CR>)
	       (<VERB? MARRY>
		<TELL "But " D ,PRSO " is already married!" CR>)
	       (<VERB? MEASURE>
		<COND (,MALE
		       <TELL "36-24-36">)
		      (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <TELL "Tall">)
		      (<EQUAL? ,NAUGHTY-LEVEL 1>
		       <TELL "Long">)
		      (T
		       <TELL "Ten delicious inches">)>
		<TELL ,PERIOD-CR>)
	       (<AND <VERB? EXAMINE>
		     <NOT <EQUAL? ,NAUGHTY-LEVEL 0>>>
		<TELL
"A mere glance at the succulent, sexy body of "
D ,SULTANS-WIFE " is enough to ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 1>
		       <TELL "really turn you on">)
		      (,MALE
		       <TELL "give you an instant hard-on">)
		      (T
		       <TELL "get you all moist and randy">)>
		<TELL ,PERIOD-CR>)
	       (<VERB? SMELL>
		<SHE-HE T>
		<TELL " smells of " <GETP ,HAREM ,P?ODOR> ,PERIOD-CR>)>>

<GLOBAL WIFE-FUCKED <>>

<GLOBAL DISCUSSION-TOPICS
	 <LTABLE 0
"the latest sounds in jazz."
"a new radio serial."
"possible uses of electricity."
"the writings of Jules Verne."
"the intelligence level of beavers.">>

<OBJECT TORCH
	(SDESC "reliable torch")
	(NO-T-DESC "orch")
	(SYNONYM TORCH ORCH)
	(ADJECTIVE RELIABLE UNRELIABLE)
	(FLAGS TAKEBIT ONBIT LIGHTBIT)
	(ACTION TORCH-F)>

<ROUTINE TORCH-F ()
	 <COND (<AND <VERB? OFF>
		     <FSET? ,TORCH ,ONBIT>>
		<TORCH-OFF>
		<TELL ,PFFT>)
	       (<AND <VERB? ON>
		     <NOT <FSET? ,TORCH ,ONBIT>>>
		<PERFORM ,V?BURN ,TORCH>
		<RTRUE>)
	       (<AND <VERB? BURN>
		     <PRSO? ,TORCH>
		     <FSET? ,TORCH ,ONBIT>>
		<PERFORM ,V?ON ,TORCH>
		<RTRUE>)
	       (<AND <VERB? PUT PUT-ON>
		     <FSET? ,TORCH ,ONBIT>
		     <PRSI? ,BARGE ,TRELLIS>
		     <NOT <FSET? ,PRSI ,UNTEEDBIT>>>
		<TELL "The " 'PRSI " would burn!" CR>)
	       (<AND <VERB? PUT>
		     <PRSI? ,CANAL ,WATER>
		     <FSET? ,TORCH ,ONBIT>>
		<TORCH-OFF>
		<TELL ,PFFT>)>>

<GLOBAL TORCH-LIFE 5>

<ROUTINE TORCH-OFF ()
	 <DEQUEUE I-TORCH>
	 <FCLEAR ,TORCH ,ONBIT>
	 <FCLEAR ,TORCH ,LIGHTBIT>
	 <PUTP ,TORCH ,P?SDESC "unreliable torch">
	 <FSET ,TORCH ,VOWELBIT>>

<ROUTINE I-TORCH ()
	 <SETG TORCH-LIFE <- ,TORCH-LIFE 1>>
	 <COND (<EQUAL? ,TORCH-LIFE 0>
		<TORCH-OFF>)
	       (T
		<QUEUE I-TORCH <* ,TORCH-LIFE 6>>)>
	 <COND (<AND <VISIBLE? ,TORCH>
		     <NOT <FSET? ,EYES ,MUNGBIT>>
		     <NOT <EQUAL? ,HAND-COVER ,EYES>>>
		<TELL "   ">
		<COND (<EQUAL? ,TORCH-LIFE 0>
		       <TELL ,PFFT>
		       <NOW-DARK?>)
		      (T
		       <TELL "The torch is noticeably dimmer." CR>)>)>
	 <RFALSE> ;"won't stop a wait even if it prints">

<OBJECT MAP
	(DESC "secret map")
	(NO-T-DESC "secre map")
	(SYNONYM MAP)
	(ADJECTIVE SECRET SECRE)
	(FLAGS TAKEBIT BURNBIT READBIT)
	(SIZE 2)
	(ACTION MAP-F)>

<ROUTINE MAP-F ()
	 <COND (<AND <VERB? READ EXAMINE>
		     <NOT <FSET? ,PRSO ,UNTEEDBIT>>>
		<IN-YOUR-PACKAGE "secret catacombs map">
		<CRLF>)>>

<GLOBAL CATACOMBS-OPEN <>>

<ROUTINE CATACOMBS-ENTER-F ()
	 <COND (,CATACOMBS-OPEN
		<QUEUE I-BEETLES 6>
		<QUEUE I-CRABS 10>
	        <QUEUE I-GATOR 12>
		<TELL "As you leave, ">
		<COND (<EQUAL? ,NAUGHTY-LEVEL 0>
		       <PERFORM ,V?THANK ,SULTANS-WIFE>
		       <CRLF>)
		      (T
		       <TELL D ,SULTANS-WIFE>
		       <COND (,MALE
		       	      <TELL
" throws herself into your arms. Her ample bosom presses against your chest as
she whispers into your ear, \"Please, oh, please be careful down there!\" Sh">)
		      	     (T
		       	      <TELL
" gathers you into his powerful arms. Nibbling tenderly on your neck, he
whispers, \"Be wary -- the catacombs are dangerous.\" H">)>
		       <TELL
"e kisses you longingly, but eventually you descend, reluctantly,
into the gloom of the catacombs" ,ELLIPSIS>)>
		,CATACOMBS)
	       (T
		<TELL ,CANT-GO>
		<RFALSE>)>>

<ROOM CATACOMBS
      (LOC ROOMS)
      (DESC "Catacombs")
      (NORTH PER CATACOMBS-MOVEMENT-F)
      (NE PER CATACOMBS-MOVEMENT-F)
      (EAST PER CATACOMBS-MOVEMENT-F)
      (SE PER CATACOMBS-MOVEMENT-F)
      (SOUTH PER CATACOMBS-MOVEMENT-F)
      (SW PER CATACOMBS-MOVEMENT-F)
      (WEST PER CATACOMBS-MOVEMENT-F)
      (NW PER CATACOMBS-MOVEMENT-F)
      (UP PER CATACOMBS-MOVEMENT-F)
      (DOWN PER CATACOMBS-MOVEMENT-F)
      (GLOBAL WATER)
      (FLAGS INDOORSBIT)
      (ACTION CATACOMBS-F)>

<ROUTINE CATACOMBS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You're at a junction within an ancient, crumbling catacomb. Your ">
		<COND (<AND <ULTIMATELY-IN? ,TORCH>
			    <FSET? ,TORCH ,ONBIT>>
		       <TELL "torch">)>
		<TELL
"light pierces the gloom for only a few feet in each direction. "
,CATACOMBS-WATER-DESC>)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,SIDEKICK-EATEN>
		<MOVE ,SIDEKICK ,HERE>
		<SETG SIDEKICK-EATEN <>>
		<TELL
"   \"Yo!\" says " D ,SIDEKICK ", tapping your shoulder. \"Looked like my
number was up that time! Would've been, if those dimension-hopping midgets
hadn't come through at the right moment. Good thing the tiger cage leads
to the catacombs, eh?\" ">
		<HE-SHE T>
		<TELL " brushes a stray patch of fur off ">
		<HIS-HER>
		<TELL " shoulder." CR>)>>

<ROUTINE CATACOMBS-MOVEMENT-F ("AUX" DIR-OFFSET TABLE-VALUE)
	 <COND (<NOT ,LIT>
		<JIGS-UP
"You stumble into the dark, hit a wall, knock yourself unconscious, fall
into a foot of water, drown, and are devoured by Martian beetles.">)>
	 <SET DIR-OFFSET <COND (<PRSO? ,P?NORTH> 0)
			       (<PRSO? ,P?NE> 1)
			       (<PRSO? ,P?EAST> 2)
			       (<PRSO? ,P?SE> 3)
			       (<PRSO? ,P?SOUTH> 4)
			       (<PRSO? ,P?SW> 5)
			       (<PRSO? ,P?WEST> 6)
			       (<PRSO? ,P?NW> 7)
			       (<PRSO? ,P?UP> 8)
			       (T 9)>>
	 <SET TABLE-VALUE
	    <GET ,CATACOMBS-TABLE <+ <* <- ,CATACOMBS-LOC 1> 10> .DIR-OFFSET>>>
	 <TELL "You wade into the gloom ... and find ">
	 <COND (<EQUAL? .TABLE-VALUE 0>
		<COND (<PRSO? ,P?UP ,P?DOWN>
		       <TELL "a severe paucity of passages leading ">
		       <COND (<PRSO? ,P?UP>
			      <TELL "up">)
			     (T
			      <TELL "down">)>)
		      (T
		       <TELL "yourself face to face with a blank wall">)>
		<TELL ,PERIOD-CR>
		<RFALSE>)
	       (T
		<TELL "a ">
		<COND (<PRSO? ,P?UP ,P?DOWN>
		       <TELL "hidden passage leading ">
		       <COND (<PRSO? ,P?UP>
			      <TELL "up">)
			     (T
			      <TELL "down">)>
		       <TELL "wards.">)
		      (T
		       <TELL "dark and winding tunnel.">)>
		<COND (<EQUAL? .TABLE-VALUE 99>
		       <TELL
" Unfortunately, you soon come to a point where the tunnel has collapsed,
hopelessly blocking your way." CR>
		       <RFALSE>)
		      (<EQUAL? .TABLE-VALUE 80> ;"back up to harem"
		       <TELL " Unfortunately, it's too steep and slippery." CR>
		       <RFALSE>)
		      (T
		       <CRLF> <CRLF>
		       <COND (<EQUAL? .TABLE-VALUE 40>
			      <RETURN ,FORGOTTEN-STOREHOUSE>)
			     (<EQUAL? .TABLE-VALUE 50>
			      <RETURN ,WELL-BOTTOM>)
			     (<EQUAL? .TABLE-VALUE 60>
			      <RETURN ,LADDER-ROOM>)
			     (<EQUAL? .TABLE-VALUE 70>
			      <RETURN ,BURIAL-CHAMBER>)
			     (T
			      <SET CATACOMBS-LOC .TABLE-VALUE>
			      <DESCRIBE-ROOM>
			      <COND (<IN? ,SIDEKICK ,HERE>
		                     <SIDEKICK-FOLLOWS-YOU>)>
			      ;"next kludge keeps V-WALK from doing an RFATAL"
			      <RETURN ,ROOMS>)>)>)>>

<GLOBAL CATACOMBS-LOC 1>

<CONSTANT CATACOMBS-TABLE
	<TABLE ;"99 = dead end"
       ;N   ;NE    ;E   ;SE    ;S   ;SW    ;W   ;NW    ;U    ;D
;01     0     0    99     0     0    99     0     2    80     0 ;"up to harem"
;02     3     0     0     3     0     1     0     0     0     0
;03     0     4     0     0     2     0     2     0     0     0
;04     3     0     5     0     0     0    99     0     0     0
;05     0     6     4    99     0     0     0     0     0     0
;06     0     7     0     5    99     0     0     0     0     0
;07    99     6     0     8     0     0     0     0     0     0
;08     0     0     0     0     7     0     0    99     0     9
;09     0     0     0     0     0    10     0    11     8     0
;10     0     9     0    10     0     0    10     0     0     0

       ;N   ;NE    ;E   ;SE    ;S   ;SW    ;W   ;NW    ;U    ;D
;11     0    12     0     0     0     9    99     0     0     0
;12    13     0     0     0     0    11    99     0     0     0
;13     0    12     0     0    14     0    99     0     0     0
;14     0    15    99     0     0     0    13     0     0     0
;15     0    16     0    14     0     0     0     0    17     0
;16    15     0    16     0     0    16     0     0     0     0
;17     0     0     0     0    18     0     0    40     0    15   ;"storehouse"
;18     0    99     0    19     0     0     0    17     0     0
;19     0     0    18    22    20     0     0     0     0     0
;20    21    21     0     0    19     0     0     0     0     0

       ;N   ;NE    ;E   ;SE    ;S   ;SW    ;W   ;NW    ;U    ;D
;21     0    20     0    50     0     0     0    20     0     0   ;"wellbottom"
;22     0     0    19     0     0     0     0    50     0    23   ;"wellbottom"
;23     0    25    24     0     0     0     0     0    22     0
;24    25     0     0     0     0     0    23    99     0     0
;25     0     0     0    23    24     0    26     0     0     0
;26    60    25    27     0     0     0     0     0     0     0   ;"ladderoom"
;27     0     0     0     0     0    99    28    26     0     0
;28     0     0    27     0    29    29     0     0     0     0
;29     0    28     0     0    28    70     0     0     0     0   ;"burial">>

<ROOM FORGOTTEN-STOREHOUSE
      (LOC ROOMS)
      (DESC "Forgotten Storehouse")
      (LDESC
"No living creature can even guess how long this storehouse has sat amidst
the catacombs, undisturbed by man or by time, untouched by wars and weather,
a silent witness to the passing eons, the rise and fall of empires, the
births and deaths of countless billions, its only visitor the dark waters
of a Martian canal.")
      (NW TO CATACOMBS)
      (OUT TO CATACOMBS)
      (FLAGS INDOORSBIT)
      (GLOBAL WATER)>

<OBJECT PHONE-BOOK
	(LOC FORGOTTEN-STOREHOUSE)
	(DESC "Cleveland phone book")
	(FDESC "Sitting in one corner is a Cleveland telephone directory.")
	(SYNONYM BOOK DIRECTORY PHONEBOOK)
	(ADJECTIVE CLEVELAND PHONE TELEPHONE)
	(FLAGS TAKEBIT BURNBIT)
	(ACTION PHONE-BOOK-F)>

<ROUTINE PHONE-BOOK-F ()
	 <COND (<VERB? READ LOOK-INSIDE OPEN>
		<TELL
"How useful. Now you know how many Smiths live in Cleveland." CR>)
	       (<VERB? CLOSE>
		<TELL "It is." CR>)
	       (<AND <VERB? TAKE>
		     <NOT <FSET? ,PHONE-BOOK ,TOUCHBIT>>>
		<FSET ,PHONE-BOOK ,TOUCHBIT>
		<INCREMENT-SCORE 13 26 T>
		<RFALSE>)>>

<ROOM WELL-BOTTOM
      (LOC ROOMS)
      (DESC "Well Bottom")
      (LDESC
"Damp walls of brick rise to a point of light far above. A black circle
is visible just below the surface of the water.")
      (EAST PER WELL-BOTTOM-EXIT-F)
      (SE PER WELL-BOTTOM-EXIT-F)
      (SW PER WELL-BOTTOM-LOOP-F)
      (NW PER WELL-BOTTOM-LOOP-F)
      (UP SORRY "The well has no handholds.")
      (GLOBAL HOLE WATER LIGHT WELL-OBJECT)
      (HOLE-DESTINATION BARGE)
      (FLAGS ONBIT INDOORSBIT)
      ;(THINGS <PSEUDO (LARGE WELL WELL-F)
		      (<> LIGHT UNIMPORTANT-THING-F)>)>

<ROUTINE WELL-BOTTOM-EXIT-F ()
	 <COND (<PRSO? ,P?EAST>
		<SETG CATACOMBS-LOC 21>)
	       (T
		<SETG CATACOMBS-LOC 22>)>
	 ,CATACOMBS>

<ROUTINE WELL-BOTTOM-LOOP-F ()
	 <DESCRIBE-ROOM>
	 <COND (<IN? ,SIDEKICK ,HERE>
		<NORMAL-SIDEKICK-FOLLOW>)>
	 <RFALSE>>

<ROOM LADDER-ROOM
      (LOC ROOMS)
      (DESC "Ladder Room")
      (LDESC
"This spot is much like the rest of the catacombs, except that a ladder
leads up into the darkness.")
      (NW TO CATACOMBS)
      (OUT TO CATACOMBS)
      (UP PER LADDER-ROOM-EXIT-F)
      (FLAGS INDOORSBIT)
      (GLOBAL WATER)
      ;(THINGS <PSEUDO (<> LADDER LADDER-F)>)>

<OBJECT LADDER
      (LOC LADDER-ROOM)  
      (DESC "ladder")
      (SYNONYM LADDER)
      (FLAGS NDESCBIT)
      (ACTION LADDER-F)>

<ROUTINE LADDER-ROOM-EXIT-F ()
	 <TELL
"You climb for a seemingly endless time, with the ladder becoming increasingly
rickety. Suddenly a rung snaps, and you tumble into the darkness! You bounce
painfully into a slanted ventilation shaft, slide through a wooden grating,
and land amidst thousands of silk ">
	 <COND (,MALE
		<TELL "brassieres">)
	       (T
		<TELL "jockstraps">)>
	 <TELL ,PERIOD-CR CR>
	 ,LAUNDRY-ROOM>

<ROUTINE LADDER-F ()
	 <COND (<VERB? CLIMB CLIMB-UP>
		<DO-WALK ,P?UP>)>>

<ROOM BURIAL-CHAMBER
      (LOC ROOMS)
      (DESC "Burial Chamber")
      (LDESC
"Generations of Sultans and Sultanesses are entombed here, along with their
vast wealth, their favorite servants, and some form of transportation to the
next world. For example, one Sultan lies amidst mountains of rubies, surrounded
by a fleet of dirigibles.")
      (NORTH TO CATACOMBS)
      (OUT TO CATACOMBS)
      (FLAGS INDOORSBIT)
      (GLOBAL WATER)
      ;(THINGS <PSEUDO (<> RUBY UNIMPORTANT-THING-F)
		      (<> RUBIES UNIMPORTANT-THING-F)
		      (<> DIRIGIBLE UNIMPORTANT-THING-F)>)>

<OBJECT RUBIES
      (LOC BURIAL-CHAMBER) 
      (DESC "ruby")
      (SYNONYM RUBY RUBIES)
      (FLAGS NDESCBIT)
      (ACTION UNIMPORTANT-THING-F)>

<OBJECT DIRIGIBLE
      (LOC BURIAL-CHAMBER)
      (DESC "dirigible")
      (SYNONYM DIRIGIBLE)
      (FLAGS NDESCBIT)
      (ACTION UNIMPORTANT-THING-F)>

<OBJECT RAFT
	(LOC BURIAL-CHAMBER)
	(SDESC "raft")
	(NO-T-DESC "raf")
	(DESCFCN RAFT-F)
	(SYNONYM RAFT RAF LIFERAFT)
	(ADJECTIVE DEFLATED SIMPLE RUBBER LIFE)
	(CAPACITY 100)
	(SIZE 60)
	(FLAGS TAKEBIT VEHBIT INBIT CONTBIT SEARCHBIT OPENBIT)
	(ACTION RAFT-F)>

<GLOBAL RAFT-HELD <>>

<ROUTINE RAFT-F ("OPTIONAL" (OARG <>) "AUX" (NUM 0))
	 <COND (.OARG
		<COND (<NOT <FSET? ,RAFT ,TOUCHBIT>>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL
"   On the other hand, another Sultan had a considerably more modest
vision of the afterlife, bringing only a simple rubber life raft.">)
		      (,RAFT-HELD
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL
"   There is a raft here, which you're keeping a hand on.">)
		      (<EQUAL? ,HERE ,CANAL>
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL "   A raft is floating nearby.">)
		      (T
		       <RFALSE>)>)
	       (<AND <EQUAL? ,HERE ,CANAL>
		     <IN? ,PROTAGONIST ,BARGE>
		     <IN? ,RAFT ,CANAL>
		     <NOT <EQUAL? ,RAFT-LOC-NUM ,BARGE-LOC-NUM>>>
		<CANT-SEE ,RAFT>)
	       (<FSET? ,RAFT ,UNTEEDBIT>
		<RFALSE>)
	       (<VERB? SINK>
		<COND (<OR ,RAFT-HELD
			   <AND <EQUAL? ,HERE ,CANAL>
				<IN? ,PROTAGONIST ,RAFT>>>
		       <PERFORM ,V?DEFLATE ,RAFT>
		       <RTRUE>)
		      (T
		       <TELL "It's not even in water!" CR>)>)
	       (<AND <VERB? PUT>
		     <IN-CATACOMBS>
		     <PRSI? ,WATER>>
		<PERFORM ,V?DROP ,RAFT>
		<RTRUE>)
	       (<AND <VERB? DROP THROW>
		     <PRSO? ,RAFT>
		     <IN-CATACOMBS>>
		<REMOVE ,RAFT>
		<TELL
"The raft floats into the darkness. Oh, well, easy come, easy go." CR>)
	       (<AND <VERB? DROP>
		     ,RAFT-HELD>
		<SETG RAFT-HELD <>>
		<MOVE ,RAFT ,CANAL>
		<SET-RAFT-LOC>
		<QUEUE I-CANAL -1>
		<TELL "The raft ">
		<COND (<EQUAL? ,HERE ,CANAL>
		       <COND (,BARGE-UNDER-POWER
			      <TELL "is left behind in the wake of">)
			     (T
			      <SETG RAFT-WAIT ,BARGE-WAIT> ;"keep 'em in phase"
			      <TELL "floats along beside">)>
		       <TELL " the barge." CR>)
		      (T
		       <TELL "is swept away." CR>)>)
	       (<AND <VERB? TAKE>
		     <PRSO? ,RAFT>
		     <NOT <FSET? ,RAFT ,TOUCHBIT>>>
		<FSET ,RAFT ,TOUCHBIT>
		<INCREMENT-SCORE 8 3>
		<RFALSE>)
	       (<AND <VERB? TAKE>
		     <OR <IN? ,YOUR-BODY ,RAFT>
			 <IN? ,SIDEKICKS-BODY ,RAFT>>>
		;"this is possible if you get in raft in Lab and then
		  flip the switch again, then TAKE RAFT as gorilla"
		<TELL "It's too heavy." CR>)
	       (<VERB? BOARD>
	        <COND (<IN? ,RAFT ,BARGE>
		       <TELL
"Hrumph! There's no reason to board the raft inside the barge! ">
		       <PERFORM ,V?SINK ,BARGE>
		       <RTRUE>)
		      (<IN? ,RAFT ,ODD-MACHINE>
		       <DO-FIRST "remove it from" ,ODD-MACHINE>)
		      (<OR <ULTIMATELY-IN? ,RAFT ,MALE-GORILLA>
			   <ULTIMATELY-IN? ,RAFT ,FEMALE-GORILLA>>
		       <NOT-ON-GROUND ,RAFT>)
		      (<AND <OR ,RAFT-HELD
				<IN? ,RAFT ,CANAL>>
			    <NOT <IN? ,PROTAGONIST ,RAFT>>>
		       <QUEUE I-CANAL -1>
		       <SET-RAFT-LOC>
		       <COND (<EQUAL? ,HERE ,MY-KIND-OF-DOCK>
			      <SETG NEARER-DOCK ,MY-KIND-OF-DOCK>)
			     (T
			      <SETG NEARER-DOCK ,ABANDONED-DOCK>)>
		       <COND (<AND <G? ,BARGE-LOC-NUM ,RAFT-LOC-NUM>
				   <IN? ,BARGE ,CANAL>>
			      <SETG BARGE-LOC-NUM 36>
			      <MOVE ,BARGE ,ICY-DOCK>)>
		       <TELL "As you">
		       <AND-SIDEKICK ,RAFT>
		       <TELL " board the raft, ">
		       <COND (<EQUAL? ,HERE ,CANAL>
			      <TELL "it begins drifting away from the barge">
			      <COND (,BARGE-UNDER-POWER
				     <BARGE-FORGES-AHEAD>)>)
			     (T
			      <TELL
"the current sweeps it away from the dock">)>
		       <TELL ,PERIOD-CR>
		       <COND (<AND ,BARGE-WAIT
				   <EQUAL? ,RAFT-LOC-NUM ,BARGE-LOC-NUM>>
			      <SETG RAFT-WAIT T>) ;"so they'll drift together"
			     (T
			      <SETG RAFT-WAIT <>>)>
		       <SETG RAFT-HELD <>>
		       <MOVE ,RAFT ,CANAL>
		       <COND (<EQUAL? ,HERE ,CANAL> ;"not changing rooms"
			      <MOVE ,PROTAGONIST ,RAFT>
			      <SETG OHERE <>>)
			     (T ;"changing rooms, so new room desc is wanted"
			      <CRLF>
			      <GOTO ,RAFT>)>)>)
	       (<VERB? STAND-ON> ;"for JUMP ONTO RAFT"
		<PERFORM ,V?BOARD ,RAFT>
		<RTRUE>)
	       (<VERB? DEFLATE MUNG KILL>
		<COND (<FSET? ,RAFT ,MUNGBIT>
		       <TELL ,ALREADY-IS>)
		      (T
		       <TELL "\"Phssss.\"">
		       <COND (<OR ,RAFT-HELD
				  <IN? ,RAFT ,CANAL>>
			      <TELL " The raft sinks">
			      <COND (<IN? ,PROTAGONIST ,RAFT>
				     <JIGS-UP ", and you with it.">)
				    (T
				     <SETG RAFT-HELD <>>
				     <REMOVE ,RAFT>
				     <TELL ,PERIOD-CR>)>)
			     (T
			      <FSET ,RAFT ,MUNGBIT>
		       	      <PUTP ,RAFT ,P?SDESC "deflated raft">
			      <CRLF>)>)>)
	       (<VERB? INFLATE>
		<COND (<FSET? ,RAFT ,MUNGBIT>
		       <TELL "Without a pump? Forget it." CR>)
		      (T
		       <TELL ,ALREADY-IS>)>)
	       (<AND <VERB? SHAKE>
		     <EQUAL? ,HERE ,CANAL>
		     <IN? ,PROTAGONIST ,RAFT>>
		<SHAKE-BOAT>)
	       (<AND <VERB? PUSH-DIR>
		     <PRSI? ,INTDIR>>
		<COND (<AND <IN? ,PROTAGONIST ,RAFT>
			    <NOT <EQUAL? ,P-PRSA-WORD ,W?MOVE>>>
		       <TELL "You're in it!" CR>)
		      (<IN? ,RAFT ,CANAL>
		       <TELL ,NO-STEERING>)
		      (T
		       <DO-WALK ,P-DIRECTION>
		       <MOVE ,RAFT ,HERE>)>)
	       (<AND <VERB? SET>
		     <IN? ,RAFT ,CANAL>>
		<TELL ,NO-STEERING>)
	       (<VERB? LAND>
		<TELL "Try grabbing a dock." CR>)>>

<ROUTINE I-BEETLES ()
	 <COND (<NOT <IN-CATACOMBS>>
		<RFALSE>)>
	 <QUEUE I-BEETLES 6>
	 <COND (<IN? ,PROTAGONIST ,HERE>
		<SETG CATACOMBS-LOC <RANDOM ,CATACOMBS-LOC>>
		<COND (<IN? ,SIDEKICK ,HERE>
		       <MOVE ,SIDEKICK ,CATACOMBS>)>
	 	<MOVE ,PROTAGONIST ,CATACOMBS>
	 	<SETG OHERE <>>
		<SETG HERE ,CATACOMBS> ;"in case you're in Well Bottom, etc."
		<FSET ,CATACOMBS ,MUNGBIT> ;"for V-DIAGNOSE"
		<OPEN-EYES-AND-REMOVE-HANDS>
	 	<TELL
"   Suddenly the water explodes with life! A swarm of the nastiest beetles
this side of Pluto starts munching your flesh. You escape by running blindly
through the catacombs, completely losing track of your location." CR>)
	       (T
		<HARMLESS-SNAP "beetle">)>>

<ROUTINE I-CRABS ("AUX" OBJ)
	 <COND (<NOT <IN-CATACOMBS>>
		<RFALSE>)>
	 <QUEUE I-CRABS 10>
	 <COND (<IN? ,PROTAGONIST ,HERE>
		<OPEN-EYES-AND-REMOVE-HANDS>
		<FSET ,CATACOMBS ,MUNGBIT> ;"for V-DIAGNOSE"
	 	<TELL
"   You feel an intense pain, like a tuft of hair being yanked out -- except
that it's coming from your feet, and in about a hundred places. As you flail
at the pack of Martian sand crabs, the splashing startles them away">
	 	<COND (<AND <SET OBJ <FIRST? ,PROTAGONIST>>
			    <NOT <EQUAL? .OBJ ,GARMENT ,COMIC-BOOK>>>
		       <COND (<AND <EQUAL? .OBJ ,TORCH>
				   ;"make torch last object lost"
				   <NEXT? ,TORCH>>
			      <SET OBJ <NEXT? ,TORCH>>)>
		       <TELL
", but during the struggle you seem to have lost your " D .OBJ ,PERIOD-CR>
		       <REMOVE .OBJ>
		       <NOW-DARK?>)
		      (T
	 	       <TELL ,PERIOD-CR>)>)
	       (T
		<HARMLESS-SNAP "crab">)>>

<ROUTINE I-GATOR ()
	 <COND (<NOT <IN-CATACOMBS>>
		<RFALSE>)>
	 <COND (<IN? ,PROTAGONIST ,HERE>
		<JIGS-UP
"   A Martian alligator, large enough to blend in inconspicuously with
Great Britain's mercantile fleet, swims by and gulps a huge bunch of
canal water -- the bunch that happens to include you, by the way.">)
	       (T
		<QUEUE I-GATOR 12>
		<HARMLESS-SNAP "gator">)>>

<ROUTINE HARMLESS-SNAP (STRING)
	 <TELL
"   The calm water is suddenly shattered by the jaws of a huge Martian "
.STRING " snapping harmlessly toward you. Good thing you were in the
raft." CR>>

<ROOM MARTIAN-DESSERT
      (LOC ROOMS)
      (DESC "Martian Dessert")
      (LDESC
"No, not a typo. \"Dessert\" refers to the fifty foot Martian Cream Pie here.
A mirage, of course. People hopelessly lost in the desert often see strange
mirages, such as cream pies, lakes, or trails to the northwest and southeast.")
      (NW PER MARTIAN-DESSERT-EXIT-F)
      (SE PER MARTIAN-DESSERT-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL DUNES)
      ;(THINGS <PSEUDO (<> MIRAGE UNIMPORTANT-THING-F)
		      ;(<> DESSERT UNIMPORTANT-THING-F)
		      (CREAM PIE UNIMPORTANT-THING-F)>)>

<OBJECT DESSERT-OBJECT
      (LOC MARTIAN-DESSERT)
      (DESC "Martian Cream Pie") 
      (SYNONYM PIE DESSERT MIRAGE)
      (ADJECTIVE MARTIAN CREAM)
      (FLAGS NDESCBIT)
      (ACTION UNIMPORTANT-THING-F)>

<ROUTINE MARTIAN-DESSERT-EXIT-F ()
	 <COND (<NOT <FSET? ,MARTIAN-DESSERT ,MUNGBIT>>
		<FSET ,MARTIAN-DESSERT ,MUNGBIT>
		<TELL "I guess the paths aren't a mirage..." CR CR>)>
	 <COND (<PRSO? ,P?NW>
		,RUINED-CASTLE-2)
	       (T
		,OASIS)>>

<ROOM WATTZ-UPP-DOCK
      (LOC ROOMS)
      (DESC "Wattz-Upp Dock")
      (LDESC
"This tiny dock is the maritime entrance to the once-famous Wattz-Upp section
of Mars. East of the dock is a wide, north-south canal; you can hear a gurgling
sound to the west. There's a chill in the air; you might be approaching the
south polar cap.")
      (NE SORRY "If you want to jump in the canal, say so.")
      (EAST SORRY "If you want to jump in the canal, say so.")
      (SE SORRY "If you want to jump in the canal, say so.")
      (WEST TO OASIS)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL CANAL-OBJECT DOCK-OBJECT WATER SIGN BUOY)
      ;(THINGS <PSEUDO (RED BUOY BUOY-F)
		      (WARNING BUOY BUOY-F)>)>

<ROOM OASIS
      (LOC ROOMS)
      (DESC "Oasis")
      (EAST PER WATTZ-UPP-DOCK-ENTER-F)
      (WEST PER MARTIAN-DESSERT-ENTER-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HOLE WATER DUNES)
      (HOLE-DESTINATION CLEVELAND)
      (ACTION OASIS-F)>

<ROUTINE WATTZ-UPP-DOCK-ENTER-F ()
	 <PUTP ,HOLE ,P?SDESC "black circle">
	 ,WATTZ-UPP-DOCK>

<ROUTINE MARTIAN-DESSERT-ENTER-F ()
	 <PUTP ,HOLE ,P?SDESC "black circle">
	 ,MARTIAN-DESSERT>

;<ROUTINE EASTERN-EDGE-OF-DESERT-ENTER-F ()
	 <PUTP ,HOLE ,P?SDESC "black circle">
	 ,EASTERN-EDGE-OF-DESERT>

<GLOBAL CIRCLE-BLACK T>

<GLOBAL CIRCLE-FADED <>>

<ROUTINE CIRCLE-ISNT-BLACK ()
	 <COND (<AND <NOT ,CIRCLE-BLACK>
		     <EQUAL? ,HERE ,OASIS>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE OASIS-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT ,CIRCLE-BLACK>>
		<PUTP ,HOLE ,P?SDESC "white circle">)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a remarkable sight on arid Mars -- subsurface water bubbling up in
a fountain, flowing around" A ,HOLE ", and soaking into the thirsty sand. A
path curves east around the " 'DUNES>
		<UNCHARTABLE-DESERT "west">)
	       (<EQUAL? .RARG ,M-END>
		<COND (,SIDEKICK-DROWNED
		       <MOVE ,SIDEKICK ,HERE>
		       <SETG SIDEKICK-DROWNED <>>
		       <TELL
"   Like a wet watermelon seed being squirted from between two fingers, "
D ,SIDEKICK " is ejected from the fountain and lands in a dripping heap at
your feet. \"Good thing I'm so good at holding my breath,\" ">
		       <HE-SHE>
		       <TELL " says." CR>)>
		<COND (<NOT ,CIRCLE-FADED>
		       <SETG CIRCLE-FADED T>
		       <SETG CIRCLE-BLACK <>>
		       <PUTP ,HOLE ,P?SDESC "white circle">
		       <TELL
"   Inexplicably, the circle fades before your very eyes, slowly going from
black to white." CR>)>)>>

<OBJECT RABBIT
	(LOC OASIS)
	(DESC "rabbit")
	(FDESC
"A little bunny rabbit is sipping at the waters of the oasis.")
	(SYNONYM RABBIT BUNNY)
	(ADJECTIVE BUNNY SMALL)
	(FLAGS TAKEBIT)>

<ROOM ICY-DOCK
      (LOC ROOMS)
      (DESC "Icy Dock")
      (LDESC
"This is the southern terminus of the canal. Far below this dock, teleportation
machinery transports massive quantities of water back to the head of the canal
in the equatorial region of Mars. It's quite chilly, and the dock is covered
with a sheet of ice. To the south, as far as you can see, is the bleak
whiteness of the southern ice cap.")
      (NORTH SORRY "If you want to jump in the canal, say so.")
      (NE SORRY "If you want to jump in the canal, say so.")
      (NW SORRY "If you want to jump in the canal, say so.")
      (SOUTH TO TUNDRA)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WATER DOCK-OBJECT CANAL-OBJECT)
      (ACTION ICY-DOCK-F)>

<ROUTINE ICY-DOCK-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,ICY-DOCK ,TOUCHBIT>>
		     <NOT <RUNNING? ,I-ION-DEATH>>>
		<INCREMENT-SCORE 4 14>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,SIDEKICK ,HERE>>
		<SETG FOLLOW-FLAG 3>
		<QUEUE I-FOLLOW 2>
		<REMOVE ,SIDEKICK>
		<SETG SIDEKICK-DROWNED T>
		<TELL "   With a whoop of surprise, " D ,SIDEKICK " loses ">
		<HIS-HER>
		<TELL
" footing on the ice, skids right into the canal, and is immediately dragged
under by the strong current produced by the underwater teleporters. You search
frantically for any sign of ">
		<HIM-HER>
		<TELL
", but after several agonizingly long minutes you abandon all hope. As you
gaze across " D ,SIDEKICK "'s watery grave">
		<MEMORIAM>)>>

<ROOM TUNDRA
      (LOC ROOMS)
      (DESC "Edge of Polar Ice Cap")
      (NORTH TO ICY-DOCK)
      (SOUTH TO ALLUSION-ROOM)
      (SE TO PENGUIN-PARK)
      (FLAGS RLANDBIT ONBIT)
      (ACTION TUNDRA-F)>

<ROUTINE TUNDRA-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This snowy plain is barren of all signs of life. Drifts block travel
in all directions but north, south and southeast. It's pretty cold, but
nothing a tough g">
		<COND (,MALE
		       <TELL "uy">)
		      (T
		       <TELL "al">)>
		<TELL " like yourself can't stand.">)>>

<ROOM ALLUSION-ROOM
      (LOC ROOMS)
      (DESC "Allusion Room")
      (LDESC
"A solitary black circle is the only break in an vaste expanse of whiteness
extending to the horizon. Like a dark speck in a sea of white, or a huge piece
of typing paper with but a single period typed upon it, this black circle seems
to have been placed here entirely as an opportunity for some silly literary
allusions. To avoid the danger of accidentally typing an \"L\" and having to
read them again, follow the faint trails to the north or east.")
      (NORTH TO TUNDRA)
      (NE SORRY "You'd only get lost in the snow and die.")
      (EAST TO PENGUIN-PARK)
      (SE SORRY "You'd only get lost in the snow and die.")
      (SOUTH SORRY "You'd only get lost in the snow and die.")
      (SW SORRY "You'd only get lost in the snow and die.")
      (WEST SORRY "You'd only get lost in the snow and die.")
      (NW SORRY "You'd only get lost in the snow and die.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HOLE)
      (HOLE-DESTINATION WATTZ-UPP-DOCK)>

<ROOM PENGUIN-PARK
      (LOC ROOMS)
      (DESC "Penguin Park")
      (WEST TO ALLUSION-ROOM)
      (NW TO TUNDRA)
      (SE TO GYPSY-CAMP IF PENGUINS-PARTED ELSE
	"There's a wall of penguins in the way.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL SIGN)
      (ACTION PENGUIN-PARK-F)>

<ROUTINE PENGUIN-PARK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"Even on Mars, one could hardly expect a polar visit without seeing penguins.
Well, here they are! A whole waddling mass of them, ">
		<COND (,PENGUINS-PARTED
		       <TELL "standing politely on either side of">)
		      (T
		       <TELL "a pack so dense they completely block">)>
		<TELL
" the path to the southeast. Other paths lead west and northwest.">
		<COND (<NOT ,PENGUINS-PARTED>
		       <TELL CR
"   One penguin teasingly waves a sign in your direction, much like
a matador waving his cape toward a bull.">)>
		<RTRUE>)>>

<GLOBAL PENGUINS-PARTED <>>

<OBJECT PENGUINS
	(LOC PENGUIN-PARK)
	(DESC "mass of penguins")
	(SYNONYM PENGUIN MASS BIRD BIRDS)
	(ADJECTIVE WADDLING)
	(FLAGS NDESCBIT)
	(ACTION PENGUINS-F)>

<ROUTINE PENGUINS-F ()
	 <COND (<VERB? GIVE>
		<COND (<PRSO? ,TEN-MARSMID-COIN>
		       <SETG PENGUINS-PARTED T>
		       <REMOVE ,TEN-MARSMID-COIN>
		       <MOVE ,ONE-MARSMID-COIN ,PROTAGONIST>
		       <TELL
"The penguins, satisfied by your donation to the PRF, part ranks for you to
pass. The going rate for donations to the fund must be nine marsmids, since
one of the penguins hands you a one marsmid coin." CR>)
		      (<PRSO? ,ONE-MARSMID-COIN>
		       <TELL
"Nine marsmids is the minimum contribution to the PRF." CR>)>)
	       (<AND <VERB? SHOW>
		     <PRSO? ,TEN-MARSMID-COIN>>
		<TELL "The penguins wiggle eagerly." CR>)>>

<ROOM GYPSY-CAMP
      (LOC ROOMS)
      (DESC "Gypsy Camp")
      (LDESC
"This is the campsite of a family of nomadic robotic gypsies. A ragged tent is
pitched on the north side of the camp, and trails lead northwest and south.")
      (SOUTH TO SOUTH-POLE)
      (NORTH TO TENT)
      (IN TO TENT)
      (NW TO PENGUIN-PARK)
      (FLAGS RLANDBIT ONBIT)
      (ACTION GYPSY-CAMP-F)
      ;(THINGS <PSEUDO (RAGGED TENT OUTSIDE-TENT-F)
		      (TATTERED TENT OUTSIDE-TENT-F)>)>

<OBJECT OUTSIDE-TENT
      (LOC GYPSY-CAMP) 
      (DESC "ragged tent")
      (SYNONYM TENT)
      (ADJECTIVE RAGGED TATTERED)
      (FLAGS NDESCBIT)
      (ACTION OUTSIDE-TENT-F)>

<GLOBAL PARENTS-KILLED <>>

<ROUTINE GYPSY-CAMP-F (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<NOT ,PARENTS-KILLED>
		       <SETG PARENTS-KILLED T>
		       <COND (<EQUAL? ,VERBOSITY 0>
			      <RTRUE>)>
		       <TELL
"   A male and a female robot emerge from the tent, waving in a gesture
of gypsyish greeting. \"Hello, weary traveller">
		       <COND (<IN? ,SIDEKICK ,HERE>
			      <TELL "s">)>
		       <TELL
"! We are but poor gypsies, but we invite you to spend the night in our humble
tent and share our simple but delicious oil and silicon stew.\" Suddenly, in
an event so shocking that even a hardened space opera hero">
		       <COND (<NOT ,MALE>
			      <TELL "ine">)>
		       <TELL
" like yourself is stunned beyond belief, a meteorite shrieks through the
atmosphere and completely obliterates the two robots." CR>)>
		<COND (<AND <IN? ,BABY ,TENT>
			    <NOT <IN? ,BLANKET ,BABY>>>
		       <TELL
"   You hear the sound of high-pitched crying, slightly muffled, coming from
inside the tent." CR>)>)>>

<ROUTINE OUTSIDE-TENT-F ()
	 <COND (<VERB? ENTER BOARD WALK-TO>
		<DO-WALK ,P?NORTH>)
	       (<VERB? EXIT LEAVE DISEMBARK>
		<TELL ,LOOK-AROUND>)
	       (<VERB? LOOK-INSIDE>
		<TELL ,CANT-FROM-HERE>)>>

<ROUTINE INSIDE-TENT-F ()
	 <COND (<VERB? EXIT LEAVE DISEMBARK>
		<DO-WALK ,P?SOUTH>)
	       (<VERB? ENTER BOARD WALK-TO>
		<TELL ,LOOK-AROUND>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<V-LOOK>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)>>

<ROOM TENT
      (LOC ROOMS)
      (DESC "Inside the Tent")
      (LDESC
"This tattered tent, home to the deceased robots, provides meager protection
against the cold polar winds. You can exit to the south.")
      (SOUTH TO GYPSY-CAMP)
      (OUT TO GYPSY-CAMP)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (ACTION TENT-F)
      ;(THINGS <PSEUDO (RAGGED TENT INSIDE-TENT-F)
		      (TATTERED TENT INSIDE-TENT-F)>)>

<OBJECT INSIDE-TENT
      (LOC TENT)
      (DESC "ragged tent")
      (SYNONYM TENT)
      (ADJECTIVE RAGGED TATTERED)
      (FLAGS NDESCBIT)
      (ACTION INSIDE-TENT-F)>

<ROUTINE TENT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<QUEUE I-CRY -1>)>>

<ROUTINE I-CRY ()
	 <COND (<IN? ,BLANKET ,BABY>
		<DEQUEUE I-CRY>
		<RFALSE>)
	       (<NOT <VISIBLE? ,BABY>>
		<RFALSE>)
	       (T
		<TELL "   The baby continues to wail at the top of its lungs.">
		<COND (<PROB 12>
		       <TELL
" It's amazing that such small lungs have such a high top.">)>
		<CRLF>)>>

<OBJECT BABY
	(LOC TENT)
	(SDESC "robot infant")
	(DESCFCN BABY-F)
	(SYNONYM BABY INFANT ROBOT)
	(ADJECTIVE INFANT ROBOT ROBOTIC SMALL BABY)
	(FLAGS TAKEBIT OPENBIT CONTBIT SEARCHBIT)
	(SIZE 35)
	(ACTION BABY-F)>

<ROUTINE BABY-F ("OPTIONAL" (OARG <>))
	 <COND (.OARG
		<COND (<FSET? ,BABY ,TOUCHBIT>
		       <RFALSE>)
		      (T
		       <COND (<EQUAL? .OARG ,M-OBJDESC?>
			      <RTRUE>)>
		       <TELL
"   A little baby robot is shivering in the corner. It stops crying long
enough to open a tiny metal eyelid and look at you. \"">
		       <COND (,MALE
			      <TELL "Momm">)
			     (T
			      <TELL "Dadd">)>
		       <TELL
"y?\" it says, in a quavering, high-pitched, metallic voice.">)>)
	       (<VERB? TELL>
		<COND (<IN? ,BLANKET ,BABY>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?KISS ,BABY>)
		      (T
		       <TELL "\"Goo goo ga ga buzz whirr click.\"" CR>)>
		<STOP>)
	       (<OR <AND <VERB? PUT>
			 <PRSI? ,BLANKET>>
		    <AND <VERB? PUT-ON WRAP>
			 <PRSO? ,BLANKET>>
		    <AND <VERB? PUT>
			 <PRSI? ,BASKET>
			 <IN? ,BLANKET ,BASKET>>>
		<COND (<FSET? ,BLANKET ,UNTEEDBIT>
		       <RFALSE>)
		      (<IN? ,BLANKET ,BABY>
		       <TELL ,SENILITY-STRIKES>
		       <RTRUE>)>
		<FSET ,BABY ,TOUCHBIT>
		<FSET ,BLANKET ,NDESCBIT>
		<MOVE ,BLANKET ,BABY>
		<COND (<PRSI? ,BASKET>
		       <MOVE ,BABY ,BASKET>)>
		<PUTP ,BABY ,P?SDESC "baby robot wrapped in a blanket">
		<DEQUEUE I-CRY>
		<TELL
"The baby stops crying and, in the comfy warmth of the blanket, slips into
a calm sleep. A peaceful smile creeps over its face." CR>)
	       (<OR <AND <VERB? PUT>
			 <PRSI? ,SHEET>>
		    <AND <VERB? PUT-ON WRAP>
			 <PRSO? ,SHEET>>>
		<COND (<OR <IN? ,BLANKET ,BABY>
			   <FSET? ,SHEET ,MUNGBIT>
			   <FSET? ,SHEET ,PLURALBIT>>
		       <WASTES>)
		      (T
		       <TELL "The sheet provides little warmth." CR>)>)
	       (<AND <VERB? PUT>
		     <PRSI? ,BASKET>
		     <IN? ,BASKET ,FRONT-STOOP>
		     <NOT <FIRST? ,BASKET>>>
		<COND (<IN? ,BLANKET ,BABY>
		       <MOVE ,BABY ,BASKET>
		       <ABANDON-BABY "in the basket">)
		      (T
		       <CRYING-ALERTS-MATRON>)>)
	       (<AND <VERB? REMOVE>
		     <IN? ,BLANKET ,BABY>>
		<MOVE ,BLANKET ,PROTAGONIST>
		<FCLEAR ,BLANKET ,NDESCBIT>
		<PUTP ,BABY ,P?SDESC "robot infant">
		<QUEUE I-CRY -1>
		<TELL "The baby robo" ,TWICE-AS-LOUD>
		<COND (<ULTIMATELY-IN? ,BABY ,FRONT-STOOP>
		       <TELL "   ">
		       <CRYING-ALERTS-MATRON>)>
		<RTRUE>)
	       (<VERB? KISS>
		<COND (<IN? ,BLANKET ,BABY>
		       <PERFORM ,V?ALARM ,BABY>
		       <RTRUE>)
		      (T
		       <TELL
"The " D ,BABY " reacts as a human baby would react if kissed by a giant
walking metal machine. In other words, i" ,TWICE-AS-LOUD>)>)
	       (<AND <VERB? LISTEN>
		     <NOT <IN? ,BLANKET ,BABY>>>
		<TELL "\"Waaaa!\"" CR>)
	       (<VERB? SHAKE>
		<COND (<IN? ,BLANKET ,BABY>
		       <TELL "The baby's asleep!" CR>)
		      (T
		       <TELL
"This upsets the " D ,BABY "'s equilibrium mechanism. I" ,TWICE-AS-LOUD>)>)
	       (<AND <VERB? ALARM>
		     <IN? ,BLANKET ,BABY>>
		<TELL
"The baby whimpers briefly, but the warm coziness of the blanket
soon lulls it back to sleep." CR>)
	       (<TAKE-BABY-FROM-STOOP ,BABY>
		<RTRUE>)
	       (<VERB? SUCKLE>
		<COND (,MALE
		       <TELL
"You're a male, remember? You obviously have a poor mammary." CR>)
		      (T
		       <TELL
"How touching that the baby robot has stirred your maternal instinct.
Unfortunately, your mammaries won't produce #3 machine oil." CR>)>)
	       (<AND <VERB? PUT PUT-NEAR> ;"for PUT BABY IN FRONT OF DOOR"
		     <PRSI? ,ORPHANAGE-DOOR>>
		<PERFORM ,V?PUT-ON ,BABY ,FRONT-STOOP>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "The " D ,BABY " is ">
		<COND (<IN? ,BLANKET ,BABY>
		       <TELL "sleep">)
		      (T
		       <TELL "cry">)>
		<TELL "ing." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL ,HUH>)>>

<ROUTINE CRYING-ALERTS-MATRON ()
	 <TELL "The baby's crying alerts someone within the igloo. ">
	 <SHOO "abandon">>

<ROUTINE SHOO (STRING)
	 <DEQUEUE I-ORPHANAGE>
	 <TELL
,MATRON-DESC "appears. \"Caught you, you baby-" .STRING "ing gypsy!\"
she cries, in a voice that, in a more mountainous region, could probably
initiate an avalanche. \"Begone!\" She ">
	 <COND (<ULTIMATELY-IN? ,BABY ,FRONT-STOOP>
		<TELL "thrusts the babe into your arms and ">)>
	 <COND (<IN? ,BASKET ,FRONT-STOOP>
	        <MOVE ,BASKET ,PROTAGONIST>)>
	 <COND (<ULTIMATELY-IN? ,BABY ,FRONT-STOOP>
		<MOVE ,BABY ,PROTAGONIST>)>
	 <TELL "drives you away with blows that would fell an elephant." CR CR>
	 <COND (<EQUAL? ,HERE ,ORPHANAGE-FOYER>
		<GOTO ,SOUTH-POLE>)
	       (T
	 	<GOTO ,GYPSY-CAMP>)>>

<CONSTANT MATRON-DESC
"A matronly woman of massive proportions and rather cubical aspect ">

<ROOM SOUTH-POLE
   (LOC ROOMS)
   (DESC "South Pole")
   (LDESC
"You are standing near the front stoop of a very large igloo. Its door is
flanked by a faded sign and a barred window. Paths lead north, north and
north.")
   (NORTH TO GYPSY-CAMP)
   (SOUTH SORRY "This is as far south as you can go!")
   (EAST SORRY "You walk in a tight circle, returning to your starting point.")
   (WEST SORRY "You walk in a tight circle, returning to your starting point.")
   (IN TO ORPHANAGE-FOYER IF ORPHANAGE-DOOR IS OPEN)
   (FLAGS RLANDBIT ONBIT)
   (GLOBAL SIGN IGLOO ORPHANAGE-DOOR WINDOW BARS)
   (ACTION SOUTH-POLE-F)
   ;(THINGS <PSEUDO (<> BAR WINDOW-F)
		   (<> BARS WINDOW-F)>)>

<OBJECT BARS
      (LOC LOCAL-GLOBALS)
      (DESC "barred window")
      (SYNONYM BAR BARS)
      (FLAGS NDESCBIT)
      (ACTION WINDOW-F)>

<ROUTINE SOUTH-POLE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     ,COTTON-BALLS-SEEN
		     <FSET? ,COTTON-BALLS ,TRYTAKEBIT>>
		<MOVE ,COTTON-BALLS ,HERE>
		<FSET ,COTTON-BALLS ,NDESCBIT>)>>

<GLOBAL COTTON-BALLS-SEEN <>>

<OBJECT ORPHANAGE-DOOR
	(LOC LOCAL-GLOBALS)
	(DESC "igloo door")
	(SYNONYM DOOR)
	(ADJECTIVE IGLOO ORPHANAGE)
	(FLAGS DOORBIT LOCKEDBIT VOWELBIT)
	(ACTION ORPHANAGE-DOOR-F)>

<ROUTINE ORPHANAGE-DOOR-F ()
	<COND (<AND <VERB? KNOCK>
		    <EQUAL? ,HERE ,SOUTH-POLE>>
	       <COND (<VISIBLE? ,BABY>
		      <SHOO "abandon">)
		     (T
	       	      <SHOO "steal">)>)>>

<OBJECT FRONT-STOOP
	(LOC SOUTH-POLE)
	(DESC "front stoop")
	(SYNONYM STOOP DOORSTEP)
	(ADJECTIVE FRONT)
	(CAPACITY 150)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT SURFACEBIT OPENBIT)
	(ACTION FRONT-STOOP-F)>

<ROUTINE FRONT-STOOP-F ()
	 <COND (<VERB? PUT PUT-ON PUT-NEAR>
		<COND (<AND <PRSO? ,BABY>
		     	    <NOT <IN? ,BABY ,BASKET>>>
		       <COND (<IN? ,BLANKET ,BABY>
		       	      <COLD-CAUSES-CRYING>)>
		       <MOVE ,PRSO ,FRONT-STOOP>
		       <CRYING-ALERTS-MATRON>)
		      (<AND <PRSO? ,BASKET ,BABY>
		     	    <IN? ,BABY ,BASKET>>
		       <COND (<NOT <IN? ,BLANKET ,BABY>>
		       	      <CRYING-ALERTS-MATRON>)
		      	     (T
		       	      <MOVE ,BASKET ,FRONT-STOOP>
		       	      <ABANDON-BABY "on the stoop">)>)>)
	       (<VERB? BOARD ENTER STAND-ON>
		<WASTES>)
	       (<AND <VERB? PUT>
		     <PRSO? ,BABY>>
		<COLD-CAUSES-CRYING>
		<CRYING-ALERTS-MATRON>)>>

<ROUTINE COLD-CAUSES-CRYING ()
	 <TELL
"As you place the baby on the cold doorstep, i" ,TWICE-AS-LOUD "   ">>

<ROUTINE ABANDON-BABY (STRING)
	 <QUEUE I-ORPHANAGE 5>
	 <MOVE ,PROTAGONIST ,HERE>
	 <SETG OHERE <>>
	 <TELL
"You place the baby gently " .STRING
" and sneak behind a nearby snowdrift." CR>>

<ROUTINE I-ORPHANAGE ()
	 <REMOVE ,BABY>
	 <REMOVE ,BASKET>
	 <FCLEAR ,ORPHANAGE-DOOR ,LOCKEDBIT>
	 <COND (<EQUAL? ,HERE ,SOUTH-POLE>
		<SETG FOLLOW-FLAG 15>
		<QUEUE I-FOLLOW 2>
		<TELL
"   " ,MATRON-DESC "opens the " 'ORPHANAGE-DOOR ". She coos over the baby
for a moment then carries it inside, closing the door behind her." CR>)
	       (T
		<RFALSE>)>>

<ROOM ORPHANAGE-FOYER
      (LOC ROOMS)
      (DESC "Orphanage Foyer")
      (NE PER IGLOO-ENTER-F)
      (NW PER IGLOO-ENTER-F)
      (SOUTH TO SOUTH-POLE IF ORPHANAGE-DOOR IS OPEN)
      (OUT TO SOUTH-POLE IF ORPHANAGE-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT INDOORSBIT)
      (GLOBAL ORPHANAGE-DOOR IGLOO WINDOW BARS)
      (ACTION ORPHANAGE-FOYER-F)
      ;(THINGS <PSEUDO (<> BAR WINDOW-F)
		      (<> BARS WINDOW-F)>)>

<ROUTINE ORPHANAGE-FOYER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		;<COND (<AND <NOT <FSET? ,HERE ,TOUCHBIT>>
			    <NOT <EQUAL? ,VERBOSITY 0>>>
		       <TELL ;"punted for space reasons"
"One of the many fantastical legends that abound in the universe states that
every time someone burps, a civilization is destroyed. While this is probably
just a silly myth, it is a fact that at the moment the primary sun of the
Smaldonus system exploded, wiping out the entire Smaldoni race, Wendell B.
Diddlehump was producing a tremendously loud and embarrassing belch while
delivering a keynote address at the seventeenth annual convention of the
Cotton Ball Manufacturers of America. By an extraordinary coincidence, the
only relic of Smaldoni civilization to survive the terrible fires of that
supernova was, inexplicably," A ,COTTON-BALLS ", which knocked about the
universe a while, finally ending up here in the" ,ELLIPSIS>)>
		<COND (<FSET? ,COTTON-BALLS ,TRYTAKEBIT>
		       <MOVE ,COTTON-BALLS ,HERE>
		       <FCLEAR ,COTTON-BALLS ,NDESCBIT>)>
		<COND (<NOT <QUEUED? ,I-ORPHANAGE-BOOT>>
		       <QUEUE I-ORPHANAGE-BOOT 5>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The igloo's front hall has rooms to the northeast and northwest. A barred
window is next to the ">
		<OPEN-CLOSED ,ORPHANAGE-DOOR>
		<TELL " door to the south.">)>>

<ROUTINE IGLOO-ENTER-F ()
	 <TELL "Nursery" CR>
	 <I-ORPHANAGE-BOOT>
	 <DEQUEUE I-ORPHANAGE-BOOT>
	 <RFALSE>>

<ROUTINE I-ORPHANAGE-BOOT ()
	 <COND (<EQUAL? ,HERE ,ORPHANAGE-FOYER>
		<TELL "   ">
		<SHOO "steal">
		<FCLEAR ,ORPHANAGE-DOOR ,OPENBIT>
	 	<FSET ,ORPHANAGE-DOOR ,LOCKEDBIT>)
	       (<AND <EQUAL? ,HERE ,SOUTH-POLE>
		     <FSET? ,ORPHANAGE-DOOR ,OPENBIT>>
		<TELL "   The " 'ORPHANAGE-DOOR " slams shut." CR>
		<FCLEAR ,ORPHANAGE-DOOR ,OPENBIT>
	 	<FSET ,ORPHANAGE-DOOR ,LOCKEDBIT>)
	       (T
		<FCLEAR ,ORPHANAGE-DOOR ,OPENBIT>
	 	<FSET ,ORPHANAGE-DOOR ,LOCKEDBIT>
		<RFALSE>)>>

<OBJECT COTTON-BALLS
	(DESC "pair of cotton balls")
	(NO-T-DESC "pair of coon balls")
	(SYNONYM PAIR BALL BALLS)
	(ADJECTIVE COTTON COON)
	(FLAGS TAKEBIT TRYTAKEBIT NDESCBIT PLURALBIT BURNBIT)
	(SIZE 2)
	(ACTION COTTON-BALLS-F)>

<ROUTINE COTTON-BALLS-F ()
	 <COND (<AND <EQUAL? ,HERE ,SOUTH-POLE>
		     <FSET? ,COTTON-BALLS ,TRYTAKEBIT>
		     <TOUCHING? ,COTTON-BALLS>>
		<CANT-REACH ,COTTON-BALLS>)
	       (<AND <VERB? TAKE>
		     <FSET? ,COTTON-BALLS ,TRYTAKEBIT>>
		<INCREMENT-SCORE 16 29 T>
		<FCLEAR ,COTTON-BALLS ,TRYTAKEBIT>
		<RFALSE>)
	       (<FSET? ,COTTON-BALLS ,UNTEEDBIT>
		<COND (<VERB? EXAMINE>
		       <TELL
"Let's just say that some poor male raccoon is speaking in a
particularly high-pitched voice." CR>)
		      (T
		       <RFALSE>)>)
	       (<AND <VERB? PUT PUT-ON> ;"the verb PLUG turns into PUT-ON"
		     <PRSI? ,EARS>>
		<COND (,GONE-APE
		       <TELL ,DEXTERITY>)
		      (T
		       <FSET ,COTTON-BALLS ,WORNBIT>
		       <FSET ,EARS ,MUNGBIT>
		       <MOVE ,COTTON-BALLS ,PROTAGONIST>
		       <TELL
,MUFFLED " have " D ,COTTON-BALLS " stuffed in " 'EARS ,PERIOD-CR>)>)
	       (<AND <VERB? REMOVE DISEMBARK> ;"TAKE OUT BALLS = DISEMBARK"
		     <FSET? ,COTTON-BALLS ,WORNBIT>>
		<COND (,GONE-APE
		       <PERFORM ,V?TAKE ,COTTON-BALLS>
		       <RTRUE>)>
		<OPEN-EYES-AND-REMOVE-HANDS>
		<FCLEAR ,COTTON-BALLS ,WORNBIT>
		<SENSE-AGAIN ,EARS>)
	       (<AND <VERB? PUT>
		     <PRSI? ,NOSE>>
		<TELL "The " 'COTTON-BALLS " is too itchy." CR>)>>

<OBJECT IGLOO
	(LOC LOCAL-GLOBALS)
	(DESC "igloo")
	(SYNONYM IGLOO ORPHANAGE)
	(ADJECTIVE LARGE)
	(FLAGS VOWELBIT)
	(ACTION IGLOO-F)>

<ROUTINE IGLOO-F ()
	 <COND (<VERB? ENTER WALK-TO BOARD>
		<COND (<EQUAL? ,HERE ,ORPHANAGE-FOYER>
		       <TELL ,LOOK-AROUND>)
		      (<EQUAL? ,HERE ,SOUTH-POLE>
		       <DO-WALK ,P?IN>)>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,SOUTH-POLE>
		       <TELL ,LOOK-AROUND>)
		      (T
		       <DO-WALK ,P?OUT>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,SOUTH-POLE>
		       <PERFORM-PRSA ,WINDOW>
		       <RTRUE>)
		      (T
		       <V-LOOK>)>)
	       (<VERB? SEARCH>
		<TELL ,NOTHING-NEW>)>>
;"HINTS for Leather Goddesses of Phobos"
;"modify ROUTINE FINISH in VERBS to include Hint"
;"Check HELP or HINT syntaxes to match V-HINT (and CLOCKER-VERBS)"
;"Make sure the Flag in the V-HINTS-OFF syntax is correct"

<FILE-FLAGS CLEAN-STACK?>

<GLOBAL HINTS-OFF -1>

<SYNTAX HELP = V-HINT>
<VERB-SYNONYM HELP HINT HINTS CLUE CLUES INVISICLUES>
<SYNTAX HELP OFF OBJECT (FIND RLANDBIT) = V-HINTS-NO>

<CONSTANT RETURN-SEE-HINT " RETURN = see hint">
<CONSTANT RETURN-SEE-HINT-LEN <LENGTH " RETURN = see hint">>
<CONSTANT Q-MAIN-MENU "Q = main menu">
<CONSTANT Q-MAIN-MENU-LEN <LENGTH "Q = main menu">>
<CONSTANT INVISICLUES "INVISICLUES (tm)">
<CONSTANT INVISICLUES-LEN <LENGTH "INVISICLUES (tm)">>
<CONSTANT Q-SEE-HINT-MENU "Q = see hint menu">
<CONSTANT Q-SEE-HINT-MENU-LEN <LENGTH "Q = see hint menu">>
<CONSTANT Q-RESUME-STORY "Q = Resume story">
<CONSTANT Q-RESUME-STORY-LEN <LENGTH "Q = Resume story">>
<CONSTANT PREVIOUS "P = Previous">
<CONSTANT PREVIOUS-LEN <LENGTH "P = Previous">>

<GLOBAL LINE-TABLE		;"zeroth (first) element is 5"
	<PTABLE
	  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22>>

<CONSTANT COLUMN-TABLE		;"zeroth (first) element is 4"
	<PTABLE
	  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4  4>>

; "If the first argument is non-false, build a parallel impure table
   for storing the count of answers already seen; make it a constant
   under the given name."

<DEFINE20 CONSTRUCT-HINTS (COUNT-NAME "TUPLE" STUFF "AUX" (SS <>)
			   (HL (T)) (HLL .HL) V
			   (CL (T)) (CLL .CL)
			   TCL TCLL)
   <REPEAT ((CT 0))
     <COND (<OR <EMPTY? .STUFF>
		<TYPE? <1 .STUFF> STRING>>
	    ; "Chapter break"
	    <COND
	     (<NOT .SS>
	      ; "First one, just do setup"
	      <SET SS .STUFF>
	      <SET TCL (T)>
	      <SET TCLL .TCL>
	      <SET CT 0>)
	     (T
	      <SET V <SUBSTRUC .SS 0 <- <LENGTH .SS> <LENGTH .STUFF>>>>
	      ; "One chapter's worth"
	      <SET HLL <REST <PUTREST .HLL (<EVAL <FORM PLTABLE !.V>>)>>>
	      <COND (.COUNT-NAME
		     <SET CLL <REST <PUTREST .CLL
					     (<EVAL <FORM TABLE (BYTE)
							  !<REST .TCL>>>)>>>
		     <SET TCL (T)>
		     <SET TCLL .TCL>
		     <SET CT 0>)>
	      <SET SS .STUFF>)>
	    <COND (<EMPTY? .STUFF> <RETURN>)>
	    <SET STUFF <REST .STUFF>>)
	   (T
	    <COND (.COUNT-NAME
		   <COND (<1? <MOD <SET CT <+ .CT 1>> 2>>
			  <SET TCLL <REST <PUTREST .TCLL
						   (0)>>>)>)>
	    <SET STUFF <REST .STUFF>>)>>
   <COND (.COUNT-NAME
	  <EVAL <FORM CONSTANT .COUNT-NAME
		      <EVAL <FORM PTABLE !<REST .CL>>>>>)>
   <EVAL <FORM PLTABLE !<REST .HL>>>>

;"longest hint topic can be 17 chars"
;"longest question can be 36 chars."
;"question can't have more than 32 answers"

<CONSTANT HINTS
  <CONSTRUCT-HINTS HINT-COUNTS ;"Put topics in Quotes - followed by PLTABLEs
				 of Questions and Answers in quotes"
	"JOE'S BAR"
	<PLTABLE "How can I get out of the bar area?"
		 "There's no way to leave the bar through the front door."
		 "There's another way to leave, but you won't be able to until you've relieved your bladder."
		 "Just enter the bathroom of your choice (NW or NE), relieve yourself, then wait for a few turns.">
	<PLTABLE "This section sure was short huh?"
		 "Yup.">
	"PRISON AREA"
	<PLTABLE "How can I get out of my cell?"
		 "You're gonna feel pretty silly when you get to the next hint."
		 "Try OPEN THE DOOR.">
	<PLTABLE "Is the hunk of brown food important?"
		 "Smell it."
		 "You could try eating the chocolate to see what happens..."
		 "...but since you're not hungry, it's probably best to hang onto it until you need it.">
	<PLTABLE "Can I avoid the Leckbandi guards?"
		 "Just don't go east or west from End of Hallway.">
	<PLTABLE "Is Trent/Tiffany important?"
		 "You'll never finish the story without him/her."
		 "Once you've met in the Other Cell, he/she will follow you around. The places where he/she can help you will be revealed in the hints to other questions.">
	<PLTABLE "Is there a way to light the Closet?"
		 "Sure. Turn on the flashlight.">
	<PLTABLE "Can I get the basket off the shelf?"
		 "There are two ways. Both involve increasing your height."
		 "If you brought the stool from the bathroom, you can get the basket by standing on it."
		 "Otherwise, find Trent/Tiffany. When he/she follows you into the Closet, climb on him/her.">
	<PLTABLE "How can I leave the prison area?"
		 "The answer has something to do with the black circles on the Roof and in the Closet."
		 "They're teleportation devices. Standing on them transports you elsewhere.">
	<PLTABLE "Is the basement important?"
		 "No."
		 "This space intentionally left blank.">
	<PLTABLE "Is the scrap of paper meaningful?"
		 "Yes, it's a word search."
		 "It will become more meaningful once Trent/Tiffany gives you the matchbook with the parts list on it."
		 "Search for the items on the parts list within the grid of letters on the scrap of paper. As you find each of the eight items, circle or cross off its letters."
		 "When you've crossed off the letters of all the items, the remaining letters in the grid form a message."
		 "Namely: HISSING FRIGHTENS FLYTRAPS."
		 "This is one of two methods of getting past the Venus flytrap. Just HISS when you're in the same location as the flytrap.">
	"VENUS"
	<PLTABLE "How do I get past the Venus flytrap?"
		 "There are two ways. The more straightforward way is to kill it. The knowledge of how to kill it comes from the scrap of paper in Trent/Tiffany's cell. See the \"scrap of paper\" question from the PRISON AREA section."
		 "A second way to get past the flytrap is to trap it."
		 "Don't go on unless you've been to Cleveland."
		 "You can set a trap at the tree hole (Fork, Of Sorts) using stuff you've seen in Cleveland."
		 "Put the trellis over the tree hole..."
		 "...and the leaves over the trellis."
		 "If the flytrap sees you setting the trap, it won't fall for it, and therefore won't fall into it. \"Shake off\" the flytrap by going to the Clearing. Then return to the tree hole, set the trap, go to the Jungle to attract the flytrap again, and finally return to the fork and wait a few turns.">
	<PLTABLE "Is the untangling cream important?"
		 "Yes."
		 "Don't go on unless you have the odd machine."
		 "Don't go on unless you understand what the odd machine does."
		 "Have you seen any use for unangling cream?"
		 "It's on Mars..."
		 "It's in the Ruined Castle area..."
		 "See the question about King Mitre.">
	<PLTABLE "How can I get out of the tree hole?"
		 "There's no reason to ever get into the tree hole."
		 "But if you do, you can climb out by standing on the stool or by standing on Trent/Tiffany. If you don't have the stool, or if you're alone, you're stuck.">
	<PLTABLE "What is the can of stain for?"
		 "Have you read what it says on the can?"
		 "It's for staining those black circles black. Of course, it's possible that all the ones you've seen are already black."
		 "See the question about the white circle at the Oasis in the Mars section.">
	<PLTABLE "What do I barter to get the machine?"
		 "There are no clues in the story about this. You'll have to try everything you can find."
		 "OFFER THE FLASHLIGHT TO THE SALESMAN.">
	<PLTABLE "How does the odd machine work?"
		 "Have you examined it?"
		 "You can put one item at a time in its compartment."
		 "You can only turn it on while it's closed."
		 "It's a TEE remover. Think about that for a while."
		 "Try using the odd machine on a number of different items."
		 "The odd machine removes any \"T\" from the name of the thing you use it on."
		 "For example, open the odd machine. Put the basket in it. Close the machine. Turn it on. Open it. You'll find that the basket has been turned into a baske."
		 "You'll also find that you can't carry things around in a baske the way you could in a basket."
		 "The odd machine is a lot of fun, but it's also needed to solve one puzzle. You'll find out more when you get to that puzzle.">
	<PLTABLE "Can I get into the house?"
		 "The doors are locked and you cannot unlock them."
		 "How would you normally get into someone's house?"
		 "Knock on the door (either front or back).">
	<PLTABLE "How do I get the hose from the cage?"
		 "Have you tried to bend the bars?"
		 "You'll go ape solving this puzzle."
		 "WAIT a bit once you've gotten to the Laboratory."
		 "You end up switching identities with the gorilla of your sex, and can now easily get the rubber hose. But, unfortunately, you're now trapped in the cage and in the body of a gorilla! See the next question.">
	<PLTABLE "I'm stuck in the cage as a gorilla!"
		 "Have you tried to bend the bars as a gorilla?"
		 "You need a little more energy..."
		 "...like you might get from a sugar rush..."
		 "...from eating the chocolate you were given in your cell!"
		 "Before the mad scientist straps you down to the slab, give the chocolate to one of the gorillas, or just put it in the cage."
		 "Wait until the mad scientist transfers you to the body of the gorilla and leaves the room. (You can facilitate his leaving by getting erotic with your mate.) Now, eat the chocolate, bend the bars, and leave the cage with the rubber hose."
		 "You still need to get back into your own body, of course. How did the mad scientist cause the transfer?"
		 "The red power switch, of course! Throw the switch and you'll be back in your own body."
		 "But don't forget to untie yourself first, or you'll be trapped on the slab when you get back in your own body!">
	<PLTABLE "Is the Vizicomm Booth important?"
		 "Yes."
		 "It's broken and can't be repaired, so you can't make any calls. But there's something you can get in the booth."
		 "Push the coin return knob..."
		 "...then look in the coin return box."
		 "This ten marsmid coin will come in very handy.">
	<PLTABLE "How can I get off Venus?"
		 "Using the black circle at the Rocky Clifftop."
		 "There's also a black circle beyond the flytrap.">
	"MARS - RUINS AREA"
	<PLTABLE "What should I do about the frog?"
		 "You won't be able to solve this puzzle until you've been around a bit. To other sections of the story, that is."
		 "Examine the frog."
		 "The frog is an enchanted prince or princess."
		 "What's the usual way to break such an enchantment?"
		 "Kiss the frog."
		 "Repelled by the sight of the frog, eh? Do something about it."
		 "Type CLOSE MY EYES or COVER MY EYES WITH MY HANDS. Now try kissing the frog."
		 "Now it's the smell of the frog that's causing the problem."
		 "So, hold your nose. (If you're using your hands to cover your eyes, you can pin your nose with the clothes pin from the Laundry Room.) Kiss again."
		 "Oh well. Now it's the sound of the frog."
		 "Cover your ears with your hands. (If you're already using your hands, you could plug your ears with the cotton balls from the Orphanage Foyer.)"
		 "You say you still haven't scored with the frog? Can't stand the thought of the frog's lips against yours? Seen any dead aliens?"
		 "Put the lip balm on your lips. Now kiss the frog again.">
	<PLTABLE "How can I catch the mouse?"
		 "Mice are terrified of cats."
		 "There's a painting of a cat in your Cell."
		 "Show the painting to the mouse. You will be able to take the mouse until its fright wears off several turns later.">
	<PLTABLE "ASK ABOUT KING MITRE AND THE ANGLES"
		 "You can't use multiple objects with \"ask.\" Hey, King Mitre and the Angles -- sounds like a 50's rock and roll group, huh? But seriously, Mitre is obviously pretty dejected. Do you know why?"
		 "Because he's turned his daughter into a 45 degree angle. (She's the angle with the golden hair and satin robes.)"
		 "I bet that if you found a way to \"cure\" her, the King would be VERY grateful."
		 "You won't be able to solve the Mitre puzzle until you've defeated the Venus flytrap."
		 "It has something to do with the odd machine."
		 "See the question about the untangling cream in the Venus section."
		 "Put the unangling cream on the princess to \"cure\" her.">
	"ALONG THE CANAL"
	<PLTABLE "How can I control the royal barge?"
		 "Examine the controls. Read the buttons. Try pushing them."
		 "The orange button turns the magnetic mooring mechanism on or off. If you're docked, pushing the orange button will send you off into the canal. If you're in the canal near a dock, turn on the MagnetoMoor to dock. If you're in the canal but not near a dock, turning on the MagnetoMoor will have no immediate effect -- but if you subsequently pass a dock, you'll dock at it automatically."
		 "The purple button turns the engines on or off. When the button reads \"Full Spead Ahead\" the engines are on, and the barge will move to a new canal location every turn. When the button reads \"Go With The Flow\" the engines are off, and the barge will move to a new canal location only every other turn.">
	<PLTABLE "How can I decode the coded message?"
		 "Reread \"The Adventures of Lane Mastodon #91.\""
		 "Look at the center-left panel on Page 5 of the comic. This tells you how to decode Martian messages."
		 "One additional catch: once you've decoded the message you also have to read it backwards! (Including the number.)">
	<PLTABLE "How do I get to the other dock?"
		 "At the place in the canal where two docks are directly opposite each other, you can get to either dock using the barge, but not both in the same play-through of the story. Once the barge has docked at one of the docks, there's no way to get the barge to the other dock."
		 "You should use the barge to get to the dock on the east bank."
		 "It has something to do with the barge controls and the river current."
		 "Control the barge's speed with the purple button. When the engines are on, the barge will make a wider turn and end up near the east bank. With the engines off, you'll drift around the bend and end up near the west bank."
		 "Later, to get to the dock on the west side of the canal, you'll need something from the palace area."
		 "Use the raft from the Catacombs. (Teleport to the ruined castle region, put the raft in the water, get in the raft, and drift until you're at Donald Dock or the Abandoned Dock.)">
	<PLTABLE "How can I land if I'm in the raft?"
		 "You can only land when you're near a dock. To do so, just GRAB THE DOCK.">
	<PLTABLE "Can I do anything at the Dunetop?"
		 "No. It's just a view of what's beyond the bend in the canal.">
	<PLTABLE "Can I do anything at Canalview Mall?"
		 "The only interesting thing is the Exit Shop.">
	<PLTABLE "How can I buy an exit?"
		 "You won't have what it takes until you've been to several different parts of the story."
		 "You need to have been to Venus..."
		 "...and gotten the coin from the Vizicomm Booth."
		 "However, the proprietor will only accept a one marsmid coin."
		 "You also need to have been to the South Pole..."
		 "...and \"traded\" coins with the penguins."
		 "Now just give the one marsmid coin to the proprietor."
		 "When he drops the tube into the dust, simply search the dust."
		 "The exit is inside the tube! It's a portable black circle! It must be on the ground to function.">
	<PLTABLE "What does the buoy mean?"
		 "There's danger further down the canal.">
	<PLTABLE "How does the white circle work?"
		 "It's just like the black circles you've seen, only it's faded to white. Try stepping on it."
		 "I guess they only work when they're black."
		 "Have you been to Venus?"
		 "You'll need the can of stain from the Clearing."
		 "Put the stain on the white circle. It will now function as a normal black circle.">
	<PLTABLE "Is the rabbit important?"
		 "No."
		 "Eh...What's up, Doc?">
	<PLTABLE "Can I get past the ion beam safely?"
		 "Yes."
		 "There's no way to turn off the beam, and no way to pass through that section of the canal without being affected."
		 "There is, however, a way to \"jump past\" the beam."
		 "Have you been in the room off the Catacombs called Well Bottom or climbed down the well in the Oriental Garden?"
		 "Where does this black circle take you?"
		 "If you said \"My Kinda Dock,\" you're wrong!"
		 "The black circle at Well Bottom takes you to the royal barge, wherever it is!"
		 "Examine the barge while standing on a dock."
		 "Have you realized that you can push the buttons on the barge while standing on the dock?"
		 "From My Kinda Dock, send the barge downstream by pressing the orange button while standing on the dock. Wait long enough to allow the barge to pass the beam. Now go to Well Bottom and step on the black circle, or climb down the well in the Oriental Garden.">
	"SULTAN'S PALACE"
	<PLTABLE "What do I do in the Laundry Room?"
		 "Get the clothes pin.">
	<PLTABLE "Is the Oriental Garden important?"
		 "The well is somewhat interesting. Look into it."
		 "Try climbing down it.">
	<PLTABLE "What should I do at the Minaret?"
		 "Nice view. There's also a black circle."
		 "Hey, wait a minute! It takes me to a place with no exits."
		 "Like I said, wait a minute! The floor will collapse, creating an exit from the Cramped Space, and revealing a new black circle, as well!"> 
	<PLTABLE "Help! The Sultan/Sultaness kills me."
		 "Maybe you didn't answer when he/she asked if you were ready for the riddle. Type ANSWER \"YES\"."
	         "Maybe you didn't give an answer to the riddle! You have only three turns to do so.">
        <PLTABLE "The Sultan(ess) kills Trent/Tiffany!"
		 "Don't worry about it.">
	<PLTABLE "What is the answer to the riddle?"
		 "The riddle is designed to mislead you into thinking that the answer is something like \"SEX\" or \"LOVE\"."
		 "However, it IS something intangible."
		 "It's something you've encountered in the game."
		 "In fact, it's something you encountered in the palace area."
		 "In fact, it's something you've encountered in this very room (the Audience Chamber)!"
		 "The answer to the riddle is the riddle! Type ANSWER \"RIDDLE.\"">
	<PLTABLE "What number should I give the guard?"
		 "I hope you've been to Among the Dunes."
		 "Have you deciphered the message?"
		 "Ask for the husband/wife number mentioned in the message. Remember that the message is backwards, and so is the number. Type ANSWER \"123\" or ASK GUARD FOR 789 (for example).">
	<PLTABLE "What should I do in the Inner Harem?"
		 "Do you really have to ask me?"
		 "If you've asked for the correct husband/wife (see the previous question), you should know what to do."
		 "Ask him/her to do what the secret message tells you to ask.">
	<PLTABLE "It's too dark in the Catacombs!"
		 "Take the torch that the husband/wife lays at your feet, you ninny! Or use the flashlight, if you still have it.">
	<PLTABLE "How do I navigate the Catacombs?"
		 "Use the secret map, which the husband/wife gives you, which is also the map that comes in your LGOP package."
		 "There's an arrow on the \"Lower Level\" side which shows you the point at which you enter the Catacombs."
		 "The map is very old, however. Since it was made, many of the passages have collapsed into rubble, blocking your way. You have to figure out which ones are blocked and which are still open."
		 "There are four interesting locations within the Catacombs; these are shown on the map as squares rather than circles."
		 "If you are still stuck, or can't figure it out, look at the \"I'm really stuck\" question.">
	<PLTABLE "I get attacked in the Catacombs!"
		 "Reread \"The Adventures of Lane Mastodon #91\"."
		 "Specifically, the lower left panel on page 7."
		 "Do what Professor Ziggeraut suggests, as often as he suggests, if not more often. (You can assume that one turn equals one minute).">
	<PLTABLE "How can I get out of the Catacombs?"
		 "Via the ladder in the Ladder Room, or the black circle in the Well Bottom.">
	<PLTABLE "What should I do in the Catacombs?"
		 "You need to get the phone book (one of the items on the parts list) from the Forgotten Storehouse, and you need to get the raft (see the question, earlier in this section, about the two docks on opposite sides of the canal).">
	<PLTABLE "Help!!! I'm really stuck. I give up."
		 "Don't go further unless you just want us to tell you exactly what to type to get through the catacombs."
		 "These explicit directions start from having gone DOWN to enter the catacombs. They assume you have a light source and can pick up two more objects."
		 "NW. N. NE. E. CLAP"
		 "NE. NE. SE. HOP. CLAP"
		 "KWEEPA. D. NW. NE. CLAP"
		 "N. S. HOP. NE. CLAP"
		 "U. KWEEPA. NW. GET DIRECTORY. CLAP"
		 "NW. HOP. S. SE. CLAP"
		 "SE. D. KWEEPA. NE. CLAP"
		 "W. E. W. SW. CLAP"
		 "SW. GET RAFT. HOP. KWEEPA. CLAP"
		 "N. NE. E. NW. CLAP"
		 "CLAP. N. UP"
		 "We're done!!! CLAP. CLAP. CLAP"
		 "If you don't want to type all those directions we've put in something special for those of you who are fed up with clapping, etc."
		 "The turn after you've gone down into the catacombs (but haven't moved) type $CATACOMB to cheat your way through. You'll end up at the Ladder Room with the raft and the Cleveland telephone directory."
		 "You're welcome.">
	"SOUTH POLE"
	<PLTABLE "I lost Trent/Tiffany at Icy Dock!"
		 "Don't worry about it.">
	<PLTABLE "How can I get past the penguins?"
		 "Read the sign."
		 "You'll need something from Venus."
		 "Give the coin from the Vizicomm Booth to the penguins.">
	<PLTABLE "How can I save the gypsies?"
		 "You can't."> 
	<PLTABLE "What should I do with the baby?"
		 "Its parents have been killed."
		 "That makes it an orphan. Perhaps you can find an orphanage somewhere.">
	<PLTABLE "How can I get into the igloo?"
		 "Read the sign."
		 "Have you seen anything that might interest those running an orphanage?"
		 "The baby from the Tent in the Gypsy Camp."
		 "The matron of the orphanage will never accept an abandoned baby if the abandoner is in sight. You'll have to figure out a way to abandon the baby and get away."
		 "Certainly, getting the baby to stop crying is important."
		 "There's a cliched method of abandoning a baby."
		 "You'll need a couple of items from the prison area."
		 "Wrap the baby in the blanket (from your Cell). Then put the baby in the basket (from the Closet)."
		 "Now put the basket on the front stoop of the igloo. Wait a few turns."
		 "When the matron gets the baby, she forgets to lock the door. You can now open it. Once inside, you have a few turns to grab the cotton balls before the matron discovers you.">
	<PLTABLE "What's the geography near the igloo?"
		 "You're at the south pole of Mars. The only direction you can go from a south pole is north! To enter the igloo, type ENTER THE IGLOO.">
	"CLEVELAND"
	<PLTABLE "Is the rake useful?"
		 "The rake is completely useless.">
	<PLTABLE "How about the sack?"
		 "The sack is necessary only to carry the leaves around. It's also useful for carrying things once you reach the limit of individual items that you can hold at once.">
	<PLTABLE "Well then, what about the leaves?"
		 "The leaves are important for solving one puzzle."
		 "You find out more when you come to the particular puzzle.">
	<PLTABLE "How do I get the telephone directory?"
		 "Don't go on until you've been in Basement of House."
		 "Have you opened the trunk labelled \"Old Appliances\"?"
		 "Surely you examined the boomerang!"
		 "Can we assume that you thoroughly interrogated Winston Churchill and Attila the Hun?"
		 "Have you realized that this is one of those fake questions designed to keep you from reading hints to puzzles you're not stumped on? There's no basement in Cleveland!">
	 <PLTABLE "Where's the Cleveland phonebook?"
		  "It's not anywhere in Cleveland."
		  "When you get there, the phonebook will be obvious."> 
	 <PLTABLE "Is there anything in the bedroom?"
		  "Have you looked out the window?">
	 <PLTABLE "How can I get the headlight?"
		  "There's no way to access the Ford other than via the Bedroom window."
		  "The sheet on the bed isn't long enough, and there's not a rope to be found."
		  "Seen any good prison escape movies lately?"
		  "You can MAKE a rope from the sheet!"
		  "You'll have to tear the sheet first."
		  "Tie the resulting strips together."
		  "Tie the rope to the bed then throw it out the window."
		  "If YOU climb down the rope, it breaks and you die. However, if Trent/Tiffany is with you, he/she seems willing to take the risk! Just wait a turn.">
	 <PLTABLE "Trent/Tiffany got killed by a truck!"
		  "Jolly bad show, but things are not always as they appear."
		  "WAIT another turn after the \"accident.\"">
	 <PLTABLE "Can I stop the brakes from failing?"
		  "Sure. Get the brakes a good tutor."
		  "But seriously, folks, when did your brakes fail? There's no way to get to the car, let alone get into it, let alone start it, let alone experience a brake failure. This is a fake question.">
	 <PLTABLE "What can I do in the Garden?"
		  "There are several interesting items in the Garden."
		  "The flowers, however, are not one of them."
		  "You might want to snatch the trellis, though."
		  "Also, see the next question.">
	 <PLTABLE "HELP! How do I get out of Cleveland?"
		  "Millions ask this question daily."
		  "There's an exit in the garden."
		  "EXAMINE THE SOD."
		  "LOOK UNDER IT."
		  "ROLL IT UP! Voila, a black circle.">
	 "OUTER SPACE"
	 <PLTABLE "When I reach the Hold, I'm blown up!"
		  "Don't step on the black circle in the Spawning Ground unless Trent/Tiffany is with you.">
	 <PLTABLE "Trent/Tiffany gets blown up!"
		  "Don't worry about it."
		  "See the question in this section about what to do after saving the young man/woman.">
	 <PLTABLE "Is the stallion useful?"
		  "Yes."
		  "You can ride him."
		  "Mount the horse then type the direction you want to go."
		  "Only by riding the horse can you reach the hatch at the other end of the Long Corridor before the other spaceship blasts away. (See the next question.)">
	 <PLTABLE "What is that rumbling noise?"
		  "Have you looked through the window in the Hold?"
		  "Try being in the Hold when the rumbling noise occurs."
		  "It's the small passenger yacht leaving. You must get to it before it leaves."
		  "But the only exit from this battleship is down at the other end of that Long Corridor."
		  "You can't walk to the hatch in time to get to the other ship before it rumbles away."
		  "But you can make it in time if you ride a horse!">
	 <PLTABLE "I keep dying from the cold In Space."
		  "You missed something obvious."
		  "You need to wear the therma-suit you'll find At Main Hatch.">
	 <PLTABLE "How do I get past Thorbast/Thorbala?"
		  "You'll never get past while he's/she's alive."
		  "Try killing him/her with the sword from the Hold."
		  "Thorbast/Thorbala is a tough opponent, but after several attempts to kill him/her with your sword you will succeed in knocking Thobast's/Thorbala's sword out of his/her hands. Take it as it floats toward you, disarming Thorbast/Thorbala."
		  "Trying to kill Thorbast/Thorbala at this point is the wrong move, however. Thorbast/Thorbala is just too quick for you, even disarmed. Have you ever noticed that you're dressed all in white, and Thorbast/Thorbala all in black?"
		  "What would the \"good guy\" in any sword fight do upon disarming his/her opponent?"
		  "Once you're holding Thorbast's/Thorbala's sword, give it to him/her."
		  "You must get Thorbast/Thorbala to \"give up\" before the bug-eyed monster carries away the young man/woman.">
	 <PLTABLE "How can I save the young man/woman?"
		  "You'll have to get past Thorbast/Thorbala first."
		  "Once you've done that, it's easy!"
		  "Just kill the monster. Even your bare hands are sufficient."
		  "Then, don't forget to untie the young man/woman.">
	 <PLTABLE "What about after saving him/her?"
		  "He/she enters the small spaceship and beckons you to follow."
		  "So follow!"
		  "Once you enter the Space Yacht, Elysia/Elysium will give you the photo you need. And when you return to the battleship, you may have an unexpected meeting!">
	 <PLTABLE "How can I land on Titan safely?"
		  "A ship this size must have an auto-pilot."
		  "It's probably behind the panel in the Control Room."
		  "Did you turn the auto-pilot on?"
		  "Perhaps it can be repaired by the French robot."
		  "See the question about gourmet cooking in the section called \"The Planet of the Snobby Robot Chefs.\""
		  "No section by that name? Perhaps, then, you should not look at questions except those relating to puzzles you're stumped by.">
	 <PLTABLE "How do I exit the spaceship?"
		  "There's a black circle aboard the battleship."
		  "It's in the third Long Corridor location west of the Stable.">
	 "NEPTUNE"
	 <PLTABLE "Is there any way to light the cave?"
	          "Probably."
		  "But considering the \"interests\" of the creature who lives in the cave, would you really want to ruin things by bringing a light?">
	 <PLTABLE "Is the love potion useful?"
		  "Surely you've met someone who's not as interested in you as you are in him/her."
		  "It's someone in the Mine Shaft City."
		  "Natasha/Ivan seems pretty aloof, wouldn't you say?"
		  "Put the love potion in her/his vodka."
		  "Don't put it in the orangutang's milk by accident.">
	 <PLTABLE "Help! I can't keep the baboons away!"
		  "Let's face it, you just have animal magnetism."
		  "Have you ever wondered what the extra machine on your spacesuit was?"
		  "It's an animal magnet! Switch it off."
		  "The vaseline will help loosen the switch."
		  "Once the monkeys have stopped bothering you, the bouncer will let you into the bordello.">
	 <PLTABLE "How do I avoid the Throbber Rays?"
		  "You'll need the germanium shielding from Mercury."
		  "You'll also need some fruit from the orchard on Io."
		  "And you'll definitely need the makeup kit from the transvestites on Ceres."
		  "But mostly, you'll need to ignore answers to questions you're not stuck on.">
	 "BOUDOIR/PLAZA"
	 <PLTABLE "What's the Boudoir and what do I do?"
		  "You find out more about the Boudoir a few turns after your arrival. Meanwhile, why not \"enjoy\" the company of your divan-mate?"
		  "At long last, you have come face to face with your archenemies, the Leather Goddesses of Phobos!">
	 <PLTABLE "I'm in the Plaza. What do I do here?"
		  "If Trent/Tiffany isn't with you, not much."
		  "It's time for Trent/Tiffany to build his/her Super-Duper Anti-Leather Goddesses of Phobos Attack Machine. Just give him/her whatever item from the parts list he/she asks for. You must do this immediately...you can't spare a single turn."
		  "If you got to the Plaza without all eight items from the parts list, you're lost. You'll have to RESTART (or RESTORE) and collect them all before returning."
		  "If you give the eight items to Trent/Tiffany at the right moments, you will WIN THE GAME! Yow!!!">
	 "GENERAL QUESTIONS"
	 <PLTABLE "What's my goal in this story?"
		  "You'll get a better idea once you've met Trent/Tiffany."
		  "A few dozen turns after meeting him/her, Trent/Tiffany will give you something."
		  "This matchbook contains a parts list for the items that Trent/Tiffany needs to build a machine that will defeat the Leather Goddesses."
		  "Therefore, your goal is to find these eight items, and then get to a location where Trent/Tiffany can build the machine.">
	 <PLTABLE "How can I change my gender?"
		  "You determine the sex of your character by entering either the Men's Room or the Ladies' Room in the bar. Once you've established your gender, you can't change it without restarting.">
	 <PLTABLE "How does the scoring work?"
		  "You always get points at given places in the story, but there are elements of randomness."
		  "For one thing, you don't always get the same number of points each time you reach the same point in the story. For example, for reaching the prison cell on Phobos, you will get somewhere between 1 and 8 points."
		  "Another element of randomness: when you use the STATUS command, you are told the total points that your score is \"out of.\" This number starts at 9309, but decreases randomly each time you get points."
		  "Your points increase and your \"out of\" number decreases, until they finally meet on the final turn of the story."
		  "This is all designed to confuse you, of course.">
	 <PLTABLE "It won't let me into LEWD mode."
		  "You must be at least 18 years old."
		  "If you are, just type 18 (or whatever) when prompted to input your age. If you're not, you simply can't play in LEWD mode!">
	 <PLTABLE "Why does LGOP take place in Ohio?"
		  "Why not?">
	 <PLTABLE "Is a marsmid like a zorkmid?"
		  "They're both coins...">
	 "MISCELLANEOUS"
	 <PLTABLE "Where the Scratch-n-sniff Odors Are"
		  "Don't expose the answers until you've finished
the story, or you might see things you don't want to see!"
		  "1. Pizza (in the bathroom after urinating)"  
		  "2. Chocolate (whenever the hunk of chocolate is present)"  
		  "3. Mothballs (in the Closet)"  
		  "4. Perfume (in the Harem)"  
		  "5. Garlic (In Space, when Thorbast/Thorbala speaks)"
		  "6. Leather (in the Boudoir -- this scent is weaker than the others)"
		  "7. Banana (on the last turn before winning)"  
		  "Some other odors we were considering: Skunk, Peanut Butter, Grapefruit, Bubble Gum, Whipped Cream, Mushroom, New Car, Anchovy, Martini, Fried Chicken...">
	 <PLTABLE "Where All the Sex Scenes Are Located"
		  "Reading the next hint will give things away. Don't go any further until you finish the story."
		  "There are five opportunities for some \"foolin' around\""
		  "1. Solving the frog puzzle."
		  "2. Your hour in the Inner Harem."
		  "3. When you're a gorilla in the cage."
		  "4. Following Elysia/Elysium into his/her private cabin after he/she gives you the photo."
		  "5. On the divan in the Boudoir."
		  "Don't forget to experience these \"episodes\" in all three naughtiness levels. (Unless you're underage, of course. Or unless you're a personal friend of Ed Meese. If you're a personal friend of Ed Meese, we're just joking and there really aren't any sex scenes at all.)">
	 <PLTABLE "Where All the Parts Are Located"
		  "This section tells you where to find the eight items on the parts list. Use it only as a last resort."
		  "Common household blender -- from the frog prince"
		  "Six feet of rubber hose -- in the cage in the Laboratory"
		  "Pair of cotton balls -- in the igloo (Orphanage Foyer)"
		  "Eighty-two degree angle -- from King Mitre"
		  "Headlight from a 1933 Ford -- out the Bedroom window (Cleveland)"
		  "White mouse -- on Hickory Dickory Dock"
		  "Photo of Jean Harlow/Douglas Fairbanks -- from Elysia/Elysium, aboard the Space Yacht near Saturn"
		  "Cleveland phone book -- in the Forgotten Storehouse off the Catacombs">
	 <PLTABLE "How All the Points Are Scored"
		  "This section should only be used as a last resort, or for your own interest after you've completed the game. For more information about how scoring works in Leather Goddesses of Phobos, see the scoring question in the General Questions section."
		  "POINTS  EVENT"
		  " 1- 8   waking up in the prison cell"
		  "14-23*  getting the mouse"
		  " 3-10   getting the odd machine"
		  "19-43*  returning to your human body"
		  "14-47*  getting the headlight"
		  " 2-17   removing the Venus flytrap"
		  " 8-19   answering the riddle"
		  "13-39*  getting the telephone book"
		  " 8-11   getting the raft"
		  " 4-19   at the Icy Dock, unradiated"
		  "16-45*  getting the cotton balls"
		  " 5-20   killing Thorbast/Thorbala"
		  "17-30*  getting the photo"
		  "17-34*  getting the blender"
		  "16-26*  getting the 82 degree angle"
		  " 5-17   getting the black circle"
		  " 9-22   arriving at the Plaza"
		  "The * events also increase your rank. Your rank is increased for a ninth time on the final turn of the story. TOTAL POINTS = 171 to 429.">
	 <PLTABLE "For Your Amusement"
		  "You shouldn't expose anything in this section until you've finished Leather Goddesses of Phobos. Things in this section will invariably give away the answers to puzzles in the game."
		  "Have you ever tried to..."
		  "...play Leather Goddesses of Phobos as a man if you're a woman, or vice versa?"
		  "...buy a beer in the bar before relieving yourself?"
		  "...enter the men's room after entering the ladies' room first, or vice versa?"
		  "...flush the toilet?"
		  "...eat the pizza? And then typed VOMIT?"
		  "...urinate in something other than a toilet?"
		  "...not go to the bathroom?"
		  "...knock on the door of Trent's/Tiffany's cell before opening the door?"
		  "...lead Trent/Tiffany into your cell? (Try in all three naughtiness levels.)"
		  "...call Trent \"Tiffany\" (while playing as a man), or vice versa?"
		  "...walk west in the Observation Room?"
		  "...jump off the prison Roof on Phobos?"
		  "...touch, examine, or put something on one of the black circles?"
		  "...push Trent/Tiffany into the tree hole (Fork, Of Sorts)?"
		  "...jump into the tree hole while being chased by the flytrap?"
		  "...get into the tree hole after trapping the flytrap there?"
		  "...ask Trent/Tiffany about the odd machine?">
	 <PLTABLE "Amusement (cont.)"
		  "Have you ever tried to..."
		  "...T-remove the tray to then examine it?"
		  "...use the odd machine on the rabbit?"
		  "...use the odd machine on the raft to then put the raft in the canal?"
		  "...run the cotton balls through the odd machine to then examine them?"
		  "...DIAGNOSE to examine yourself as a gorilla?"
		  "...examine your body on the slab while you're a gorilla?"
		  "...examine Trent's/Tiffany's body on the slab while you're a gorilla?"
		  "...leave the Laboratory while you're a gorilla?"
		  "...whip someone with the rubber hose (not in TAME mode)?"
		  "...give anything to King Mitre?"
		  "...shake King Mitre's hand?"
		  "...examine (the unangled) Princess Theta?"
		  "...marry Princess Theta (in both her angled to unangled forms)?"
		  "...put the unangling cream on the pile of angles? On King Mitre?"
		  "...touch the frog?"
		  "...ask Trent/Tiffany to kiss the frog?"
		  "...click the mouse?"
		  "...sink the royal barge?"
		  "...examine, awaken, or kiss the dead alien messenger?"
		  "...put the lip balm on the dead alien messenger?">
	 <PLTABLE "Amusement (cont..)"
		  "Have you ever tried to..."
		  "...give the flexible black circle back to the proprietor?"
		  "...show the dead alien's coded message to the Sultan/Sultaness?"
		  "...ask the harem guard for a different number than the \"correct\" number? Several times?"
		  "...ask the harem guard for same number twice in a row?"
		  "...wait instead of answering \"yes\" when the Sultan/Sultaness asks if you're ready for the riddle?"
		  "...wait instead of answering the riddle right away?"
		  "...SAVE your position in the Audience Chamber before answering the riddle?"
		  "...return from the Inner Harem to the Harem holding the secret map after the Sultan's wife/Sultaness' husband warns you that if you leave that way \"the harem guards will...\""
		  "...thank the Sultan's wife/Sultaness' husband after getting the torch to secret map?"
		  "...measure the Sultan's wife?"
		  "...measure the Sultaness' husband (in all three naughtiness levels)?"
		  "...make love to the Sultan's wife/Sultaness' husband a second time (not in TAME mode)?"
		  "...speak to the Sultan's wife or Sultaness' husband by his or her wrong number? (e.g., SULTAN'S WIFE #123, HELLO instead of SULTAN'S WIFE #789, HELLO)"
		  "...move around in the Catacombs without a light?"
		  "...read the Cleveland phone book?"
		  "...deflate the raft? While it's in the water? While it's in the water to you're in it?"
		  "...put the raft in the Oasis?"
		  "...take or open the buoy (if you've solved Zork I)?"
		  "...have sex with anyone while radiated from the ion beam?">
	 <PLTABLE "Amusement (cont...)"
		  "Have you tried to..."
		  "...talk to the robot baby?"
		  "...kiss or rock the robot baby while it's crying?"
		  "...suckle the robot baby as a female? As a male?"
		  "...toss the robot baby into the canal?"
		  "...count the leaves? (That's also how many were in the pile of leaves in Zork I.)"
		  "...tie the strips of cloth (from the partially made rope) to anything?"
		  "...screw the stallion?"
		  "...go into space from the battleship without putting on the white suit?"
		  "...tell Elysia/Elysium to shut up while he/she is screaming?"
		  "...read the photo that Elysia/Elysium gives you?"
		  "...ask various characters about the Leather Goddesses? (such as Trent/Tiffany, the salesman, the mad scientist, Thorbast/Thorbala, Elysia/Elysium, King Mitre, Princess Theta, the Sultan/Sultaness, the Sultan's wife/Sultaness' husband, the Exit Shop proprietor...)"
		  "...get fresh with the Leather Goddess in the Boudoir in TAME mode?"
		  "...kiss the Leather Goddess, not in TAME mode, while Trent/Tiffany is also in the Boudoir?"
		  "...get to the end of the Plaza scene without Trent/Tiffany present?"
		  "...get to the end of the Plaza scene without giving all of the eight parts to Trent/Tiffany?"
		  "...use \"four letter words\" in your inputs while in TAME mode?"
		  "...smell the barge or the flowers in the Garden?"
		  "...put the blanket, sheet, or sack on your head (if you've played The Hitchhiker's Guide to the Galaxy)?"
		  "...open your mouth?"
		  "...give an age less than 5 while trying to enter LEWD mode?"
		  "...LOOK with your eyes closed? With your hands over your eyes?"
		  "...look through something that isn't transparent?"
		  "...look inside your overalls, loincloth, or bikini?">
	 <PLTABLE "Acknowledgements"
		  "Why are the acknowledgements in the hints?"
		  "Why not?" 
		  "Testing: The primary testers for Leather Goddesses of Phobos were Tom Bok, Gary Brennan, Amy Briggs, Max Buxton, Liz Cyr-Jones, Suzanne Frank, and Matt Hillman. In addition, dozens of \"outside testers\" deserve praise for their help."
		  "Packaging: The package (and its components) was designed by Carl Genatassio and Elizabeth Langosy. The artwork for the 3-D comic (including the cover) is the work of Richard Howell; the 3-D processing was done by Ray Zone. Angela Crews tirelessly learned the ins and outs of scratch-n-sniff while tracking down an affordable scratch-n-sniff printer."
		  "The artwork for the Leather Goddesses of Phobos poster was done by Ken Barr."
		  "Thanks to Brian Moriarty for the idea of including a 3-D comic. Thanks to Ed Black for implementing the \"boss key\" feature in the original IBM version. Thanks to Dave Lebling for some timely technical assistance. And thanks to Jon Palace for a host of things, but especially for his help in \"sensualizing\" the text, and for being a front-line defense against scheming marketeers.">
>>

<GLOBAL CUR-POS 0>	;"determines where to place the highlight cursor
			  Can go up to 17 Questions"

<GLOBAL QUEST-NUM 1>    ;"shows in HINT-TBL ltable which QUESTION it's on"

<GLOBAL CHAPT-NUM 1>	;"shows in HINT-TBL ltable which CHAPTER it's on"

<CONSTANT DIROUT-TBL
	  <TABLE 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 >>

<ROUTINE V-HINTS-NO ()
	<COND (<NOT <PRSO? ,ROOMS>>
	       <TELL "I don't understand what you mean." CR>)
	      (T
	       <SETG HINTS-OFF T>
	       <TELL "[Hints have been disallowed for this session.]" CR>)>
	<RFATAL>>

<ROUTINE V-HINT ("AUX" CHR MAXC (C <>) Q (WHO <>))
  <COND (<==? ,HINTS-OFF -1>
	 <SETG HINTS-OFF 0>
	 <TELL
"[Warning: It is recognized that the temptation for help may at times be so
exceedingly strong that you might fetch hints prematurely. Therefore, you may
at any time during the story type HINTS OFF, and this will disallow the
seeking out of help for the present session of the story. If you still want a
hint now, indicate HINT.]" CR>
	 <RFATAL>)
	(,HINTS-OFF
	 <PERFORM ,V?HINTS-NO ,ROOMS>
	 <RFATAL>)>
  ;<IFSOUND <SETG SOUND-QUEUED? <>>
	   <KILL-SOUNDS>>
  <SET MAXC <GET ,HINTS 0>>
  <INIT-HINT-SCREEN>
  <CURSET 5 1>
  <PUT-UP-CHAPTERS>
  <SETG CUR-POS <- ,CHAPT-NUM 1>>
  <NEW-CURSOR>
  <REPEAT ()
	  <SET CHR <INPUT 1>>
	  <COND (<EQUAL? .CHR !\Q !\q>
		 <SET Q T>
		 <RETURN>)
		(<EQUAL? .CHR !\N !\n>
		 <ERASE-CURSOR>
		 <COND (<EQUAL? ,CHAPT-NUM .MAXC>
			<SETG CUR-POS 0>
			<SETG CHAPT-NUM 1>
			<SETG QUEST-NUM 1>)
		       (T
			<SETG CUR-POS <+ ,CUR-POS 1>>
			<SETG CHAPT-NUM <+ ,CHAPT-NUM 1>>
			<SETG QUEST-NUM 1>)>
		 <NEW-CURSOR>)
		(<EQUAL? .CHR !\P !\p>
		 <ERASE-CURSOR>
		 <COND (<EQUAL? ,CHAPT-NUM 1>
			<SETG CHAPT-NUM .MAXC>
			<SETG CUR-POS <- .MAXC 1>>)
		       (T
			<SETG CUR-POS <- ,CUR-POS 1>>
			<SETG CHAPT-NUM <- ,CHAPT-NUM 1>>)>
		 <SETG QUEST-NUM 1>
		 <NEW-CURSOR>)
		(<EQUAL? .CHR 13 10>
		 <PICK-QUESTION>
		 <RETURN>)>>
  <COND (<NOT .Q>
	 <AGAIN>	;"AGAIN does whole routine?")>
  <CLEAR -1>
  <INIT-STATUS-LINE>
  <TELL "Back to the story ..." CR>
  ;<IFSOUND <COND (,SOUND-ON?
		  <CHECK-LOOPING>)>>
  <RFATAL>>

<ROUTINE PICK-QUESTION ("AUX" CHR MAXQ (Q <>))
  <INIT-HINT-SCREEN <>>
  <LEFT-LINE 3 ,RETURN-SEE-HINT ,RETURN-SEE-HINT-LEN>
  <RIGHT-LINE 3 ,Q-MAIN-MENU ,Q-MAIN-MENU-LEN>
  <SET MAXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
  <CURSET 5 1>
  <PUT-UP-QUESTIONS>
  <SETG CUR-POS <- ,QUEST-NUM 1>>
  <NEW-CURSOR>
  <REPEAT ()
    <SET CHR <INPUT 1>>
    <COND (<EQUAL? .CHR !\Q !\q>
	   <SET Q T>
	   <RETURN>)
	  (<EQUAL? .CHR !\N !\n>
	   <ERASE-CURSOR>
	   <COND (<EQUAL? ,QUEST-NUM .MAXQ> ; "Wrap around on N"
		  <SETG CUR-POS 0>
		  <SETG QUEST-NUM 1>)
		 (T
		  <SETG CUR-POS <+ ,CUR-POS 1>>
		  <SETG QUEST-NUM <+ ,QUEST-NUM 1>>)>
	   <NEW-CURSOR>)
	  (<EQUAL? .CHR !\P !\p>
	   <ERASE-CURSOR>
	   <COND (<EQUAL? ,QUEST-NUM 1>
		  <SETG QUEST-NUM .MAXQ>
		  <SETG CUR-POS <- .MAXQ 1>>)
		 (T
		  <SETG CUR-POS <- ,CUR-POS 1>>
		  <SETG QUEST-NUM <- ,QUEST-NUM 1>>)>
	   <NEW-CURSOR>)
	  (<EQUAL? .CHR 13 10>
	   <DISPLAY-HINT>
	   <RETURN>)>>
  <COND (<NOT .Q>
	 <AGAIN>)>>

<ROUTINE ERASE-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2>>
	<TELL " ">	;"erase previous highlight cursor">

;"go back 2 spaces from question text, print cursor and flash is between
the cursor and text"

<ROUTINE NEW-CURSOR ()
	<CURSET <GET ,LINE-TABLE ,CUR-POS>
		<- <GET ,COLUMN-TABLE ,CUR-POS> 2 ;1>>
	<TELL ">">	;"print the new cursor">

<ROUTINE INVERSE-LINE ("AUX" (CENTER-HALF <>)) 
	<HLIGHT ,H-INVERSE>
	<PRINT-SPACES <LOWCORE SCRH>>
	<HLIGHT ,H-NORMAL>>

<ROUTINE DISPLAY-HINT ("AUX" H MX (CNT 2) CHR (FLG T) N CV
			  SHIFT? COUNT-OFFS)
  <CLEAR -1>
  <SPLIT 3>
  <SCREEN ,S-WINDOW>
  <CURSET 1 1>
  <INVERSE-LINE>
  <CENTER-LINE 1 ,INVISICLUES ,INVISICLUES-LEN>
  <CURSET 3 1>
  <INVERSE-LINE>
  <LEFT-LINE 3 "RETURN = see new hint">
  <RIGHT-LINE 3 ,Q-SEE-HINT-MENU ,Q-SEE-HINT-MENU-LEN>
  <CURSET 2 1>
  <INVERSE-LINE>
  <HLIGHT ,H-BOLD>
  <SET H <GET <GET ,HINTS ,CHAPT-NUM> <+ ,QUEST-NUM 1>>>
  ; "Byte table to use for showing questions already seen"
  ; "Actually a nibble table.  The high four bits of each byte are for
     quest-num odd; the low for bits are for quest-num even.  See SHIFT?
     and COUNT-OFFS."
  <SET CV <GET ,HINT-COUNTS <- ,CHAPT-NUM 1>>>
  <CENTER-LINE 2 <GET .H 1>>
  <HLIGHT ,H-NORMAL>
  <SET MX <GET .H 0>>
  <SCREEN ,S-TEXT>
  <CRLF>
  <SET SHIFT? <MOD ,QUEST-NUM 2>>
  <SET COUNT-OFFS </ <- ,QUEST-NUM 1> 2>>
  <REPEAT ((CURCX <GETB .CV .COUNT-OFFS>)
	   (CURC <+ 2 <ANDB <COND (.SHIFT? <LSH .CURCX -4>)
				  (T .CURCX)> *17*>>))
    <COND (<==? .CNT .CURC>
	   <RETURN>)
	  (T
	   <TELL <GET .H .CNT> CR>
	   <SET CNT <+ .CNT 1>>)>>
  <REPEAT ()
     <COND (<AND .FLG <G? .CNT .MX>>
	    <SET FLG <>>
	    <TELL "[That's all.]" CR>)
	   (.FLG
	    <SET N <+ <- .MX .CNT> 1>>
	    <TELL "[" N .N " hint">
	    <COND (<NOT <EQUAL? .N 1>>
		   <TELL "s">)>
	    <TELL " left.] -> ">
	    <SET FLG <>>)>
     <SET CHR <INPUT 1>>
     <COND (<EQUAL? .CHR !\Q !\q>
	    <COND (.SHIFT?
		   <PUTB .CV .COUNT-OFFS
			 <ORB <ANDB <GETB .CV .COUNT-OFFS> *17*>
			      <LSH <- .CNT 2> 4>>>)
		  (T
		   <PUTB .CV .COUNT-OFFS
			 <ORB <ANDB <GETB .CV .COUNT-OFFS> *360*>
			      <- .CNT 2>>>)>
	    <RETURN>)
	   (<EQUAL? .CHR 13 10>
	    <COND (<L=? .CNT .MX>
		   <SET FLG T>	;".cnt starts as 2"
		   <TELL <GET .H .CNT> CR>
		   ; "3rd = line 7, 4th = line 9, ect"
		   <COND (<G? <SET CNT <+ .CNT 1>> .MX>
			  <SET FLG <>>
			  <TELL "[Final hint]" CR>)>)>)>>>

<ROUTINE PUT-UP-QUESTIONS ("AUX" (ST 1) MXQ MXL)
  <SET MXQ <- <GET <GET ,HINTS ,CHAPT-NUM> 0> 1>>
  <SET MXL <- <LOWCORE SCRV> 1>>
  <REPEAT ()
	  <COND (<G? .ST .MXQ>
		 <RETURN>)
		(T                        ;"zeroth"
		 <CURSET <GET ,LINE-TABLE <- .ST 1>>
				<- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
	  <TELL " " <GET <GET <GET ,HINTS ,CHAPT-NUM> <+ .ST 1>> 1>>
	  <SET ST <+ .ST 1>>>>

<ROUTINE PUT-UP-CHAPTERS ("AUX" (ST 1) MXC MXL)
  <SET MXC <GET ,HINTS 0>>
  <SET MXL <- <LOWCORE SCRV> 1>>
  <REPEAT ()
    <COND (<G? .ST .MXC>
	   <RETURN>)
	  (T                        ;"zeroth"
	   <CURSET
	    <GET ,LINE-TABLE <- .ST 1>>
	    <- <GET ,COLUMN-TABLE <- .ST 1>> 1>>)>
    <TELL " " <GET <GET ,HINTS .ST> 1>>
    <SET ST <+ .ST 1>>>>

<ROUTINE INIT-HINT-SCREEN ("OPTIONAL" (THIRD T))
  <CLEAR -1>
  <SPLIT <- <LOWCORE SCRV> 1>>
  <SCREEN ,S-WINDOW>
  <CURSET 1 1>
  <INVERSE-LINE>
  <CURSET 2 1>
  <INVERSE-LINE>
  <CURSET 3 1>
  <INVERSE-LINE>
  <CENTER-LINE 1 ,INVISICLUES ,INVISICLUES-LEN>
  <LEFT-LINE 2 " N = Next">
  <RIGHT-LINE 2 ,PREVIOUS ,PREVIOUS-LEN>
  <COND (.THIRD
	 <LEFT-LINE 3 " RETURN = See hint">
	 <RIGHT-LINE 3 ,Q-RESUME-STORY ,Q-RESUME-STORY-LEN>)>>

<ROUTINE CENTER-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
  <COND (<ZERO? .LEN>
	 <DIROUT ,D-TABLE-ON ,DIROUT-TBL>
	 <TELL .STR>
	 <DIROUT ,D-TABLE-OFF>
	 <SET LEN <GET ,DIROUT-TBL 0>>)>
  <CURSET .LN </ <- <LOWCORE SCRH> .LEN> 2>>
  <COND (.INV
	 <HLIGHT ,H-INVERSE>)>
  <TELL .STR>
  <COND (.INV
	 <HLIGHT ,H-NORMAL>)>>

<ROUTINE LEFT-LINE (LN STR "OPTIONAL" (INV T))
	<CURSET .LN 1>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>

<ROUTINE RIGHT-LINE (LN STR "OPTIONAL" (LEN 0) (INV T))
	<COND (<ZERO? .LEN>
	       <DIROUT 3 ,DIROUT-TBL>
	       <TELL .STR>
	       <DIROUT -3>
	       <SET LEN <GET ,DIROUT-TBL 0>>)>
	<CURSET .LN <- <LOWCORE SCRH> .LEN>>
	<COND (.INV
	       <HLIGHT ,H-INVERSE>)>
	<TELL .STR>
	<COND (.INV
	       <HLIGHT ,H-NORMAL>)>>
OW
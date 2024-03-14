extends Node
#signals for commands
signal shiprota(deg)
signal antenarot(deg)
signal location(x,y,z)
#signals for terminal text control
signal responsetxt(out)
signal redtext(out)
#signals for changing colors
signal terminaltextcolor(color)
signal terminalbackcolor(color)
#signal for static end game
signal staticend()
var commandToMethod = {"help" : help, "cmds" : cmds,"thrust" : thrust,"textcolor":textcolor,"backcolor":backcolor,
"rot":rot,"antenrot":antenrot,"task":task,"checkpath":checkpath,"update":termupdate}
var hours = 0
var min = 0

var satrot = 0
var antrot = 0

var curtask = 0
var taskstrs = ["be at rotation 2 deg then run checkpath",
				"burn until you get (-3,4,20) velocity then run checkpath",
				"rotate antena angle to 15 deg, then activate com/os update",#end part 1 something about being time sensitive/efficient 2
				"rotate to -20 deg within 2 minutes of the last update.",
				"burn to around (700,155,-637) velocity within a min",
				"rotate antena angle to 0 deg, then activate com/os update",#end part 2 #5
				"rotate to 90 deg within a min",
				"burn to around (0,16,2) velocity within a min",
				"rotate antena angle to -45 deg, then activate com/os update",#end part 3 #8
				"rotate to 69 deg within a min",
				"burn to around (-33333,44444,22220) velocity within a min",
				"rotate antena angle to 15 deg",
				"com update"#end game #12
				]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func timeUpdated(hours,min):
	TCMD.hours = hours
	TCMD.min = min
	updateLocation()
	if thrustChanged:
		location.emit(shipPos[0],shipPos[1],shipPos[2])

#region internals
func cmd_entered(cmd):
	var splitcmd = cmd.split(" ") # "  " is allowed
	if splitcmd[0] in commandToMethod:
		commandToMethod[splitcmd[0]].call(splitcmd)
	else:
		responsetxt.emit("no such command detected, enter help for help")

var prout = ""
func pr(texts,final=false):

	if typeof(texts) == TYPE_ARRAY or typeof(texts) == TYPE_PACKED_STRING_ARRAY:
		for text in texts:
			prout+= text
			prout += " "
	else:
		prout += str(texts)
	if final:
		responsetxt.emit(prout)
		prout = ""

var prout2 = ""
func redp(texts,final=false):
	if typeof(texts) == TYPE_ARRAY or typeof(texts) == TYPE_PACKED_STRING_ARRAY:
		for text in texts:
			prout2+= text
			prout2 += " "
	else:
		prout2 += str(texts)
	if final:
		redtext.emit(prout2)
		prout2 = ""

func getAInt(text):
	if text.is_valid_int():
		return text.to_int()
	return false
#endregion

func help(cmd):
	redp("good morning employee, lets have another productive work day!\n\n",true)
	pr("maintain course by achieving a certain velocity at certain points in time\n\n")
	pr("recieve mission critical updates by angling your antenna\n\n")
	#pr("do science by observing stuff at certain points in time\n\n")
	#pr("make sure your satelite doesn't burn up near the sun hahahahahaha jk fr fr\n\n")
	pr("you can get specific orders with the 'task' command\n\n")
	pr("you have 4 hours to prepare for the next day, good luck!\n\n")
	pr("enter cmds for a list of commands",true)

func cmds(cmd):
	pr("task\nfor next task\n\n")
	pr("checkpath\nfor completing a task early\n\n")
	pr("thrust [axis]:0,1,2 [thrust] [min]\nRed=0=x,Green=1=y,Blue=2=z\n\n")
	pr("rot [relativerot]\n")
	pr("antenrot [relativerot]\n")
	pr("enter help for help",true)

func task(cmd):
	pr(taskstrs[curtask],true)

func checkShipPos(check):
	if shipPos == check:
		pr("Task Completed!",true)
		curtask+=1
		return
	pr("Task Incomplete",true)
	
func checkSatRot(check):
	if satrot == check:
		pr("Task Completed!",true)
		curtask+=1
		return
	pr("Task Incomplete",true)

func checkAntRot(check):
	if antrot == check:
		pr("Task Completed!",true)
		curtask+=1
		return
	pr("Task Incomplete",true)

'''
0"be at rotation 2 deg then run checkpath",
1"burn until you get (-3,4,20) velocity then run checkpath",
2"rotate antena angle to 15 deg, then activate com/os update",#end part 1 something about being time sensitive/efficient 2
4"rotate to -20 deg within 2 minutes of the last update.",
5"burn to around (700,155,-637) velocity within a min",
6"rotate antena angle to 0 deg, then activate com/os update",#end part 2 #5
7"rotate to 90 deg within a min",
8"burn to around (0,16,2) velocity within a min",
9"rotate antena angle to -45 deg, then activate com/os update",#end part 3 #8
11"rotate to 69 deg within a min",
12"burn to around (-33333,44444,22220) velocity within a min",
13"rotate antena angle to 15 deg",
14"com update"#end game #12
'''

func checkpath(cmd):
	match curtask:
		0:
			checkSatRot(2)
		1:
			checkShipPos([-3,4,20])
		2:
			checkAntRot(15)
		3:
			pr("UpdateOS",true)
		4:
			checkShipPos([-3,4,20])
		5:
			checkAntRot(15)
		6:
			pr("UpdateOS",true)
		7:
			checkShipPos([-3,4,20])
		8:
			checkAntRot(15)
		9:
			pr("UpdateOS",true)
		10:
			checkShipPos([-3,4,20])
		11:
			checkAntRot(15)
		12:
			checkAntRot(15)
	
func termupdate(cmd):
	match curtask:
		3:
			pr("Downloading update... Complete!\n")
			pr("Mission Status: On Track\n")
			pr("OS v.2.53.2 Patch Notes\n")
			pr("Updated System Colors\n")
			pr("Renamed Confusing Commands\n")
			pr("Added Assistant AI, its commands are marked in red text\n")
			pr("Rewrote everything in javascript,\nthe correct language for everything\n",true)
		6:
			pr("Downloading update... Complete!\n")
			pr("Mission Status: On Track?\n")
			pr("OS v.3.69.4 Patch Notes\n")
			pr("Updated System Colors\n")
			pr("Renamed Confusing Commands\n")
			pr("Rewrote everything in rust, as god and\nspecifically the united states government intended\n",true)
		9:
			pr("Downloading update... Complete!\n")
			pr("Mission Status: Probably fine\n")
			pr("OS v.4.2.1 Patch Notes\n")
			pr("Updated System Colors\n")
			pr("Renamed Confusing Commands\n")
			pr("Fired all the software engineers and\nmade the AI write everything\n",true)
		13:
			pr("Downloading update... Complete!\n")
			pr("Mission Status: Terminated\n")
			pr("Mission deemed unprofitable and boring\n")
			pr("Disabling manual control in a moment\n")
			pr("Flying into the closest sun, have a safe work day!\n",true)
		_:
			pr("No uplink established, update impossible, Aborting!",true)
#region color
func textcolor(cmd):
	pr("unsupported",true)

func backcolor(cmd):
	pr("unsupported",true)
#endregion

#region thrust
var thrusts = [] # [[axis,force,seconds],[axis,force,seconds]...] stupid ass datastructure ;-;
var shipPos = [0,0,0]
var thrustChanged = false
func updateLocation(): # for some reason doesn't work immideatly on game start but who really cares lmao
	for i in range(len(thrusts)-1,-1,-1):
		var thrust = thrusts[i]
		if thrust[2] > 0:
			if thrust[0] > -1 and thrust[0] < 3:
				shipPos[thrust[0]] += thrust[1]
				thrustChanged = true
			thrust[2] -= 1
		else:
			thrusts.remove_at(i)
	
var axi = {"x" : 0, "y" : 1, "z" : 2}
func thrust(cmd,letter=false):
#endregion
	if len(cmd) > 3:
		
		var force = getAInt(cmd[2])
		var seconds = getAInt(cmd[3])
		
		var axis = -1
		if letter:
			if cmd[1] in axi:
				axis = axi[cmd[1]]
			else:
				pr("thrust needs 3 fields, help cmd for more",true)
				return
		else:
			axis = getAInt(cmd[1])
		if axis > -1 and axis < 3 and force and seconds:
			pr("axis: " + str(axis) + " force: " + str(force) + " seconds: " + str(seconds))
			thrusts.append([axis,force,seconds])
		else:
			pr("thrust doesn't work with one of the three fields")
	else:
		pr("thrust needs 3 fields, help cmd for more")
	pr("\nCurrent Thrusts: "+str(thrusts))
	pr("",true)

func rot(cmd):
	if len(cmd) > 1:
		var rotation = getAInt(cmd[1])
		if rotation:
			pr(rotation,true)
			satrot = rotation
			shiprota.emit(rotation)
			return
	pr("unimplemented",true)
	
func antenrot(cmd):
	if len(cmd) > 1:
		var rotation = getAInt(cmd[1])
		if rotation:
			pr(rotation,true)
			antrot = rotation
			antenarot.emit(rotation)
			return
	pr("unimplemented",true)

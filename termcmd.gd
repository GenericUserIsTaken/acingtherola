extends Node

signal shiprota(deg)
signal antenarot(deg)
signal location(x,y,z)
signal responsetxt(out)
var commandToMethod = {"help" : help, "cmds" : cmds,"thrust" : thrust,"textcolor":textcolor,"backcolor":backcolor,"rot":rot,"antenrot":antenrot}
var hours = 0
var min = 0
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
	
func getAInt(text):
	if text.is_valid_int():
		return text.to_int()
	return false
#endregion

func help(cmd):
	pr("welcome aboard, if you wish to complete your mission and not die please cooperate with the mission!\n\n")
	pr("maintain course by achieving a certain velocity at certain points in time\n\n")
	pr("recieve mission critical updates by angling your antenna\n\n")
	pr("do science by observing stuff at certain points in time\n\n")
	pr("make sure your satelite doesn't burn up near the sun hahahahahaha jk fr fr\n\n")
	pr("you can get specific orders with a different command\n\n")
	pr("you have 5 hours to prepare for the next day, good luck!\n\n")
	pr("enter cmds for a list of commands",true)

func cmds(cmd):
	pr("thrust [axis]:0,1,2 [thrust] [min]\nRed=0=x,Green=1=y,Blue=2=z\n")
	pr("rot [relativerot]\n")
	pr("antenrot [relativerot]\n")
	pr("enter help for help",true)

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
			shiprota.emit(rotation)
			return
	pr("unimplemented",true)
	
func antenrot(cmd):
	if len(cmd) > 1:
		var rotation = getAInt(cmd[1])
		if rotation:
			pr(rotation,true)
			antenarot.emit(rotation)
			return
	pr("unimplemented",true)

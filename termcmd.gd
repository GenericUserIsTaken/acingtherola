extends Node

signal responsetxt(out)
var commandToMethod = {"help" : help, "cmds" : cmds,"thrust" : thrust}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cmd_entered(cmd):
	var splitcmd = cmd.split(" ") # "  " is allowed
	if splitcmd[0] in commandToMethod:
		commandToMethod[splitcmd[0]].call(splitcmd)
	else:
		responsetxt.emit("no such command detected")

func pr(texts):
	if typeof(texts) == TYPE_ARRAY or typeof(texts) == TYPE_PACKED_STRING_ARRAY:
		var out = ""
		for text in texts:
			out+= text
			out += " "
		responsetxt.emit(out)
	else:
		responsetxt.emit(str(texts))
	
func help(cmd):
	pr(cmd)

func thrust(cmd):
	pr("real")

func cmds(cmd):
	pr("cmd")

extends Node

signal responsetxt(out)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cmd_entered(cmd):
	#check if valid cmd
	responsetxt.emit("you entered a stupid ass command")

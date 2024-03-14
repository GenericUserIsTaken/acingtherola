extends VBoxContainer
var defaultLabel : PackedScene = preload("res://computer_text.tscn")
var userIn : PackedScene = preload("res://user_in.tscn")
@onready var newestline = $UserIn
# Called when the node enters the scene tree for the first time.
func _ready():
	TCMD.responsetxt.connect(printout)
	TCMD.redtext.connect(redout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func printout(txt):
	var newprintout = defaultLabel.instantiate()
	var newinput = userIn.instantiate()
	newprintout.text = txt
	self.add_child(newprintout)
	self.add_child(newinput)
	newestline = newinput
	focus_newest()
	
func redout(txt):
	var newprintout = defaultLabel.instantiate()
	newprintout.text = txt
	newprintout.add_theme_color_override("font_color", Color.RED)
	self.add_child(newprintout)

func focus_newest():
	newestline.give_focus()

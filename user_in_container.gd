extends HBoxContainer

@onready var line = $LineEdit
# Called when the node enters the scene tree for the first time.
func give_focus():
	line.set_focus_mode(Control.FOCUS_ALL)
	line.grab_click_focus()
	line.grab_focus()

extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_text_submitted(new_text):
	TCMD.cmd_entered(new_text)
	self.release_focus()
	self.set_focus_mode(Control.FOCUS_NONE)
	self.set_editable(false)

extends PanelContainer

var mousein = false
@onready var vbox = $TerminalVbox
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	mousein = true

func _on_mouse_exited():
	mousein = false
	
func _input(event):
	if event.is_action_pressed("mouse"):
		vbox.focus_newest()

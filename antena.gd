extends Panel
@onready var rotlabel = %AntennaRotation

# Called when the node enters the scene tree for the first time.
func _ready():
	TCMD.antenarot.connect(rotateantena)

func _physics_process(delta):
	rotlabel.text = str(floor(self.rotation)) + " degrees, ship"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func rotateantena(rotation):
	var tween = self.create_tween()
	tween.tween_property(self, "rotation", rotation, rotation).as_relative()

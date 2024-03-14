extends Control
@onready var rotlabel = %ShipRotationLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	TCMD.shiprota.connect(rotateSelf)

func _physics_process(delta):
	rotlabel.text = str(floor(self.rotation)) + " degrees, ship"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func rotateSelf(rotation):
	var tween = self.create_tween()
	tween.tween_property(self, "rotation", rotation, rotation).as_relative()

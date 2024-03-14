extends Label
@export var export = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	TCMD.location.connect(updateHeader)

func updateHeader(x,y,z):
	if export == 0:
		self.text = str(x) + " M/S"
	elif export == 1:
		self.text = str(y) + " M/S"
	else:
		self.text = str(z) + " M/S"

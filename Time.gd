extends Label

var hours = 0
var min = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func makeDouble(num):
	if num > 9:
		return str(num)
	else:
		return "0"+str(num)

func getText():
	return "TIME: " + makeDouble(hours) + ":"+ makeDouble(min)

func addMin():
	if min >= 60:
		min = 0
		hours+=1
	else:
		min +=1
	TCMD.timeUpdated(hours,min)

func _on_timer_timeout():
	addMin()
	self.text = getText()

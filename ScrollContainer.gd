extends ScrollContainer

var scroll = self.get_v_scroll_bar()
# Called when the node enters the scene tree for the first time.
func _process(delta):
	scroll.value = scroll.max_value
	self.scroll_vertical = scroll.max_value
	#wasteful but calling scroll to bottom doesn't work ;-;
	
func scrollToBottom():
	scroll.value = scroll.max_value
	self.scroll_vertical = scroll.max_value

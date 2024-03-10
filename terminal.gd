extends TextEdit
@export var LIMIT = 27
var current_text = ''
var cursor_line = 0
var cursor_column = 0
var total_line_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_text_changed():
	var new_text : String = self.text
	if total_line_count > get_line_count():
		self.set_text(self.text+ "\n")
		self.set_caret_line(get_line_count())
		self.set_caret_column(0)
	if new_text and new_text[-1] == "\n":
		self.set_text(self.text+ ">")
		self.set_caret_line(cursor_line+1)
		self.set_caret_column(1)
	if get_line(self.get_caret_line()).length() > LIMIT:
		self.set_text(current_text)
		# when replacing the text, the cursor will get moved to the beginning of the
		# text, so move it back to where it was cursor_column
		self.set_caret_line(cursor_line)
		self.set_caret_column(cursor_column)

	current_text = self.text
	# save current position of cursor for when we have reached the limit
	cursor_line = self.get_caret_line()
	cursor_column = self.get_caret_column()
	total_line_count = self.get_line_count()

func _on_caret_changed():
	if self.get_caret_line() < cursor_line:
		self.set_caret_line(cursor_line)
	if get_line(self.get_caret_line())[self.get_caret_column()] == ">":
		self.set_caret_column(self.get_caret_column()+1)

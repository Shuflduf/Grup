extends Node

func _ready() -> void:
	var arguments = OS.get_cmdline_args()

	var target = ""
	var path = ""
	var dir_mode = true

	if arguments.size() > 0:
		target = arguments[0]
	else:
		print("Invalid Arguments")
		get_tree().quit(1)

	if arguments.size() > 1:
		dir_mode = false
		path = arguments[1]

	if !dir_mode:
		var file = FileAccess.open(path, FileAccess.READ)
		var words = file.get_as_text()
		if words.contains(target):
			print("Found ", target, " at ", words.find(target))

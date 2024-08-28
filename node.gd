extends Node

func _ready() -> void:
	var arguments = OS.get_cmdline_args()

	var target = ""
	var path = ""
	var dir_mode = true
	print(arguments.size())
	if arguments.size() > 0:
		target = arguments[0]
	else:
		print("Invalid Arguments")
		get_tree().quit(1)

	if arguments.size() > 1:
		dir_mode = false
		path = arguments[1]

	if !dir_mode:
		if scan_file(path, target):
			print("Found ", target, " in ", path)
		else:
			print("Not found")
		get_tree().quit(0)
	else:
		for i in DirAccess.get_files_at(OS.get_executable_path().get_base_dir()):
			print("Searching in: ", i)
			if scan_file(i, target):
				print("Found ", target, " in ", i, " at character ", \
						FileAccess.get_file_as_string(i).find(target))
				return
				#get_tree().quit(0)

	get_tree().quit(2)

func scan_file(path: String, what: String) -> bool:
	var file = FileAccess.open(path, FileAccess.READ)
	var words = file.get_as_text()
	if words.contains(what):
		return true
	else:
		return false

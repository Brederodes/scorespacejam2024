class_name LevelGrid extends Node2D

var level_rows : Array = Array();

func update_rows_reference():
	level_rows = Array();
	for child in get_children():
		if child is LevelRow:
			level_rows.append(child);
func _ready():
	update_rows_reference();

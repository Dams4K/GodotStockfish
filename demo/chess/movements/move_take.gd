extends Move
class_name MoveTake

var taken: Piece

func _init(piece: Piece, from: Vector2i, to: Vector2i, taken: Piece) -> void:
	super._init(piece, from, to)
	self.taken = taken

func _get_classname():
	return "MoveTake"

func _get_attributes() -> Array[String]:
	var a := super._get_attributes()
	a.append("taken")
	return a

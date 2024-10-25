extends Object
class_name Move

var piece: Piece
var from: Vector2i
var to: Vector2i

func _init(piece: Piece, from: Vector2i, to: Vector2i) -> void:
	self.piece = piece
	self.from = from
	self.to = to

func _get_classname():
	return "Move"

func _get_attributes() -> Array[String]:
	return ["piece", "from", "to"]

func _to_string() -> String:
	var l = []
	for attr in _get_attributes():
		l.append("%s: %s" % [attr, get(attr)])
	
	return "<%s: [%s]>" % [_get_classname(),  ", ".join(l)]

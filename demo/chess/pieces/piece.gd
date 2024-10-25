@tool
extends Node2D
class_name Piece

enum PieceColor {
	BLACK,
	WHITE
}
enum PieceName {
	BISHOP,
	KING,
	KNIGHT,
	PAWN,
	QUEEN,
	ROOK
}

const ICON_FOLDER = "res://assets/textures/pieces/"

var sprite2d: Sprite2D

# i really don't like this solution
static var directions = {
	PieceName.BISHOP: func(piece_color: PieceColor, piece_pos: Vector2i, board_size: Vector2i, matrix: Array[Array]):
		var m_possible: Array[Move] = []
		var d_possible: Array[Vector2i] = [Vector2i.ONE, -Vector2i.ONE, Vector2i(1, -1), Vector2i(-1, 1)]
		var piece: Piece = matrix[piece_pos.y][piece_pos.x]
		
		for d_p in d_possible:
			var pos = piece_pos
			while Board.is_inside_board(pos, board_size):
				pos += d_p
				if not(Board.is_inside_board(pos, board_size)):
					break
				
				if matrix[pos.y][pos.x] != null:
					if matrix[pos.y][pos.x].piece_color != piece_color:
						m_possible.append(MoveTake.new(piece, piece_pos, pos, matrix[pos.y][pos.x]))
					break
				m_possible.append(Move.new(piece, piece_pos, pos))
		
		return m_possible,
	PieceName.KING: func(piece_color: PieceColor, piece_pos: Vector2i, board_size: Vector2i, matrix: Array[Array]):
		var m_possible: Array[Move] = []
		var d_possible: Array[Vector2i] = [
			Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT,
			Vector2i.ONE, -Vector2i.ONE, Vector2i(1, -1), Vector2i(-1, 1)
		]
		var piece: Piece = matrix[piece_pos.y][piece_pos.x]
		
		for d_p in d_possible:
			var pos = piece_pos + d_p
			if not(Board.is_inside_board(pos, board_size)):
				continue
			if matrix[pos.y][pos.x] == null:
				m_possible.append(Move.new(piece, piece_pos, pos))
			elif matrix[pos.y][pos.x].piece_color != piece_color:
				m_possible.append(MoveTake.new(piece, piece_pos, pos, matrix[pos.y][pos.x]))
		
		return m_possible,
	PieceName.KNIGHT: func(piece_color: PieceColor, piece_pos: Vector2i, board_size: Vector2i, matrix: Array[Array]):
		var m_possible: Array[Move] = []
		var d_possible: Array[Vector2i] = [
			2*Vector2i.LEFT+Vector2i.UP,	2*Vector2i.RIGHT+Vector2i.UP, 	2*Vector2i.UP+Vector2i.LEFT, 	2*Vector2i.DOWN+Vector2i.LEFT,
			2*Vector2i.LEFT+Vector2i.DOWN,	2*Vector2i.RIGHT+Vector2i.DOWN, 2*Vector2i.UP+Vector2i.RIGHT, 	2*Vector2i.DOWN+Vector2i.RIGHT,
		]
		var piece: Piece = matrix[piece_pos.y][piece_pos.x]
		
		for d_p in d_possible:
			var pos = piece_pos + d_p
			if not(Board.is_inside_board(pos, board_size)):
				continue
			if matrix[pos.y][pos.x] == null:
				m_possible.append(Move.new(piece, piece_pos, pos))
			elif matrix[pos.y][pos.x].piece_color != piece_color:
				m_possible.append(MoveTake.new(piece, piece_pos, pos, matrix[pos.y][pos.x]))
				
		return m_possible,
	PieceName.PAWN: func(piece_color: PieceColor, piece_pos: Vector2i, board_size: Vector2i, matrix: Array[Array]):
		var m_possible: Array[Move] = []
		var piece: Piece = matrix[piece_pos.y][piece_pos.x]
		
		return m_possible,
	PieceName.QUEEN: func(piece_color: PieceColor, piece_pos: Vector2i, board_size: Vector2i, matrix: Array[Array]):
		var m_possible: Array[Move] = directions[PieceName.BISHOP].call(piece_color, piece_pos, board_size, matrix)
		m_possible.append_array(directions[PieceName.ROOK].call(piece_color, piece_pos, board_size, matrix))
		return m_possible,
	PieceName.ROOK: func(piece_color: PieceColor, piece_pos: Vector2i, board_size: Vector2i, matrix: Array[Array]):
		var m_possible: Array[Move] = []
		var d_possible: Array[Vector2i] = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]
		var piece: Piece = matrix[piece_pos.y][piece_pos.x]
		
		for d_p in d_possible:
			var pos = piece_pos
			while Board.is_inside_board(pos, board_size):
				pos += d_p
				if not(Board.is_inside_board(pos, board_size)):
					break
				
				if matrix[pos.y][pos.x] != null:
					if matrix[pos.y][pos.x].piece_color != piece_color:
						m_possible.append(MoveTake.new(piece, piece_pos, pos, matrix[pos.y][pos.x]))
					break
				m_possible.append(Move.new(piece, piece_pos, pos))
		
		return m_possible
}

@export var piece_name: PieceName : set = set_piece_name
@export var piece_color: PieceColor : set = set_piece_color

func _ready() -> void:
	sprite2d = Sprite2D.new()
	update_icon()
	add_child(sprite2d)

func update_icon():
	if is_inside_tree() and sprite2d:
		sprite2d.texture = get_icon()

func get_icon() -> Texture2D:
	var color = "w" if piece_color == PieceColor.WHITE else "b"
	return load(ICON_FOLDER.path_join("%s_%s.png" % [name2str(piece_name), color]))

static func name2str(type: PieceName):
	match type:
		PieceName.BISHOP:
			return "b"
		PieceName.KING:
			return "k"
		PieceName.KNIGHT:
			return "n"
		PieceName.PAWN:
			return "p"
		PieceName.QUEEN:
			return "q"
		PieceName.ROOK:
			return "r"

static func str2name(str: String) -> PieceName:
	match str.to_lower():
		"b":
			return PieceName.BISHOP
		"k":
			return PieceName.KING
		"n":
			return PieceName.KNIGHT
		"p":
			return PieceName.PAWN
		"q":
			return PieceName.QUEEN
		"r":
			return PieceName.ROOK
	return PieceName.PAWN # default is pawn

func set_piece_name(v: PieceName):
	piece_name = v
	update_icon()
func set_piece_color(v: PieceColor):
	piece_color = v
	update_icon()

static func create_from(str: String) -> Piece:
	var p_name := str2name(str)
	var p_color := PieceColor.BLACK if str == str.to_lower() else PieceColor.WHITE
	
	var piece := Piece.new()
	piece.piece_name = p_name
	piece.piece_color = p_color
	return piece


func _to_string() -> String:
	var s = name2str(piece_name)
	return "<%s: %s>" % ["Piece", s.to_upper() if piece_color == PieceColor.WHITE else s]

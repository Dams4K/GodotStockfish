@tool
extends Node2D
class_name Board

var matrix: Array[Array] : set = set_matrix

@export var board_size := Vector2i(8, 8) : set = set_board_size
@export var square_size := Vector2i(64, 64) : set = set_square_size

@export var white_square := Color.WHITE : set = set_white_square
@export var black_square := Color.BLACK : set = set_black_square

var pieces: Node2D

var piece_selected: Piece
var available_moves: Array[Move] = []

func _ready() -> void:
	pieces = Node2D.new()
	pieces.name = "Pieces"
	add_child(pieces)
	
	create_matrix()
	
	queue_redraw()

#region
func create_matrix():
	matrix.resize(board_size.y) # Y lines
	for j in range(board_size.y):
		var line: Array[Piece] = []
		line.resize(board_size.x)
		# we don't fill matrix with line because it will be duplication of reference, not the object itself
		line.fill(null)
		matrix[j] = line

func setup_with_fen(fen: String):
	_setup_piece_fen(fen)

func _setup_piece_fen(fen: String):
	var pieces_pos := fen.split(" ", false, 1)[0]
	var lines := pieces_pos.split("/")
	
	for j in range(min(board_size.y, len(lines))):
		var line = lines[j]
		var current_i = 0
		
		for c in line:
			if c.is_valid_int():
				current_i += c.to_int()
				continue
			# else
			var piece := Piece.create_from(c)
			piece.position = Vector2i(current_i, j) * square_size + (square_size - Vector2i.ONE)/2
			
			pieces.add_child(piece)
			matrix[j][current_i] = piece
			current_i += 1

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var is_left_click = event.button_index == MOUSE_BUTTON_LEFT
		if is_left_click:
			var square_pos := Vector2i(event.position)/square_size
			var is_valid_square := square_pos.x < board_size.x and square_pos.y < board_size.y
			if is_valid_square:
				select_square(square_pos)

func select_square(pos: Vector2i):
	print(matrix[pos.y][pos.x])
	if matrix[pos.y][pos.x] == null:
		move_piece(pos)
	else:
		select_piece(pos)
	

func move_piece(pos: Vector2i):
	if piece_selected == null:
		return
	
	for move in available_moves:
		if pos == move.to:
			move.proceed(matrix)
			break
	
	available_moves.clear()
	update_board()

func select_piece(pos: Vector2i):
	piece_selected = matrix[pos.y][pos.x]
	
	var f: Callable = Piece.directions[piece_selected.piece_name]
	available_moves = f.call(piece_selected.piece_color, pos, board_size, matrix)
	queue_redraw()

func set_matrix(value: Array[Array]):
	matrix = value
	update_board()

func update_board():
	queue_redraw()
	for j in range(len(matrix)):
		for i in range(len(matrix[j])):
			var piece: Piece = matrix[j][i]
			if piece:
				piece.position = Vector2i(i, j) * square_size + (square_size - Vector2i.ONE)/2

#endregion

static func is_inside_board(pos: Vector2i, board_size: Vector2i):
	return pos.x >= 0 and pos.y >= 0 and pos.x < board_size.x and pos.y < board_size.y

#region INTERFACE
func _draw() -> void:
	for j in range(board_size.y):
		for i in range(board_size.x):
			var square_rect = Rect2i(Vector2i(i, j) * square_size, square_size)
			var color = white_square if (i+j) % 2 == 0 else black_square
			draw_rect(square_rect, color, true)
	
	for move in available_moves:
		var c = Color.DIM_GRAY
		if move is MoveTake:
			c = Color.RED
		draw_circle(move.to*square_size + square_size/2, 12, c, true)


func set_board_size(v: Vector2i):
	board_size = v
	queue_redraw()

func set_square_size(v: Vector2i):
	square_size = v
	queue_redraw()

func set_white_square(v: Color):
	white_square = v
	queue_redraw()

func set_black_square(v: Color):
	black_square = v
	queue_redraw()
#endregion

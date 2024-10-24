@tool
extends Node2D
class_name Board

@export var board_size := Vector2i(8, 8) : set = set_board_size
@export var square_size := Vector2i(64, 64) : set = set_square_size

@export var white_square := Color.WHITE : set = set_white_square
@export var black_square := Color.BLACK : set = set_black_square

func _ready() -> void:
	queue_redraw()

func _draw() -> void:
	for j in range(board_size.y):
		for i in range(board_size.x):
			var square_rect = Rect2i(Vector2i(i, j) * square_size, square_size)
			var color = white_square if (i+j) % 2 == 0 else black_square
			draw_rect(square_rect, color, true)


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

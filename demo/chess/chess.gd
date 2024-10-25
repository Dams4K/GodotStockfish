extends Node2D

#const START_FEN: StringName = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
const START_FEN = "r2qk2r/p2n1ppp/1p2p3/1Q1NPn2/5P2/5N2/PPP3PP/2KR3R b kq - 0 14"

@onready var board: Board = $Board

#var cboard = CBoard.new()
#
func _ready() -> void:
	board.setup_with_fen(START_FEN)
#
#class CBoard:
	#
	#
	#func setup_with_fen(fen: String):
		#var pieces_pos = fen.split(" ", false, 1)[0]
		#print(pieces_pos)

extends Node2D

#const START_FEN: StringName = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
const START_FEN = "r2qk1nr/ppp2ppp/2npb3/2b1p3/2B1P3/2NP1N2/PPP2PPP/R1BQK2R w KQkq - 1 6"

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

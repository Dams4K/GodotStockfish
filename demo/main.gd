extends Control


func _ready() -> void:
	var stock = GodotStockfish.new()
	stock.set_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", ["e2e4", "d7d6"])
	stock.go(20)
	#$Label.text = stock.print_eval()

extends HBoxContainer


func _ready() -> void:
	$Label2.text = "qsdqsd"
	var stock = GodotStockfish.new()
	stock.on_bestmove.connect(_on_bestmove)
	#
	stock.set_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", ["e2e4", "d7d6"])
	$Label.text = stock.print_eval()
	stock.go(20)


func _on_bestmove(bestmove: String, ponder: String):
	Global.bm = bestmove
	Global.p = ponder
	#print.call_deferred(self)
	#$Label.set_text.call_deferred("bestmove: %s ponder: %s" % [bestmove, ponder])


func _process(delta: float) -> void:
	$Label2.text = "bestmove: %s ponder: %s" % [Global.bm, Global.p]

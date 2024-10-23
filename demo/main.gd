extends HBoxContainer


func _ready() -> void:
	$Label2.text = "qsdqsd"
	#var stock = GodotStockfish.new()
	#GodotStockfish.print_eval()
	GodotStockfish.on_bestmove.connect(_on_bestmove)
	##
	GodotStockfish.set_position("rnbqkbnr/ppp1pppp/3p4/8/3PP3/8/PPP2PPP/RNBQKBNR b KQkq d3 0 2", ["e7e5"])
	$Label.text = GodotStockfish.print_eval()
	GodotStockfish.go(20)


func _on_bestmove(bestmove: String, ponder: String):
	#Global.bm = bestmove
	#Global.p = ponder
	#DisplayServer.get_screen_count()
	#print.call_deferred(self)
	$Label2.text = "bestmove: %s ponder: %s" % [bestmove, ponder]
#
#
#func _process(delta: float) -> void:
	#$Label2.text = "bestmove: %s ponder: %s" % [Global.bm, Global.p]

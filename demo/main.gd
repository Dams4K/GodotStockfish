extends HBoxContainer

func _ready() -> void:
	GodotStockfish.on_bestmove.connect(_on_bestmove)
	
	GodotStockfish.set_multipv(2)
	GodotStockfish.set_position("r1b2rk1/pppq1ppp/3p1n2/3Np3/1PBbP3/P2P4/R1PBQPPP/4K2R w K - 4 12", [])
	$Label.text = GodotStockfish.print_eval()
	GodotStockfish.go(15)
	print("Evaluation: ", GodotStockfish.get_evaluation())


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

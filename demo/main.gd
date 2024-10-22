extends Control


func _ready() -> void:
	print("---")
	var stock = GodotStockfish.new()
	$Label.text = stock.init_engine()
	print("---")

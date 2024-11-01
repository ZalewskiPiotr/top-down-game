extends Area2D

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		# TODO: trzeba dodać obiekt do inwentory. Tu chyba wyemitujemy jaki sygnał z ilością oraz nazwą zasobów
		print("pick up")
		self.queue_free()

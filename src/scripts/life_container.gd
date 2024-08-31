extends HBoxContainer

@export var life_texture: Texture

func _ready():
	update_hearts(3)

func update_hearts(lives):
	# Rimuovi tutti i cuori esistenti
	for child in get_children():
		child.queue_free()
	
	# Aggiungi i cuori in base al numero di vite attuali
	for i in range(lives):
		var life = TextureRect.new()
		life.texture = life_texture
		life.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		add_child(life)

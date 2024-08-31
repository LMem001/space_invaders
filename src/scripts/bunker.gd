extends Area2D

@export var sprites: Array[Texture]  # Array of textures representing different damage levels
@export var collision_shapes: Array[Node2D]  # Array of CollisionPolygon2D or CollisionShape2D nodes
var health: int = 30  # Initial health of the bunker

func _ready():
	_update_bunker(0)

func _take_damage():
	health -= 1
	if health == 20:
		_update_bunker(1)
	elif health == 10:
		_update_bunker(2)
	elif health == 0:
		queue_free()  # Remove the bunker from the scene when health reaches zero

func _update_bunker(stage):
	# Update the collision shapes to reflect current damage
	for shape in collision_shapes:
		shape.disabled = true  # Disable all shapes by default
	
	# Update the sprite to reflect current damage level
	$Sprite.texture = sprites[stage]
	collision_shapes[stage].disabled = false

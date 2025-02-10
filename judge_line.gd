extends Area2D
signal game_over
signal count_time
var colliding_objects = []
#var is_colliding = false
var collision_timer = 0
var collision_threshold = 2 # 碰撞时间阈值，单位为秒

func _ready() -> void:
	colliding_objects=[]
func _on_body_entered(body):
	if body.is_in_group("fruit"):
		colliding_objects.append(body)
		#is_colliding = true

func _on_body_exited(body):
	if body.is_in_group("fruit"):
		colliding_objects.erase(body)
		#is_colliding = false

func _process(delta):
	if colliding_objects.is_empty():
		collision_timer = 0
	else:
		collision_timer+=delta
		get_tree().root.get_node("Main").emit_signal("count_time", collision_timer)
		if collision_timer >= collision_threshold:
			game_over.emit()

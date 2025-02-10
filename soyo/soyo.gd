extends RigidBody2D

# 定义水果类型
func _on_body_entered(other_area):
	if other_area.is_in_group("soyo"):
		get_tree().root.get_node("Main").emit_signal("merge_fruits", self, other_area)

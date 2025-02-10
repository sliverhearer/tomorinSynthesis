extends Node
signal merge_fruits(fruit1, fruit2)
signal count_time(time)
# 加载水果预制体
@export var anon_scene:PackedScene
@export var soyo_scene :PackedScene
@export var mutsumi_scene:PackedScene
@export var sakiko_scene :PackedScene
@export var mortis_scene :PackedScene
@export var raana_scene :PackedScene
@export var rikki_scene :PackedScene
@export var tomorin_scene:PackedScene
var is_start = true
# 定义特定的y轴高度
var specific_y = 100
var new_fruit
var fruit
var upper_fruit
var score=0
func _ready() -> void:
	$Label.hide()
	new_fruit =  anon_scene.instantiate()
	new_fruit.gravity_scale=0
	new_fruit.position=Vector2(100,500)
	add_child(new_fruit)
#func _process(delta: float) -> void:
	#var mouse_pos = get_viewport().get_mouse_position().x
	#new_fruit.position = Vector2(mouse_pos,specific_y)
	
func _process(delta: float) -> void:
	$ScoreLabel2.text = "Score:"+"\n"+str(score)
func _input(event):
	# 检查事件是否为鼠标按键按下事件
	if event is InputEventMouseButton and event.pressed:
		# 检查是否为左键点击
		if event.button_index == MOUSE_BUTTON_LEFT:
			#new_fruit.queue_free
			#new_fruit.queue_free()
			# 获取鼠标点击位置的x轴坐标
			var click_x = event.position.x
			# 在特定的y轴高度处生成水果实例
			spawn_fruit(click_x)
func spawn_fruit(x_position):
	if $FruitTimer.is_stopped():
		#fruit = rikki_scene.instantiate()
		#var fruit = random_choice_with_weight(fruits, weights).instantiate()
	# 设置水果的位置
	# 将水果实例添加到当前场景
		$FruitTimer.start()
		if is_start:
			fruit = anon_scene.instantiate()
			is_start=false
			fruit.position = Vector2(x_position, specific_y)
			add_child(fruit)
			var random = RandomNumberGenerator.new()
			random.randomize()
			var random_int = random.randi_range(1, 10)  # 生成1到10之间（包括1和10）的随机整数
			print("next")
			print(random_int)
			self.remove_child(new_fruit)
			new_fruit.queue_free
			if random_int<5:
				fruit = anon_scene.instantiate()
				fruit.add_to_group("fruit")

				new_fruit=anon_scene.instantiate()

			if random_int>4 and random_int<9:
				fruit = soyo_scene.instantiate()
				fruit.add_to_group("fruit")

				new_fruit=soyo_scene.instantiate()

			if random_int>8:
				fruit = mutsumi_scene.instantiate()
				fruit.add_to_group("fruit")

				new_fruit=mutsumi_scene.instantiate()
			
			new_fruit.gravity_scale=0
			new_fruit.position=Vector2(100,500)
			add_child(new_fruit)
		elif not is_start:
			fruit.position = Vector2(x_position, specific_y)
			add_child(fruit)
			var random = RandomNumberGenerator.new()
			random.randomize()
			var random_int = random.randi_range(1, 10)  # 生成1到10之间（包括1和10）的随机整数
			print("next")
			print(random_int)
			
			self.remove_child(new_fruit)
			new_fruit.queue_free
			if random_int<5:
				fruit = anon_scene.instantiate()
				fruit.add_to_group("fruit")
				new_fruit=anon_scene.instantiate()

			if random_int>4 and random_int<9:
				fruit = soyo_scene.instantiate()
				fruit.add_to_group("fruit")
				new_fruit=soyo_scene.instantiate()

			if random_int>8:
				fruit = mutsumi_scene.instantiate()
				fruit.add_to_group("fruit")
				new_fruit=mutsumi_scene.instantiate()

			new_fruit.gravity_scale=0
			new_fruit.position=Vector2(100,500)
			add_child(new_fruit)
	


func _on_merge_fruits(fruit1, fruit2):
	if $FruitSpawnTimer.is_stopped():
	# 计算新水果的生成位置，取两个碰撞水果位置的平均值
		var new_position = (fruit1.position + fruit2.position) / 2
		if fruit1.is_in_group("anon"):
	# 实例化更高等级的水果
			upper_fruit = soyo_scene.instantiate()
			upper_fruit.add_to_group("fruit")
			$AnonLove.play()
			score+=1
		if fruit1.is_in_group("soyo"):
			upper_fruit = mutsumi_scene.instantiate()
			upper_fruit.add_to_group("fruit")
			$SoyoNeed.play()
			score+=2
		if fruit1.is_in_group("mutsumi"):
			upper_fruit=sakiko_scene.instantiate()
			upper_fruit.add_to_group("fruit")
			$MutsumiMove.play()
			score+=3
		if fruit1.is_in_group("sakiko"):
			upper_fruit = mortis_scene.instantiate()
			upper_fruit.add_to_group("fruit")
			$SakikoWeak.play()
			score+=4
		if fruit1.is_in_group("mortis"):
			upper_fruit = raana_scene.instantiate()
			upper_fruit.add_to_group("fruit")
			$MortisDie.play()
			score+=5
		if fruit1.is_in_group("raana"):
			upper_fruit = rikki_scene.instantiate()
			upper_fruit.add_to_group("fruit")
			$RaanaLive.play()
			score+=6
		if fruit1.is_in_group("rikki"):
			upper_fruit = tomorin_scene.instantiate()
			upper_fruit.add_to_group("fruit")
			$RikkiAnon.play()
			score+=7
		#if fruit1.is_in_group("tomorin"):
			#upper_fruit = anon_scene.instantiate()
			#upper_fruit.add_to_group("fruit")
			$Label.show()
			$LabelTimer.start()
		upper_fruit.position = new_position
		#new_fruit.position = fruit1.position
		# 将新水果添加到场景中/
		add_child(upper_fruit)
		#new_fruit.call_deferred("set_shape_as_one_way_collision", 0, true)

		# 从场景中移除碰撞的水果
		fruit1.queue_free()
		fruit2.queue_free()
		$FruitSpawnTimer.start()
	


func _on_fruit_timer_timeout() -> void:
	$FruitTimer.stop() # Replace with function body.


func _on_fruit_spawn_timer_timeout() -> void:
	$FruitSpawnTimer.stop() # Replace with function body.


func _on_label_timer_timeout() -> void:
	$Label.hide() # Replace with function body.


func _on_judge_line_game_over() -> void:
	$Label.text = "game over"+"\n"+"总分："+str(score) # Replace with function body.
	$BcakMusic.stop()
	$Die.play()
	$Label.show()
	$MessageTimer.start()
	get_tree().call_group("fruit", "queue_free")

	await $MessageTimer.timeout
	$BcakMusic.play()
	$Label.hide()


func _on_message_timer_timeout() -> void:
	pass # Replace with function body.


func _on_count_time(time) -> void:
	$ScoreLabel.text ="碰到爱音两秒结束："+"\n"+str(time) # Replace with function body.

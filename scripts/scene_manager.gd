extends Node

signal loading_progress(progress: float) 

var current_scene: Node

func _ready() -> void:
	_load_initial_scene()

func _load_initial_scene() -> void:
	var initial_scene = ProjectSettings.get_setting(SceneTransitionsSettings.INITIAL_SCENE_SETTING_PATH) as String
	if initial_scene.is_empty():
		print("No initial scene was set in the scene manager")
		return

	load_scene(initial_scene)

func _start_transition(scene_path: String, transition_packed: PackedScene = null) -> void:
	var instance = transition_packed.instantiate() as SceneTransition
	get_tree().root.call_deferred("add_child", instance)

	instance.ready.connect(
		func () -> void:
			instance.play_out(
				func () -> void:
					print("Play out")
					_do_change_scene(scene_path, instance)
			)
	)

func _end_transition(transition_instance: SceneTransition) -> void:
	transition_instance.play_in(
		func () -> void:
			print("Play in")
	)


func _do_change_scene(scene_path: String, transition_instance: SceneTransition = null) -> void:
	if current_scene:
		current_scene.queue_free()
		
	if transition_instance:
		loading_progress.connect(transition_instance.update_progress)

	ResourceLoader.load_threaded_request(scene_path)

	var progress: Array = [0]
	var loading_precentage = 0
	while loading_precentage < 1 :
		ResourceLoader.load_threaded_get_status(scene_path, progress)
		loading_precentage = progress[0]
		loading_progress.emit(loading_precentage)
		
	var loaded_resource = ResourceLoader.load_threaded_get(scene_path) as PackedScene
	var scene_instance = loaded_resource.instantiate()
	
	get_tree().root.call_deferred("add_child", scene_instance)
	current_scene = scene_instance

	if transition_instance:
		_end_transition(transition_instance)
	
	

func load_scene(scene_path: String, transition_data: SceneTransitionData = null) -> void:
	if transition_data:
		_start_transition(scene_path, transition_data.transition)
		return
	
	_do_change_scene(scene_path)
	

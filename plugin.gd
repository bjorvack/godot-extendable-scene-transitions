@tool
extends EditorPlugin

const AUTOLOAD_NAME = "SceneManager"
const AUTOLOAD_PATH = "res://addons/scene_transitions/scripts/scene_manager.gd"

func _enable_plugin():
	add_autoload_singleton(AUTOLOAD_NAME, AUTOLOAD_PATH)
	add_initial_scene_setting()

func _disable_plugin():
	remove_autoload_singleton(AUTOLOAD_NAME)
	
func add_initial_scene_setting() -> void:
	if not ProjectSettings.has_setting(SceneTransitionsSettings.INITIAL_SCENE_SETTING_PATH):
		ProjectSettings.set_setting(SceneTransitionsSettings.INITIAL_SCENE_SETTING_PATH, "")
	
	var property_info = {
		"name": SceneTransitionsSettings.INITIAL_SCENE_SETTING_PATH,
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_FILE,
		"hint_string": "*.tscn,*.scn,*.res"
	}
	ProjectSettings.add_property_info(property_info)

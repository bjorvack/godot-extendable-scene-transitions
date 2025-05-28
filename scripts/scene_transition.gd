extends Control

class_name SceneTransition

func update_progress(progress: float) -> void:
	print(str(progress))

func play_out(callback: Callable = Callable()) -> void:
	callback.call()

func play_in(callback: Callable = Callable()) -> void:
	callback.call()
	queue_free()

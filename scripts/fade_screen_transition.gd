extends SceneTransition

class_name FadeTransition

@export var fade_out_time: float = 0.5
@export var fade_in_time: float = 0.5

@onready var fade_rect: ColorRect = $FadeRect

var tween: Tween = null

func _ready() -> void:
	fade_rect.color.a = 0.0
	hide()

func play_out(callback: Callable = Callable()) -> void:
	show()
	if tween:
		tween.kill()
	tween = create_tween()
	var action = tween.tween_property(fade_rect, "color:a", 1.0, fade_out_time)
	if action:
		action.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(callback)

func play_in(callback: Callable = Callable()) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	var action = tween.tween_property(fade_rect, "color:a", 0.0, fade_in_time)
	if action:
		action.set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(
		func () -> void:
			callback.call()
			hide()
			queue_free()
	)

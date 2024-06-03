extends ProgressBar

func  _ready():
	update_bar(0, 10)

func update_bar(score, max):
	
	max_value = max
	
	var bar_tween = get_tree().create_tween()
	bar_tween.tween_property(self, "value", snapped(score, 1), 1).set_trans(Tween.TRANS_LINEAR)

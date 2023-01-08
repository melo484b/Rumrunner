extends WindowDialog


func show_content_error() -> void:
	$Content.visible = true
	$ContentMissing.visible = false

func show_content_missing_error() -> void:
	$ContentMissing.visible = true
	$Content.visible = false

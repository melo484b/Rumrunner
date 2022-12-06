extends CanvasLayer


var id_to_check: int = 1
var card_record: PackedScene = preload("res://UI/CardRecord.tscn")

onready var name_label: Label = $MarginContainer/PanelContainer/MarginContainer/ReportTable/Panel/CenterContainer/PlayerName
onready var table: MarginContainer = $MarginContainer/PanelContainer/MarginContainer/ReportTable
onready var records: VBoxContainer = $MarginContainer/PanelContainer/MarginContainer/ReportTable/Panel/MarginContainer/ScrollContainer/Records


func _ready() -> void:
	show_table()


func show_table() -> void:
	table.visible = true
	

func hide_table() -> void:
	table.visible = false


func _on_CloseReportButton_button_down() -> void:
	hide_table()


func _on_CheckPlayer1_button_down() -> void:
	id_to_check = 1
	show_table()


func _on_CheckPlayer2_button_down() -> void:
	id_to_check = 2
	show_table()


func _on_CheckPlayer3_button_down() -> void:
	id_to_check = 3
	show_table()

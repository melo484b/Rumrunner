using Godot;
using System;

public class PlayerHandManager : Node
{
	private PackedScene card;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }

	public void DrawCards(Node2D spawnNode)
	{
		
	}
	
	public void SpawnCard(Node2D spawnNode)
	{
		var scene = GD.Load<PackedScene>("res://card/Card.tscn");
		var inst = scene.Instance<Node2D>();
		inst.Position = new Vector2(300, 540);
		spawnNode.AddChild(inst);
	}

}

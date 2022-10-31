using Godot;
using System;

public class Card_Nodes : Node2D
{
	private Vector2 bowPosition;
	private Vector2 portPosition;
	private Vector2 starboardPosition;
	private Vector2 sternPosition;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		bowPosition = GetNode<Node2D>("Bow_Node").Position;
		portPosition = GetNode<Node2D>("Port_Node").Position;
		starboardPosition = GetNode<Node2D>("Bow_Node").Position;
		sternPosition = GetNode<Node2D>("Bow_Node").Position;
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}

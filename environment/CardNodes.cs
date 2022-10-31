using Godot;
using System;
using System.Collections.Generic;

public class CardNodes : Node2D
{
	private Dictionary<String, Vector2> nodePositions = new Dictionary<String, Vector2>();
	private Vector2 bowPosition;
	private Vector2 portPosition;
	private Vector2 starboardPosition;
	private Vector2 sternPosition;
	private float MAX_DISTANCE = 100.0f;

	public override void _Ready()
	{
		nodePositions.Add("bow", GetNode<Node2D>("BowNode").Position);
		nodePositions.Add("port", GetNode<Node2D>("PortNode").Position);
		nodePositions.Add("starboard", GetNode<Node2D>("StarboardNode").Position);
		nodePositions.Add("stern", GetNode<Node2D>("SternNode").Position);
	}

	public Vector2 GetClosestNodePosition(Vector2 cardPosition)
	{
		Vector2 currentClosestPosition = new Vector2(0, 0);
		foreach(KeyValuePair<String, Vector2> position in nodePositions)
		{
			if (cardPosition.DistanceTo(position.Value) < MAX_DISTANCE)
			{
				currentClosestPosition = position.Value;
			} 
		}
		return currentClosestPosition;
	}
}

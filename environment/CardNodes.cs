using Godot;
using System;
using System.Collections.Generic;

public class CardNodes : Node2D
{
	private Dictionary<String, Vector2> nodePositions = new Dictionary<String, Vector2>();
	private Node2D bow;
	private Node2D port;
	private Node2D starboard;
	private Node2D stern;
	private float MAX_DISTANCE = 100.0f;
	
	[Signal]
	public delegate void CardAbove(Vector2 closestPosition);

	public override void _Ready()
	{
		bow = GetNode<Node2D>("BowNode");
		port = GetNode<Node2D>("PortNode");
		starboard = GetNode<Node2D>("StarboardNode");
		stern = GetNode<Node2D>("SternNode");
		nodePositions.Add("bow", bow.Position);
		nodePositions.Add("port", port.Position);
		nodePositions.Add("starboard", starboard.Position);
		nodePositions.Add("stern", stern.Position);
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
	
	void OnBowCardDetectorAreaEntered(object area)
	{
		EmitSignal("CardAbove", bow.Position);
		GD.Print(bow.Position);
	}

	void OnBowCardDetectorAreaExited(object area)
	{
		
	}


	void OnPortCardDetectorAreaEntered(object area)
	{
		EmitSignal("CardAbove", port.Position);
		GD.Print(port.Position);
	}


	void OnPortCardDetectorAreaExited(object area)
	{
		
	}


	void OnStarboardCardDetectorAreaEntered(object area)
	{
		EmitSignal("CardAbove", starboard.Position);
		GD.Print(starboard.Position);
	}


	void OnStarboardCardDetectorAreaExited(object area)
	{
		
	}


	void OnSternCardDetectorAreaEntered(object area)
	{
		EmitSignal("CardAbove", stern.Position);
		GD.Print(stern.Position);
	}


	void OnSternCardDetectorAreaExited(object area)
	{
		
	}

}

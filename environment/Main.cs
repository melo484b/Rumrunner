using Godot;
using System;

public class Main : Node2D
{
	PlayerHandManager handManager;
	Node2D playerCards;

	public override void _Ready()
	{
		handManager = (PlayerHandManager) GetNode<Node>("PlayerHandManager");
		playerCards = GetNode<Node2D>("PlayerCards");
		handManager.SpawnCard(playerCards);
	}

}

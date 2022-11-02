using Godot;
using System;

public class Card : Node2D
{
	private bool readyToMove = false;
	private bool selectable = true;
	private Vector2 clickPosition;
	private Vector2 distanceMoved = new Vector2(0, 0);
	private Area2D collider;
	
	private int cardId = -1;
	private string cardName = "Placeholder Cat";
	private string cardClass = "";
	private int artId = -1;
	private string description = "";
	private int offensiveStat = -1;
	private int defensiveStat = -1;
	private int cost = -1;
	
	public override void _Ready()
	{
		collider = GetNode<Area2D>("CardCollider");
	}

	[Obsolete]
	public override void _PhysicsProcess(float _delta)
	{
		if (selectable) 
		{
			if (Input.IsActionJustPressed("left_click") && readyToMove)
			{
				Raise();
				collider.Monitorable = true;
				clickPosition = GetGlobalMousePosition();
				distanceMoved = GetPosition() - clickPosition;
			}
			if (Input.IsActionPressed("left_click") && readyToMove)
			{
				SetPosition(GetGlobalMousePosition() + distanceMoved);
			}
			if (Input.IsActionJustReleased("left_click"))
			{
				collider.Monitorable = false;
			}
		}
	}
	
	private void _on_CardBody_mouse_entered()
	{
		readyToMove = true;
	}

	private void _on_CardBody_mouse_exited()
	{
		readyToMove = false;
	}
	
	void SetCardId(int cardId)
	{
		this.cardId = cardId;
	}
	int GetCardId()
	{
		return this.cardId;
	}
	void SetCardName(string cardName)
	{
		this.cardName = cardName;
	}
	string GetCardName()
	{
		return this.cardName;
	}
	void SetCardClass(string cardClass)
	{
		this.cardClass = cardClass;
	}
	string GetCardClass()
	{
		return this.cardClass;
	}
	void SetArtId(int artId)
	{
		this.artId = artId;
	}
	int GetArtId()
	{
		return this.artId;
	}
	void SetDescription(string description)
	{
		this.description = description;
	}
	string GetDescription()
	{
		return this.description;
	}
	void SetOffensiveStat(int offensiveStat)
	{
		this.offensiveStat = offensiveStat;
	}
	int GetOffensiveStat()
	{
		return this.offensiveStat;
	}
	void SetDefensiveStat(int defensiveStat)
	{
		this.defensiveStat = defensiveStat;
	}
	int GetDefensiveStat()
	{
		return this.defensiveStat;
	}
	void SetCost(int cost)
	{
		this.cost = cost;
	}
	int GetCost()
	{
		return this.cost;
	}
}

using Godot;
using System;

public class Card : Panel
{
	private bool readyToMove = false;
	private bool selectable = true;
	private Vector2 clickPosition;
	private Vector2 distanceMoved = new Vector2(0, 0);

	public override void _Ready()
	{
		
	}

	public override void _PhysicsProcess(float _delta)
	{
		if (selectable) 
		{
			if (Input.IsActionJustPressed("left_click") && readyToMove)
			{
				Raise();
				clickPosition = GetGlobalMousePosition();
				distanceMoved = GetPosition() - clickPosition;
			}
			if (Input.IsActionPressed("left_click") && readyToMove)
			{
				SetPosition(GetGlobalMousePosition() + distanceMoved);
			}
		}
	}
	
	void _on_Card_mouse_entered()
	{
		readyToMove = true;
	}


	void _on_Card_mouse_exited()
	{
		readyToMove = false;
	}
	
}


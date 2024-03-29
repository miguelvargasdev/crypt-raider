using Godot;
using Godot.Collections;

public partial class Inventory : PanelContainer
{
	[Export] public PackedScene BagUI { get; set; }
	[Export] public Array<Bag> Bags { get; set; }
	[Export] public VBoxContainer BagContainer { get; set; }

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		foreach (Bag bag in Bags)
		{
			GD.Print("Creating new bag...");
			BagUI bagUI = (BagUI)BagUI.Instantiate();
			bagUI.Bag = bag;
			BagContainer.AddChild(bagUI);
			GD.Print("Bag created!");
		}
	}
}

using Godot;
using System;


[GlobalClass]
public partial class BagData : Resource
{
    [Export] public string name;
    [Export] public Vector2I size;
}

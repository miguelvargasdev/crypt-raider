using Godot;

[GlobalClass]
public partial class ItemData : Resource
{
    public string Name { get; set; }
    public string Description { get; set; }
    public Vector2I Size { get; set; }
    public Texture2D Icon { get; set; }
    public Mesh Model { get; set; }

}
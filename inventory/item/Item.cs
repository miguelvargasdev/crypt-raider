using Godot;

public partial class Item : Node
{
    // Define properties for your item
    public ItemData Data { get; set; }
    public string Name { get; set; }
    public string Description { get; set; }
    public Vector2I Size { get; set; }
    public Texture Icon { get; set; }
    public Mesh Model { get; set; }


    public void Initialize(){
        Name = "Item";
        Description = "This is an item";
        Size = new Vector2I(1, 1);
        Icon = GD.Load<Texture>("res://icon.svg");
        Model = null;
    }
    public void Initialize(ItemData data)
    {
        Data = data;
        Name = data.Name;
        Description = data.Description;
        Size = data.Size;
        Icon = data.Icon;
        Model = data.Model;
    }
}
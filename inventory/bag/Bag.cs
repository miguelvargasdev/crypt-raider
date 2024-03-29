using Godot;
using Godot.Collections;

public partial class Bag : Node
{

    [Export]public BagData Data { get; set; }
    public string Name { get; set; }
    public Vector2I Size { get; set; }
    [Export]public Array<Array<Item>> Items { get; set; } = new Array<Array<Item>>();

    public override void _Ready()
    {
        Initialize(Data);
    }

    public void Initialize(BagData data)
    {
        Data = data;
        Name = data.name;
        Size = data.size;
        for (int i = 0; i < Size.Y; i++)
        {
            Array<Item> RowOfItems = new Array<Item>();
            for (int j = 0; j < Size.X; j++)
            {
                Item newItem = new Item();
                newItem.Initialize();
                RowOfItems.Add(newItem);
            }
            Items.Add(RowOfItems);
        }
    }

    // public void AddItem(Item item)
    // {
    //     Items.Add(item);
    // }
    // public void RemoveItem(Item item)
    // {
    //     Items.Remove(item);
    // }

    public void Clear()
    {
        Items.Clear();
    }

}
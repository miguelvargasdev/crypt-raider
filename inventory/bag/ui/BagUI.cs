using Godot;
using Godot.Collections;


public partial class BagUI : Control
{
    private Array<Array<SlotUI>> slots = new Array<Array<SlotUI>>();
    private Array<Array<SlotUI>> itemSlots = new Array<Array<SlotUI>>();
    private Bag bag;
    public Bag Bag
    {
        get
        {
            return bag;
        }
        set
        {
            bag = value;
            Initialize(bag);
        }
    }
    [Export] public PackedScene SlotScene { get; set; }
    [Export] public GridContainer SlotGrid { get; set; }

    [Export] public TabBar BagName { get; set; }

    public override void _Ready()
    {
    }
    public void Initialize(Bag bag)
    {
        BagName.SetTabTitle(0, bag.Name);
        GenerateGrid(bag.Size.X, bag.Size.Y);
    }

    public void GenerateGrid(int columns, int rows)
    {
        SlotGrid.Columns = columns;

        for (int i = 0; i < rows; i++)
        {
            Array<SlotUI> RowOfSlots = new Array<SlotUI>();
            for (int j = 0; j < columns; j++)
            {
                SlotUI slot = (SlotUI)SlotScene.Instantiate();
                slot.Item = bag.Items[i][j];
                slot.SlotPosition = new Vector2I(j, i);
                slot.SlotClicked += OnSlotClicked;
                SlotGrid.AddChild(slot);
                RowOfSlots.Add(slot);
            }
            slots.Add(RowOfSlots);
        }
    }

    public void OnSlotClicked(SlotUI slot)
    {
        GD.PrintRich($"Slot clicked: [color=green]{Bag.Name}[/color] {slot.SlotPosition} [color=red]{slot.Item.Name}[/color]");
    }


}
using Godot;

public partial class SlotUI: Control
{
    public bool Occupied { get; set; }
    private Vector2I slotPosition;
    public Vector2I SlotPosition 
    { 
        get
        {
            return slotPosition;
        }
        set
        {
            slotPosition = value;
            PositionLabel.Text = $"({slotPosition.X}, {slotPosition.Y})";
        }
    }
    public Item Item { get; set; }
    [Export] public TextureRect Icon { get; set; }
    [Export] public Label Label { get; set; }
    [Export] public Label PositionLabel {get;set;}
    [Export] public MarginContainer ItemContainer { get; set; }

    [Signal] public delegate void SlotClickedEventHandler(SlotUI slot);

    public override void _Ready()
    {
        Initialize();
    }
    public void Initialize()
    {
        Icon = GetNode<TextureRect>("ItemContainer/ItemIcon");
        Label = GetNode<Label>("ItemLabel");
        PositionLabel = GetNode<Label>("PositionLabel");
        ItemContainer = GetNode<MarginContainer>("ItemContainer");
    }
    public override void _GuiInput(InputEvent @event)
    {
        if(@event is InputEventMouseButton mouseButton && mouseButton.Pressed)
        {
            EmitSignal(SignalName.SlotClicked, this);
        }
    }

    public void SetItem(Item item)
    {
        Item = item;
        Icon.Texture = (Texture2D)item.Icon;
        Label.Text = item.Name;
        Occupied = true;
    }

    public void ClearItem()
    {
        Item = null;
        Icon.Texture = null;
        Label.Text = "";
        Occupied = false;
    }

    public void ResizeItemContainer(Item item)
    {
        ItemContainer.SetSize(item.Size * 31);
    }
    public void ToggleItemContainerVisibility(bool visible)
    {
        ItemContainer.Visible = visible;
    }
}
namespace MAP___Laborator_10.domain;

internal class Entity<ID>
{
    public Entity() { }

    public Entity(ID id)
    {
        this.id = id;
    }

    private ID id;

    public ID Id
    {
        get { return id; }
        set { id = value; }
    }
}
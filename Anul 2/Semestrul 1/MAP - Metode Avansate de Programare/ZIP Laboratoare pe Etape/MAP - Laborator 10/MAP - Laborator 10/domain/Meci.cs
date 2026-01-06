namespace MAP___Laborator_10.domain;

internal class Meci : Entity<int>
{
    private Echipa echipa1;
    private Echipa echipa2;
    private DateTime data;

    public Meci(int id, Echipa echipa1, Echipa echipa2, DateTime data) : base(id)
    {
        this.echipa1 = echipa1;
        this.echipa2 = echipa2;
        this.data = data;
    }

    public Echipa Echipa1
    {
        get { return echipa1; }
    }

    public Echipa Echipa2
    {
        get { return echipa2; }
    }

    public DateTime Data
    {
        get { return data; }
        set { data = value; }
    }

    public override string ToString()
    {
        return $"Team 1: {echipa1} Team 2: {echipa2} Date: {data}";
    }
}
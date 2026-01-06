namespace MAP___Laborator_10.domain;

internal class Elev : Entity<int>
{
    private string nume;
    private string scoala;

    public Elev(int id, string nume, string scoala) : base(id)
    {
        this.nume = nume;
        this.scoala = scoala;
    }

    public string elev_nume
    {
        get { return nume; }
        set { nume = value; }
    }

    public string elev_scoala
    {
        get { return scoala; }
        set { scoala = value; }
    }

    public override string ToString()
    {
        return $"ID: {Id} Name: {nume} School: {scoala}";
    }
}
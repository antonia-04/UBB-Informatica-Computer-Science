namespace MAP___Laborator_10.domain;

internal class Jucator : Elev
{
    public Echipa echipa { get; private set; }

    public Jucator(int id, string nume, string scoala, Echipa echipa) : base(id, nume, scoala)
    {
        this.echipa = echipa;
    }

    public override string ToString()
    {
        return base.ToString() + $" Team: {echipa}";
    }
}
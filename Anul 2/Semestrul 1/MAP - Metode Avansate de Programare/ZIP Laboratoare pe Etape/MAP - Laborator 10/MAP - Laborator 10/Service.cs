namespace MAP___Laborator_10.repository;

using MAP___Laborator_10.domain;

//using LINQ to query the data
internal class Service
{
    private Repository<int, Echipa> RepoEchipa;
    private Repository<int, Elev> RepoElev;
    private Repository<int, Meci> RepoMeci;
    private Repository<int, Jucator> RepoJucator;
    private Repository<int, JucatorActiv> RepoJucatorActiv;

    public Service(Repository<int, Elev> repoElev, Repository<int, Echipa> repoEchipa,
        Repository<int, Meci> repoMeci, Repository<int, Jucator> repoJucator,
        Repository<int, JucatorActiv> jucatorActiv)
    {
        RepoEchipa = repoEchipa;
        RepoElev = repoElev;
        RepoMeci = repoMeci;
        RepoJucator = repoJucator;
        RepoJucatorActiv = jucatorActiv;
    }

    public IEnumerable<Jucator> jucatoriiEchipei(Echipa echipa)
    {
        //linq query with lambda expression
        return RepoJucator.FindAll().Where(j =>
        {
            Jucator jucator = (Jucator)j;
            return j.echipa.Equals(echipa);
        });
    }

    public IEnumerable<Jucator> jucatoriActiviMeci(Echipa echipa, Meci meci)
    {
        return
            from jucatorActiv in RepoJucatorActiv.FindAll()
            join jucator in RepoJucator.FindAll()
                on jucatorActiv.IdJucator equals jucator.Id
            where jucatorActiv.IdMeci == meci.Id
                  && jucator.echipa.Id == echipa.Id
            select jucator;
    }

    public IEnumerable<Meci> meciuriData(DateTime beginingDate, DateTime endingDate)
    {
        return
            from meci in RepoMeci.FindAll()
            where meci.Data >= beginingDate && meci.Data <= endingDate
            select meci;
    }
    // gets the score of a match by summing the points of the players that played in that match
    public string scorMeci(Meci meci)
    {
        int scorEchipa1 = 0;
        try
        {
            scorEchipa1 =
                (from jucatorActiv in RepoJucatorActiv.FindAll()
                    join jucator in RepoJucator.FindAll()
                        on jucatorActiv.IdJucator equals jucator.Id
                    join echipa in RepoEchipa.FindAll()
                        on jucator.echipa.Id equals echipa.Id
                    where jucatorActiv.IdMeci == meci.Id
                          && meci.Echipa1.Id == echipa.Id
                    select jucatorActiv.NrPuncte).Sum();
        }
        catch
        {
        }

        int scorEchipa2 = 0;
        try
        {
            scorEchipa2 =
                (from jucatorActiv in RepoJucatorActiv.FindAll()
                    join jucator in RepoJucator.FindAll()
                        on jucatorActiv.IdJucator equals jucator.Id
                    join echipa in RepoEchipa.FindAll()
                        on jucator.echipa.Id equals echipa.Id
                    where jucatorActiv.IdMeci == meci.Id
                          && meci.Echipa2.Id == echipa.Id
                    select jucatorActiv.NrPuncte).Sum();
        }
        catch
        {
        }

        return scorEchipa1.ToString() + " - " + scorEchipa2.ToString();
    }


    public Echipa findEchipa(int id)
    {
        return RepoEchipa.FindOne(id);
    }

    public Meci findMeci(int id)
    {
        return RepoMeci.FindOne(id);
    }
}
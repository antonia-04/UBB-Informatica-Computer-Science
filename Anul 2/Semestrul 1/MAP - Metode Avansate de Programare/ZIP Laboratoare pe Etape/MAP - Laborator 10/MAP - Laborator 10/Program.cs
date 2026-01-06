//cerinte
//a) sa se afiseze toti jucatorii ai unei echipe date
//b) sa se afiseze toti jucatorii activi ai unei echipe de la un anumit meci
//c) sa se afiseze toate meciurile dintr-o anumita perioada calendaristica
//d) sa se determine si sa se afiseze scorul unui anumit meci

using MAP___Laborator_10.repository;

namespace MAP___Laborator_10;

using MAP___Laborator_10.domain;

class Program
{
    static void Main(string[] args)
    {
        string connectionString = "Host=127.0.0.1;Port=5432;Database=postgres;User Id=postgres;Password=antonia;";
        EchipaRepository repoEchipa = new EchipaRepository(connectionString);
        ElevRepository repoElev = new ElevRepository(connectionString);
        JucatorRepository repoJucator = new JucatorRepository(connectionString, repoEchipa);
        JucatorActivRepository repoJucatorActiv = new JucatorActivRepository(connectionString);
        MeciRepository repoMeci = new MeciRepository(connectionString, repoEchipa);
        Console.WriteLine("Connected to the database");
        Console.WriteLine("\n");
        Service service = new Service(repoElev, repoEchipa, repoMeci, repoJucator, repoJucatorActiv);
        UI uI = new UI(service);
        uI.run();
    }
}
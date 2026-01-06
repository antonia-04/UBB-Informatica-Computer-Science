using MAP___Laborator_10.domain;

namespace MAP___Laborator_10.repository;

internal class UI
{
    private Service service;

    public UI(Service service)
    {
        this.service = service;
    }

    private int readId()
    {
        int id;
        while (true)
        {
            Console.WriteLine("Provide ID: ");
            string input = Console.ReadLine();

            if (int.TryParse(input, out id))
            {
                return id;
            }
            else
            {
                Console.WriteLine("Invalid input. Please provide an integer.");
            }
        }
    }

    private DateTime readDate()
    {
        Console.WriteLine("Date (the format must be YYYY-MM-dd): ");
        string input = Console.ReadLine();
        string format = "yyyy-MM-dd";
        DateTime parsedDate;
        if (DateTime.TryParseExact(input, format, null, System.Globalization.DateTimeStyles.None, out parsedDate))
        {
            return parsedDate;
        }
        else
        {
            Console.WriteLine("The entered date is not valid. Please use the format YYYY-MM-dd.");
            return readDate();
        }
    }

    public void run()
    {
        Console.WriteLine("Jr NBA League Romania");
        while (true)
        {
            Console.WriteLine("\n");
            Console.WriteLine("---------------------MENU-----------------------------");
            Console.WriteLine("1. Team players");
            Console.WriteLine("2. Active team players from a certain match");
            Console.WriteLine("3. Matches from a certain time interval");
            Console.WriteLine("4. Match score");
            Console.WriteLine("0. Exit");
            Console.WriteLine("\n");


            Console.Write("Enter your option : ");
            try
            {
                int cmd = int.Parse(Console.ReadLine());
                Echipa e;
                Meci m;
                switch (cmd)
                {
                    case 0:
                        return;
                    case 1:
                        e = service.findEchipa(readId());
                        if (e == null)
                        {
                            Console.WriteLine("The team was not found!");
                            break;
                        }

                        Console.WriteLine($"Players of {e.echipa_nume} are:");
                        foreach (var jucator in service.jucatoriiEchipei(e))
                            Console.WriteLine(jucator.elev_nume + " , " + jucator.elev_scoala);
                        break;
                    case 2:
                        Console.WriteLine("Provide the team: ");
                        e = service.findEchipa(readId());
                        if (e == null)
                        {
                            Console.WriteLine("The team was not found!");
                            break;
                        }
                        Console.WriteLine("Provide the match: ");
                        m = service.findMeci(readId());
                        if (m == null)
                        {
                            Console.WriteLine("The match was not found!");
                            break;
                        }

                        Console.WriteLine(
                            $"Active players of the team {e.echipa_nume} from the match on {m.Data} are:");
                        foreach (var jucator in service.jucatoriActiviMeci(e, m))
                        {
                            Console.WriteLine(jucator.elev_nume + " , " + jucator.elev_scoala);
                        }

                        break;
                    case 3:
                        Console.WriteLine("Provide the date interval: ");
                        DateTime d1 = readDate();
                        DateTime d2 = readDate();
                        foreach (var meci in
                                 service.meciuriData(d1, d2))
                        {
                            Console.WriteLine(meci.Echipa1.echipa_nume + " VS " + meci.Echipa2.echipa_nume +
                                              " played on: " +
                                              meci.Data);
                        }

                        break;
                    case 4:
                        Console.WriteLine("Provide the match: ");
                        m = service.findMeci(readId());
                        if (m == null)
                        {
                            Console.WriteLine("The match was not found!");
                            break;
                        }

                        Console.WriteLine($"The score between {m.Echipa1} and {m.Echipa2} on {m.Data:yyyy-MM-dd} is: " +
                                          service.scorMeci(m));
                        break;
                }
            }
            catch
            {
                Console.WriteLine("Please provide a valid option.");
            }
        }
    }
}
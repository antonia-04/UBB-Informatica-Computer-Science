using System.ComponentModel.DataAnnotations;

namespace MAP___Laborator_10.repository;

using MAP___Laborator_10.domain;
using Npgsql;

internal class JucatorRepository : Repository<int, Jucator>
{
    private readonly string _connectionString;
    private Repository<int, Echipa> RepoEchipa;

    public JucatorRepository(string connectionString, Repository<int, Echipa> repoEchipa)
    {
        _connectionString = connectionString;
        RepoEchipa = repoEchipa;
    }

    public Jucator FindOne(int id)
    {
        try
        {
            if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM jucator WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int id_echipa = reader.GetInt32(3);
                            Echipa echipa = RepoEchipa.FindOne(id_echipa);
                            return new Jucator(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), echipa);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in FindOne: {ex.Message}");
        }

        return null;
    }

    public IEnumerable<Jucator> FindAll()
    {
        var jucatori = new List<Jucator>();

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM jucator";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            int id_echipa = reader.GetInt32(3);
                            Echipa echipa = RepoEchipa.FindOne(id_echipa);
                            jucatori.Add(new Jucator(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), echipa));
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in FindAll: {ex.Message}");
        }

        return jucatori;
    }

    public Jucator Save(Jucator entity)
    {
        try
        {
            if (entity == null) throw new ArgumentException("Entity cannot be null.");
            if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");
            if (string.IsNullOrEmpty(entity.elev_nume)) throw new ValidationException("Name cannot be empty.");
            if (string.IsNullOrEmpty(entity.elev_scoala)) throw new ValidationException("School cannot be empty.");
            if (entity.echipa.Id == 0) throw new ValidationException("Team cannot be empty.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "INSERT INTO jucator (nume, scoala, echipa) VALUES (@Id, @Nume, @Scoala, @Echipa)";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", entity.Id);
                    command.Parameters.AddWithValue("@Nume", entity.elev_nume);
                    command.Parameters.AddWithValue("@Scoala", entity.elev_scoala);
                    command.Parameters.AddWithValue("@Echipa", entity.echipa);

                    command.ExecuteNonQuery();
                    return null;
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in Save: {ex.Message}");
            return entity;
        }
    }

    public Jucator Delete(int id)
    {
        try
        {
            if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "DELETE FROM jucator WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            int id_echipa = reader.GetInt32(3);
                            Echipa echipa = RepoEchipa.FindOne(id_echipa);
                            return new Jucator(reader.GetInt32(0), reader.GetString(1), reader.GetString(2), echipa);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in Delete: {ex.Message}");
        }

        return null;
    }

    public Jucator Update(Jucator entity)
    {
        try
        {
            if (entity == null) throw new ArgumentException("Entity cannot be null.");
            if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");
            if (string.IsNullOrEmpty(entity.elev_nume)) throw new ValidationException("Name cannot be empty.");
            if (string.IsNullOrEmpty(entity.elev_scoala)) throw new ValidationException("School cannot be empty.");
            if (entity.echipa.Id == 0) throw new ValidationException("Team cannot be empty.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "UPDATE jucator SET nume = @Nume, scoala = @Scoala, echipa = @Echipa WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Nume", entity.elev_nume);
                    command.Parameters.AddWithValue("@Scoala", entity.elev_scoala);
                    command.Parameters.AddWithValue("@Echipa", entity.echipa);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return null;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in Update: {ex.Message}");
        }

        return entity;
    }
}
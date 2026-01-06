using System.ComponentModel.DataAnnotations;
using MAP___Laborator_10.domain;
using Npgsql;

namespace MAP___Laborator_10.repository;

internal class ElevRepository : Repository<int, Elev>
{
    private readonly string _connectionString;

    public ElevRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public Elev FindOne(int id)
    {
        try
        {
            if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM elev WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Elev(reader.GetInt32(0), reader.GetString(1), reader.GetString(2));
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

    public IEnumerable<Elev> FindAll()
    {
        var elevi = new List<Elev>();

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM elev";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            elevi.Add(new Elev(reader.GetInt32(0), reader.GetString(1), reader.GetString(2)));
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in FindAll: {ex.Message}");
        }

        return elevi;
    }

    public Elev Save(Elev entity)
    {
        try
        {
            if (entity == null) throw new ArgumentException("Entity cannot be null.");
            if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");
            if (string.IsNullOrEmpty(entity.elev_nume)) throw new ValidationException("Name cannot be empty.");
            if (string.IsNullOrEmpty(entity.elev_scoala)) throw new ValidationException("School cannot be empty.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "INSERT INTO elev (nume, scoala) VALUES (@nume, @scoala)";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@nume", entity.elev_nume);
                    command.Parameters.AddWithValue("@scoala", entity.elev_scoala);

                    command.ExecuteNonQuery();
                    return null;
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in Save: {ex.Message}");
        }

        return entity;
    }

    public Elev Delete(int id)
    {
        try
        {
            if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "DELETE FROM elev WHERE id = @id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Elev(reader.GetInt32(0), reader.GetString(1), reader.GetString(2));
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

    public Elev Update(Elev entity)
    {
        try
        {
            if (entity == null) throw new ArgumentException("Entity cannot be null.");
            if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");
            if (string.IsNullOrEmpty(entity.elev_nume)) throw new ValidationException("Name cannot be empty.");
            if (string.IsNullOrEmpty(entity.elev_scoala)) throw new ValidationException("School cannot be empty.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "UPDATE elev SET nume = @nume, scoala = @scoala WHERE id = @id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", entity.Id);
                    command.Parameters.AddWithValue("@nume", entity.elev_nume);
                    command.Parameters.AddWithValue("@scoala", entity.elev_scoala);

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
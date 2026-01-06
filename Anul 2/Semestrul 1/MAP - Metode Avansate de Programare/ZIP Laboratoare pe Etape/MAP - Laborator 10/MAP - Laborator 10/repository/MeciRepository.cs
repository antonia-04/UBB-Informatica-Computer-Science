using System.ComponentModel.DataAnnotations;

namespace MAP___Laborator_10.repository;

using MAP___Laborator_10.domain;
using Npgsql;

internal class MeciRepository : Repository<int, Meci>
{
    private readonly string _connectionString;
    private Repository<int, Echipa> RepoEchipa;

    public MeciRepository(string connectionString, Repository<int, Echipa> repoEchipa)
    {
        _connectionString = connectionString;
        RepoEchipa = repoEchipa;
    }

    public Meci FindOne(int id)
    {
        if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM meci WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            Echipa echipa1 = RepoEchipa.FindOne(reader.GetInt32(1));
                            Echipa echipa2 = RepoEchipa.FindOne(reader.GetInt32(2));
                            var data = reader.GetDateTime(3);
                            return new Meci(reader.GetInt32(0), echipa1, echipa2, data);
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

    public IEnumerable<Meci> FindAll()
    {
        var meciuri = new List<Meci>();

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM meci";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Echipa echipa1 = RepoEchipa.FindOne(reader.GetInt32(1));
                            Echipa echipa2 = RepoEchipa.FindOne(reader.GetInt32(2));
                            var data = reader.GetDateTime(3);
                            meciuri.Add(new Meci(reader.GetInt32(0), echipa1, echipa2, data));
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in FindAll: {ex.Message}");
        }

        return meciuri;
    }

    public Meci Save(Meci entity)
    {
        if (entity == null) throw new ArgumentException("Entity cannot be null.");
        if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "INSERT INTO meci (echipa1id, echipa2id, data) VALUES (@Echipa1Id, @Echipa2Id, @Data)";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Echipa1Id", entity.Echipa1.Id);
                    command.Parameters.AddWithValue("@Echipa2Id", entity.Echipa2.Id);
                    command.Parameters.AddWithValue("@Data", entity.Data);

                    command.ExecuteNonQuery();
                }
            }

            return entity;
        }
        catch (NpgsqlException ex)
        {
            Console.WriteLine($"Error in Save: {ex.Message}");
            return null;
        }
    }

    public Meci Delete(int id)
    {
        if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "DELETE FROM meci WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);

                    int affectedRows = command.ExecuteNonQuery();
                    if (affectedRows > 0)
                    {
                        return new Meci(id, null, null, DateTime.MinValue);
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

    public Meci Update(Meci entity)
    {
        if (entity == null) throw new ArgumentException("Entity cannot be null.");
        if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query =
                    "UPDATE meci SET echipa1id = @Echipa1Id, echipa2id = @Echipa2Id, data = @Data WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", entity.Id);
                    command.Parameters.AddWithValue("@Echipa1Id", entity.Echipa1.Id);
                    command.Parameters.AddWithValue("@Echipa2Id", entity.Echipa2.Id);
                    command.Parameters.AddWithValue("@Data", entity.Data);

                    int affectedRows = command.ExecuteNonQuery();
                    if (affectedRows > 0)
                    {
                        return null;
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
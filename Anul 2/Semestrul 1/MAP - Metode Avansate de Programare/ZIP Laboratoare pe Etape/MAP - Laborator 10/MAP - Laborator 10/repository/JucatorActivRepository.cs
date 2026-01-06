namespace MAP___Laborator_10.repository;

using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using MAP___Laborator_10.domain;

internal class JucatorActivRepository : Repository<int, JucatorActiv>
{
    private readonly string _connectionString;

    public JucatorActivRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    public JucatorActiv FindOne(int id)
    {
        try
        {
            if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM jucatoractiv WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new JucatorActiv(reader.GetInt32(0), reader.GetInt32(1), reader.GetInt32(2),
                                reader.GetInt32(3), reader.GetString(4));
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

    public IEnumerable<JucatorActiv> FindAll()
    {
        var jucatoriActiv = new List<JucatorActiv>();

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM jucatoractiv";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            jucatoriActiv.Add(new JucatorActiv(reader.GetInt32(0), reader.GetInt32(1),
                                reader.GetInt32(2), reader.GetInt32(3), reader.GetString(4)));
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in FindAll: {ex.Message}");
        }

        return jucatoriActiv;
    }

    public JucatorActiv Save(JucatorActiv entity)
    {
        try
        {
            if (entity == null) throw new ArgumentException("Entity cannot be null.");
            if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");
            if (string.IsNullOrEmpty(entity.Tip)) throw new ValidationException("Type cannot be empty.");
            if (entity.NrPuncte < 0) throw new ValidationException("Number of points cannot be negative.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query =
                    "INSERT INTO jucatoractiv (id_jucator, id_meci, nr_puncte, tip) VALUES (@IdJucator, @IdMeci, @NrPuncte, @Tip)";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@IdJucator", entity.IdJucator);
                    command.Parameters.AddWithValue("@IdMeci", entity.IdMeci);
                    command.Parameters.AddWithValue("@NrPuncte", entity.NrPuncte);
                    command.Parameters.AddWithValue("@Tip", entity.Tip);

                    command.ExecuteNonQuery();
                }
            }

            return null;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in Save: {ex.Message}");
            return entity;
        }
    }

    public JucatorActiv Delete(int id)
    {
        try
        {
            if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "DELETE FROM jucatoractiv WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", id);

                    int affectedRows = command.ExecuteNonQuery();
                    if (affectedRows > 0)
                    {
                        return new JucatorActiv(id, 0, 0, 0, string.Empty); // You can modify this to reflect a complete entity
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

    public JucatorActiv Update(JucatorActiv entity)
    {
        try
        {
            if (entity == null) throw new ArgumentException("Entity cannot be null.");
            if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");
            if (string.IsNullOrEmpty(entity.Tip)) throw new ValidationException("Type cannot be empty.");
            if (entity.NrPuncte < 0) throw new ValidationException("Number of points cannot be negative.");

            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query =
                    "UPDATE jucatoractiv SET id_jucator = @IdJucator, id_meci = @IdMeci, nr_puncte = @NrPuncte, tip = @Tip WHERE id = @Id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Id", entity.Id);
                    command.Parameters.AddWithValue("@IdJucator", entity.IdJucator);
                    command.Parameters.AddWithValue("@IdMeci", entity.IdMeci);
                    command.Parameters.AddWithValue("@NrPuncte", entity.NrPuncte);
                    command.Parameters.AddWithValue("@Tip", entity.Tip);

                    command.ExecuteNonQuery();
                }
            }

            return null;
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in Update: {ex.Message}");
        }

        return entity;
    }
}
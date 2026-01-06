using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace MAP___Laborator_10.repository;

using MAP___Laborator_10.domain;

internal class EchipaRepository : Repository<int, Echipa>
{
    private readonly string _connectionString;

    public EchipaRepository(string connectionString)
    {
        _connectionString = connectionString;
    }

    //finds a team by id
    public Echipa FindOne(int id)
    {
        if (id == 0) throw new ArgumentException("ID cannot be null or zero.");
        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();
                var query = "SELECT * FROM echipa WHERE id = @id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Echipa(reader.GetInt32(0), reader.GetString(1));
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

    //finds all teams -> returns a list of teams
    public IEnumerable<Echipa> FindAll()
    {
        var echipe = new List<Echipa>();
        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "SELECT * FROM echipa";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            echipe.Add(new Echipa(reader.GetInt32(0), reader.GetString(1)));
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error in FindAll: {ex.Message}");
        }

        return echipe;
    }
    //saves a team
    public Echipa Save(Echipa entity)
    {
        if (entity == null) throw new ArgumentException("Entity cannot be null.");
        if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");
        if (string.IsNullOrEmpty(entity.echipa_nume)) throw new ValidationException("Name cannot be empty.");

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "INSERT INTO echipa(nume) VALUES (@nume)";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@nume", entity.echipa_nume);

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
    //deletes a team
    public Echipa Delete(int id)
    {
        if (id == 0) throw new ArgumentException("ID cannot be null or zero.");

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                var query = "DELETE FROM echipa WHERE id = @id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Echipa(reader.GetInt32(0), reader.GetString(1));
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
    
    //updates a team
    public Echipa Update(Echipa entity)
    {
        if (entity == null) throw new ArgumentException("Entity cannot be null.");
        if (entity.Id == 0) throw new ValidationException("ID cannot be zero.");
        if (string.IsNullOrEmpty(entity.echipa_nume)) throw new ValidationException("Name cannot be empty.");

        try
        {
            using (var connection = new NpgsqlConnection(_connectionString))
            {
                connection.Open();

                //var query = "UPDATE echipa SET nume = @nume WHERE id = @id RETURNING *";
                var query = "UPDATE echipa SET nume = @nume WHERE id = @id";
                using (var command = new NpgsqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", entity.Id);
                    command.Parameters.AddWithValue("@nume", entity.echipa_nume);

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
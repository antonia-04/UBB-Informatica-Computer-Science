namespace laborator9;

public interface Container
{
    Task Remove();
    void Add(Task task);
    int Size();
    bool IsEmpty();
}
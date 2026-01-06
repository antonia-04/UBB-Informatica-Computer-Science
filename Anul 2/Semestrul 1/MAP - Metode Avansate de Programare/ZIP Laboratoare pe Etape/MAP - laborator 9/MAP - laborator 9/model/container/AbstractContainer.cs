namespace laborator9;

public abstract class AbstractContainer : Container
{
    protected List<Task> tasks = new List<Task>();
    //private Task[] tasks;
    
    public void Add(Task task)
    {
        tasks.Add(task);
    }

    public int Size()
    {
        return tasks.Count;
    }

    public bool IsEmpty()
    {
        return tasks.Count == 0;
    }

    public abstract Task Remove();
}
namespace laborator9;

public class StackContainer : AbstractContainer
{
    public override Task Remove()
    {
        if (tasks.Count == 0)
        {
            throw new InvalidOperationException("Stack container is empty");
        }
        Task task = tasks[tasks.Count - 1];
        tasks.RemoveAt(tasks.Count - 1);
        return task;
    }
}

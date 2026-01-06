namespace laborator9;

public class QueueContainer : AbstractContainer
{
    public override Task Remove()
    {
        if (tasks.Count == 0)
        {
            throw new InvalidOperationException("Queue container is empty");
        }
        Task task = tasks[0];
        tasks.RemoveAt(0);
        return task;
    }
}
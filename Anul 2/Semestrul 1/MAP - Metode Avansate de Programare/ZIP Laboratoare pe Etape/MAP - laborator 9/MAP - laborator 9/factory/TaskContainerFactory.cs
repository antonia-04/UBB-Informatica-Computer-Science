namespace laborator9;

public class TaskContainerFactory : Factory
{
    private static TaskContainerFactory instance = null;
    private static readonly object padlock = new object();

    private TaskContainerFactory() { }

    public static TaskContainerFactory Instance
    {
        get
        {
            lock (padlock)
            {
                if (instance == null)
                {
                    instance = new TaskContainerFactory();
                }

                return instance;
            }
        }
    }

    public Container CreateContainer(Strategy strategy)
    {
        if (strategy == Strategy.FIFO)
            return new QueueContainer();
        if (strategy == Strategy.LIFO)
            return new StackContainer();
        return null;
    }
}    

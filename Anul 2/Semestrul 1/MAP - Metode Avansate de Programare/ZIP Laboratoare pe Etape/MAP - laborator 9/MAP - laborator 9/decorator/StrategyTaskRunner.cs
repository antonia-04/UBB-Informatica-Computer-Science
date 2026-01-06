using laborator9;

namespace MAP___laborator_9.decorator;

public class StrategyTaskRunner : TaskRunner
{
    private readonly Container _container;

    public StrategyTaskRunner(Strategy strategy)
    {
        TaskContainerFactory factory = TaskContainerFactory.Instance;
        _container = factory.CreateContainer(strategy);
    }

    public void ExecuteOneTask()
    {
        if (!_container.IsEmpty())
        {
            laborator9.Task task = _container.Remove();
            task.Execute();
        }
    }

    public void ExecuteAll()
    {
        while (!_container.IsEmpty())
        {
            ExecuteOneTask();
        }
    }

    public void AddTask(laborator9.Task task)
    {
        _container.Add(task);
    }

    public void AddTask(MessageTask task)
    {
        _container.Add(task);
    }

    public bool HasTask()
    {
        return !_container.IsEmpty();
    }
}
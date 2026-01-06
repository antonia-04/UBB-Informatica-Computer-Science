using laborator9;

namespace MAP___laborator_9.decorator;

public abstract class AbstractTaskRunner : TaskRunner
{
    private readonly TaskRunner _taskRunner;

    protected AbstractTaskRunner(TaskRunner taskRunner)
    {
        _taskRunner = taskRunner;
    }

    public virtual void ExecuteOneTask()
    {
        _taskRunner.ExecuteOneTask();
    }

    public virtual void ExecuteAll()
    {
        while (HasTask())
        {
            ExecuteOneTask();
        }
    }

    public void AddTask(MessageTask task)
    {
        _taskRunner.AddTask(task);
    }

    public bool HasTask()
    {
        return _taskRunner.HasTask();
    }
}
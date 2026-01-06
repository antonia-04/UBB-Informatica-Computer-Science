using laborator9;

namespace MAP___laborator_9.decorator;

public interface TaskRunner
{
    void ExecuteOneTask();
    void ExecuteAll();
    void AddTask(MessageTask task);
    bool HasTask();
}
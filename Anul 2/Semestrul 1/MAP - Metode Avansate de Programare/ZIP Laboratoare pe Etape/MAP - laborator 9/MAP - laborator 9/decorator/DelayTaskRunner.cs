namespace MAP___laborator_9.decorator;

public class DelayTaskRunner : AbstractTaskRunner
{
    public DelayTaskRunner(TaskRunner taskRunner) : base(taskRunner) { }

    public override void ExecuteOneTask()
    {
        base.ExecuteOneTask();
        Thread.Sleep(3000);
    }
}
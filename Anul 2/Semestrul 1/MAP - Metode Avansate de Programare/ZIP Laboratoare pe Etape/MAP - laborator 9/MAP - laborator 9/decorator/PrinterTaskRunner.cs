namespace MAP___laborator_9.decorator;

public class PrinterTaskRunner : AbstractTaskRunner
{
    public PrinterTaskRunner(TaskRunner taskRunner) : base(taskRunner) { }

    public override void ExecuteOneTask()
    {
        base.ExecuteOneTask();
        Console.WriteLine($"Task executed at: {DateTime.Now}");
    }
}
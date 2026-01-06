using laborator9;
using MAP___laborator_9.decorator;
using System;

class Program
{
    public static MessageTask[] CreateMessages()
    {
        MessageTask msg1 = new MessageTask(
            from: "teacher",
            message: "Te-ai descurcat bine",
            date: DateTime.Now,
            taskID: "1",
            description: "feedback lab 2"
        );
        MessageTask msg2 = new MessageTask(
            from: "teacher",
            message: "Te-ai descurcat bine",
            date: DateTime.Now,
            taskID: "2",
            description: "feedback lab 2"
        );
        MessageTask msg3 = new MessageTask(
            from: "teacher",
            message: "Te-ai descurcat bine",
            date: DateTime.Now,
            taskID: "3",
            description: "feedback lab 2"
        );
        MessageTask msg4 = new MessageTask(
            from: "teacher",
            message: "Te-ai descurcat bine",
            date: DateTime.Now,
            taskID: "4",
            description: "feedback lab 2"
        );
        MessageTask msg5 = new MessageTask(
            from: "teacher",
            message: "Te-ai descurcat bine",
            date: DateTime.Now,
            taskID: "5",
            description: "feedback lab 2"
        );

        return new MessageTask[] { msg1, msg2, msg3, msg4, msg5 };
    }

    public static void TestSortingTask(SortStrategy sortStrategy, List<int> numbers)
    {
        SortingTask sortingTask = new SortingTask(numbers, sortStrategy, "1", "Test Sorting Task");
        sortingTask.Execute();
    }
    
    static void Main(string[] args)
    {
        if (args.Length == 0)
        {
            Console.WriteLine("Please provide a strategy as a command line argument.");
            return;
        }
        
        List<int> numbers = new List<int> { 5, 3, 8, 4, 2 };

        Console.WriteLine("Testing BubbleSort:");
        TestSortingTask(SortStrategy.BubbleSort, new List<int>(numbers));

        Console.WriteLine("Testing QuickSort:");
        TestSortingTask(SortStrategy.QuickSort, new List<int>(numbers));
        
        Console.WriteLine("\n");

        MessageTask[] messageTasks = CreateMessages();
        foreach (MessageTask messageTask in messageTasks)
        {
            Console.WriteLine(messageTask);
        }
        // 13
        // messageTasks -> StrategyTaskRunner -> PrinterTaskRunner
        // Create StrategyTaskRunner with the specified strategy
        Strategy strategy = (Strategy)Enum.Parse(typeof(Strategy), args[0]);
        StrategyTaskRunner strategyTaskRunner = new StrategyTaskRunner(strategy);
        PrinterTaskRunner printerTaskRunner = new PrinterTaskRunner(strategyTaskRunner);

        // Add MessageTask objects to PrinterTaskRunner
        foreach (MessageTask messageTask in messageTasks)
        {
            printerTaskRunner.AddTask(messageTask);
        }
        Console.WriteLine("\n");
        Console.WriteLine("messageTasks -> StrategyTaskRunner -> PrinterTaskRunner");
        // Execute all tasks
        printerTaskRunner.ExecuteAll();

        // 14
        // messageTasks -> StrategyTaskRunner -> DelayTaskRunner -> PrinterTaskRunner
        DelayTaskRunner delayTaskRunner = new DelayTaskRunner(printerTaskRunner);

        // Add MessageTask objects to DelayTaskRunner
        foreach (MessageTask messageTask in messageTasks)
        {
            delayTaskRunner.AddTask(messageTask);
        }
        Console.WriteLine("\n");
        Console.WriteLine("messageTasks -> StrategyTaskRunner -> DelayTaskRunner -> PrinterTaskRunner");
        // Execute all tasks
        delayTaskRunner.ExecuteAll();
    }
}
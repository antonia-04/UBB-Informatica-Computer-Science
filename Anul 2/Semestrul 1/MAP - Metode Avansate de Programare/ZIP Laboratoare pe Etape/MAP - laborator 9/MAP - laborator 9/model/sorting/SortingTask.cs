namespace laborator9;

public class SortingTask : Task
{
    private List<int> vector;
    private AbstractSorter sorter;

    public SortingTask(List<int> vector, SortStrategy sortStrategy, string taskID, string description)
        : base(taskID, description)
    {
        this.vector = vector;

        switch (sortStrategy)
        {
            case SortStrategy.BubbleSort:
                sorter = new BubbleSort();
                break;
            case SortStrategy.QuickSort:
                sorter = new QuickSort();
                break;
            default:
                throw new ArgumentException("Invalid sort strategy");
        }
    }

    public override void Execute()
    {
        sorter.Sort(vector);
        Console.WriteLine($"TaskID: {TaskID}, Description: {Description}, Sorted Vector: {string.Join(", ", vector)}");
    }
}
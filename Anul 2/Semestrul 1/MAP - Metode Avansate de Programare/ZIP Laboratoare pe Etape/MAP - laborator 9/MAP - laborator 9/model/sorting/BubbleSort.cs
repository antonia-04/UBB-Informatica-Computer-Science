namespace laborator9;

public class BubbleSort : AbstractSorter
{
    public override void Sort(List<int> vector)
    {
        int n = vector.Count;
        for (int i = 0; i < n - 1; i++)
        {
            for (int j = 0; j < n - 1 - i; j++)
            {
                if (vector[j] > vector[j + 1])
                {
                    int temp = vector[j];
                    vector[j] = vector[j + 1];
                    vector[j + 1] = temp;
                }
            }
        }
    }
}
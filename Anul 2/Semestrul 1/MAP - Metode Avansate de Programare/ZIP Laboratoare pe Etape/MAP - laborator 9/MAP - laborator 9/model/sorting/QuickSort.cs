namespace laborator9;

public class QuickSort : AbstractSorter
{
    public override void Sort(List<int> vector)
    {
        QuickSortHelper(vector, 0, vector.Count - 1);
    }

    private void QuickSortHelper(List<int> vector, int low, int high)
    {
        if (low < high)
        {
            int pi = Partition(vector, low, high);
            QuickSortHelper(vector, low, pi - 1);
            QuickSortHelper(vector, pi + 1, high);
        }
    }

    private int Partition(List<int> vector, int low, int high)
    {
        int pivot = vector[high];
        int i = (low - 1);
        for (int j = low; j < high; j++)
        {
            if (vector[j] < pivot)
            {
                i++;
                int temp = vector[i];
                vector[i] = vector[j];
                vector[j] = temp;
            }
        }
        int temp1 = vector[i + 1];
        vector[i + 1] = vector[high];
        vector[high] = temp1;
        return i + 1;
    }
}
using LeetCodeUtils;

class Program
{
    static void Main()
    {
        Console.WriteLine("=== Linked List Demo ===");
        var list = ListNodeUtils.Create(new int[] { 1, 2, 3, 4 });
        Console.WriteLine(list.Print());

        Console.WriteLine("\n=== Tree Demo ===");
        var tree = TreeNodeUtils.Create(new int[] { 1, 2, 3, 4, 5 });
        Console.WriteLine(tree.Print());
    }
}

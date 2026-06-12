namespace LeetCodeUtils;

public static class PrettyPrint
{
    public static void Array<T>(IEnumerable<T> items, string label = "Array")
        => ArrayUtils.Print(items, label);

    public static void Matrix(int[][] matrix, string label = "Matrix")
        => MatrixUtils.Print(matrix, label);

    public static void List(ListNode? head, string label = "List")
        => ListNodeUtils.Print(head, label);

    public static void Tree(TreeNode? root, string label = "Tree")
        => TreeNodeUtils.Print(root, label);
}

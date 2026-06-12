namespace LeetCodeUtils;

public static class TreeNodeUtils
{
    // Level-order create from int?[]
    public static TreeNode? FromArray(int?[] values)
    {
        if (values is null || values.Length == 0 || values[0] is null)
            return null;

        var root = new TreeNode(values[0]!.Value);
        var queue = new Queue<TreeNode>();
        queue.Enqueue(root);

        int i = 1;
        while (i < values.Length && queue.Count > 0)
        {
            var node = queue.Dequeue();

            if (i < values.Length && values[i] is not null)
            {
                node.left = new TreeNode(values[i]!.Value);
                queue.Enqueue(node.left);
            }
            i++;

            if (i < values.Length && values[i] is not null)
            {
                node.right = new TreeNode(values[i]!.Value);
                queue.Enqueue(node.right);
            }
            i++;
        }

        return root;
    }

    public static int?[] ToArray(TreeNode? root)
    {
        if (root is null) return Array.Empty<int?>();

        var result = new List<int?>();
        var queue = new Queue<TreeNode?>();
        queue.Enqueue(root);

        while (queue.Count > 0)
        {
            var node = queue.Dequeue();
            if (node is null)
            {
                result.Add(null);
                continue;
            }

            result.Add(node.val);
            queue.Enqueue(node.left);
            queue.Enqueue(node.right);
        }

        // trim trailing nulls
        int last = result.Count - 1;
        while (last >= 0 && result[last] is null) last--;
        if (last < 0) return Array.Empty<int?>();

        return result.Take(last + 1).ToArray();
    }

    public static string ToLevelOrderString(TreeNode? root)
    {
        var arr = ToArray(root);
        return "[" + string.Join(",", arr.Select(v => v?.ToString() ?? "null")) + "]";
    }

    public static TreeNode? Create(int?[] values)
    => FromArray(values);

    public static void Print(TreeNode? root, string label = "Tree")
        => Console.WriteLine($"{label}: {ToLevelOrderString(root)}");
}

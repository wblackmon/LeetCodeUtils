using System.Text;
using System.Collections.Generic;

namespace LeetCodeUtils;

public static class TreeNodeUtils
{
    public static TreeNode Create(int[] values)
    {
        if (values == null || values.Length == 0) return null!;
        var root = new TreeNode(values[0]);
        var queue = new Queue<TreeNode>();
        queue.Enqueue(root);

        int i = 1;
        while (i < values.Length)
        {
            var node = queue.Dequeue();

            if (i < values.Length)
            {
                node.left = new TreeNode(values[i]);
                queue.Enqueue(node.left);
            }
            i++;

            if (i < values.Length)
            {
                node.right = new TreeNode(values[i]);
                queue.Enqueue(node.right);
            }
            i++;
        }

        return root;
    }

    public static string Print(this TreeNode root)
    {
        if (root == null) return "[]";
        var sb = new StringBuilder();
        var queue = new Queue<TreeNode>();
        queue.Enqueue(root);

        sb.Append("[");
        while (queue.Count > 0)
        {
            var node = queue.Dequeue();
            sb.Append(node.val).Append(", ");
            if (node.left != null) queue.Enqueue(node.left);
            if (node.right != null) queue.Enqueue(node.right);
        }
        if (sb.Length > 2) sb.Length -= 2;
        sb.Append("]");
        return sb.ToString();
    }
}

using System.Text;
using System.Collections.Generic;

namespace LeetCodeUtils;

public static class TreeNodeUtils
{
    public static TreeNode? Create(int?[] arr)
    {
        if (arr == null || arr.Length == 0) return null;

        if (!arr[0].HasValue) return null;
        TreeNode root = new TreeNode(arr[0]!.Value);
        Queue<TreeNode> queue = new Queue<TreeNode>();
        queue.Enqueue(root);

        int i = 1;
        while (queue.Count > 0 && i < arr.Length)
        {
            TreeNode current = queue.Dequeue();

            // Left child
            if (i < arr.Length && arr[i].HasValue)
            {
                current.left = new TreeNode(arr[i]!.Value);
                queue.Enqueue(current.left);
            }
            i++;

            // Right child
            if (i < arr.Length && arr[i].HasValue)
            {
                current.right = new TreeNode(arr[i]!.Value);
                queue.Enqueue(current.right);
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
    public static void Print(object[] arr)
    {
        if (arr == null || arr.Length == 0)
        {
            Console.WriteLine("[]");
            return;
        }

        int level = 0;
        int count = 1; // nodes per level
        int index = 0;

        while (index < arr.Length)
        {
            Console.Write($"Level {level}: ");

            for (int i = 0; i < count && index < arr.Length; i++, index++)
            {
                string? val = arr[index] == null ? "null" : arr[index].ToString();
                Console.Write(val);

                // Print arrows between siblings
                if (i < count - 1) Console.Write(" -> ");
            }

            Console.WriteLine();
            level++;
            count *= 2; // next level has twice as many possible nodes
        }
    }

}



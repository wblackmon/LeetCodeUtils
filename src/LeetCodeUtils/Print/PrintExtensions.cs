namespace LeetCodeUtils;

public static class PrintExtensions
{
    public static string Print(this ListNode? head)
    {
        var s = ListNodeUtils.ToArrowString(head);
        Console.WriteLine(s);
        return s;
    }

    public static string Print(this TreeNode? root)
    {
        var s = TreeNodeUtils.ToLevelOrderString(root);
        Console.WriteLine(s);
        return s;
    }
}

namespace LeetCodeUtils;

public static class ListNodeUtils
{
    public static ListNode? FromArray(int[] values)
    {
        if (values is null || values.Length == 0) return null;

        var dummy = new ListNode();
        var current = dummy;
        foreach (var v in values)
        {
            current.next = new ListNode(v);
            current = current.next;
        }
        return dummy.next;
    }

    public static int[] ToArray(ListNode? head)
    {
        var list = new List<int>();
        while (head != null)
        {
            list.Add(head.val);
            head = head.next;
        }
        return list.ToArray();
    }

    public static string ToArrowString(ListNode? head)
    {
        if (head is null) return "∅";

        var parts = new List<string>();
        while (head != null)
        {
            parts.Add(head.val.ToString());
            head = head.next;
        }
        return string.Join(" -> ", parts);
    }

    public static ListNode? Create(int[] values)
    => FromArray(values);

    public static void Print(ListNode? head, string label = "List")
        => Console.WriteLine($"{label}: {ToArrowString(head)}");
}

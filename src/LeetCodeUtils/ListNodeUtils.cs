using System.Text;

namespace LeetCodeUtils;

public static class ListNodeUtils
{
    public static ListNode Create(int[] values)
    {
        if (values == null || values.Length == 0) return null!;
        var head = new ListNode(values[0]);
        var current = head;
        for (int i = 1; i < values.Length; i++)
        {
            current.next = new ListNode(values[i]);
            current = current.next;
        }
        return head;
    }

    public static string Print(this ListNode head)
    {
        if (head == null) return "[]";
        var sb = new StringBuilder();
        var current = head;
        while (current != null)
        {
            sb.Append(current.val);
            if (current.next != null) sb.Append(" -> ");
            current = current.next;
        }
        return sb.ToString();
    }
}

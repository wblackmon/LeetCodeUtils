namespace LeetCodeUtils;

public static class ArrayUtils
{
    public static string ToString<T>(IEnumerable<T> items)
        => "[" + string.Join(",", items) + "]";

    public static void Print<T>(IEnumerable<T> items, string label = "Array")
        => Console.WriteLine($"{label}: {ToString(items)}");

    public static int[] ParseIntArray(string input)
    {
        // "[1,2,3]" or "1,2,3"
        var trimmed = input.Trim();
        if (trimmed.StartsWith("[")) trimmed = trimmed[1..];
        if (trimmed.EndsWith("]")) trimmed = trimmed[..^1];
        if (string.IsNullOrWhiteSpace(trimmed)) return Array.Empty<int>();

        return trimmed
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .Select(int.Parse)
            .ToArray();
    }

    public static int?[] ParseNullableIntArray(string input)
    {
        var trimmed = input.Trim();
        if (trimmed.StartsWith("[")) trimmed = trimmed[1..];
        if (trimmed.EndsWith("]")) trimmed = trimmed[..^1];
        if (string.IsNullOrWhiteSpace(trimmed)) return Array.Empty<int?>();

        return trimmed
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .Select(s => s.Equals("null", StringComparison.OrdinalIgnoreCase) ? (int?)null : int.Parse(s))
            .ToArray();
    }
}

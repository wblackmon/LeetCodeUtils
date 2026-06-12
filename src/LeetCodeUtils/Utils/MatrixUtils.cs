namespace LeetCodeUtils;

public static class MatrixUtils
{
    public static int[][] ParseIntMatrix(string input)
    {
        // "[[1,2],[3,4]]"
        var trimmed = input.Trim();
        if (trimmed.StartsWith("[")) trimmed = trimmed[1..];
        if (trimmed.EndsWith("]")) trimmed = trimmed[..^1];
        if (string.IsNullOrWhiteSpace(trimmed)) return Array.Empty<int[]>();

        var rows = new List<int[]>();
        var current = new List<int>();
        var token = new List<char>();
        bool inRow = false;

        foreach (var c in trimmed)
        {
            if (c == '[')
            {
                inRow = true;
                token.Clear();
                current.Clear();
            }
            else if (c == ']')
            {
                if (token.Count > 0)
                {
                    current.Add(int.Parse(new string(token.ToArray())));
                    token.Clear();
                }
                rows.Add(current.ToArray());
                inRow = false;
            }
            else if (c == ',' && inRow)
            {
                if (token.Count > 0)
                {
                    current.Add(int.Parse(new string(token.ToArray())));
                    token.Clear();
                }
            }
            else if (inRow && !char.IsWhiteSpace(c))
            {
                token.Add(c);
            }
        }

        return rows.ToArray();
    }

    public static string ToString(int[][] matrix)
    {
        var rows = matrix.Select(r => "[" + string.Join(",", r) + "]");
        return "[" + string.Join(",", rows) + "]";
    }

    public static void Print(int[][] matrix, string label = "Matrix")
        => Console.WriteLine($"{label}: {ToString(matrix)}");
}

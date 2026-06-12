namespace LeetCodeUtils;

public static class StringUtils
{
    public static string Reverse(string s)
    {
        if (string.IsNullOrEmpty(s)) return s;
        var chars = s.ToCharArray();
        Array.Reverse(chars);
        return new string(chars);
    }

    public static bool IsPalindrome(string s)
    {
        if (s is null) return false;
        int i = 0, j = s.Length - 1;
        while (i < j)
        {
            if (s[i] != s[j]) return false;
            i++; j--;
        }
        return true;
    }

    public static string NormalizeWhitespace(string s)
    {
        if (string.IsNullOrWhiteSpace(s)) return string.Empty;
        return string.Join(" ", s.Split(' ', StringSplitOptions.RemoveEmptyEntries));
    }
}

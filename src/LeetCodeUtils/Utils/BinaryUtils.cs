namespace LeetCodeUtils;

public static class BinaryUtils
{
    public static string Normalize(string s)
    {
        if (string.IsNullOrWhiteSpace(s))
            return "0";

        var trimmed = s.TrimStart('0');
        return trimmed.Length == 0 ? "0" : trimmed;
    }

    public static string Pad(string s, int length)
        => s.PadLeft(length, '0');

    public static int ToDigit(char c)
        => c - '0';

    public static char ToChar(int digit)
        => (char)('0' + digit);

    public static string AddBinaryStrings(string a, string b)
    {
        a = Normalize(a);
        b = Normalize(b);

        int max = Math.Max(a.Length, b.Length);
        a = Pad(a, max);
        b = Pad(b, max);

        int carry = 0;
        var result = new char[max + 1];
        int idx = max;

        for (int i = max - 1; i >= 0; i--)
        {
            int sum = ToDigit(a[i]) + ToDigit(b[i]) + carry;
            result[idx--] = ToChar(sum % 2);
            carry = sum / 2;
        }

        result[idx] = ToChar(carry);

        var output = new string(result);
        return Normalize(output);
    }

    public static void Print(string label, string value)
        => Console.WriteLine($"{label}: \"{value}\"");
}

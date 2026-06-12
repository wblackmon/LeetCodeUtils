namespace LeetCodeUtils;

public static class ParsingUtils
{
    public static int[] IntArray(string input) => ArrayUtils.ParseIntArray(input);

    public static int?[] NullableIntArray(string input) => ArrayUtils.ParseNullableIntArray(input);

    public static int[][] IntMatrix(string input) => MatrixUtils.ParseIntMatrix(input);

    public static ListNode? ListNodeFromArrayString(string input)
        => ListNodeUtils.FromArray(ArrayUtils.ParseIntArray(input));

    public static TreeNode? TreeNodeFromArrayString(string input)
        => TreeNodeUtils.FromArray(ArrayUtils.ParseNullableIntArray(input));
}

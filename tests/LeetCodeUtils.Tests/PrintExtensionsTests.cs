using Xunit;
using LeetCodeUtils;

namespace LeetCodeUtils.Tests;

public class PrintExtensionsTests
{
    [Fact]
    public void ListNode_Print_ShouldReturnString()
    {
        var head = ListNodeUtils.FromArray(new[] { 1, 2, 3 });
        var printed = head.Print();

        Assert.Equal("1 -> 2 -> 3", printed);
    }

    [Fact]
    public void TreeNode_Print_ShouldReturnString()
    {
        var root = TreeNodeUtils.FromArray(new int?[] { 1, 2, 3 });
        var printed = root.Print();

        Assert.Equal("[1,2,3]", printed);
    }
}

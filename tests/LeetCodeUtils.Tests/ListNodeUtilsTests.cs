using Xunit;
using LeetCodeUtils;

namespace LeetCodeUtils.Tests;

public class ListNodeUtilsTests
{
    [Fact]
    public void FromArray_ShouldBuildLinkedList()
    {
        var head = ListNodeUtils.FromArray(new[] { 1, 2, 3 });
        var result = ListNodeUtils.ToArray(head);

        Assert.Equal(new[] { 1, 2, 3 }, result);
    }

    [Fact]
    public void ToArrowString_ShouldFormatCorrectly()
    {
        var head = ListNodeUtils.FromArray(new[] { 1, 2, 3 });
        var s = ListNodeUtils.ToArrowString(head);

        Assert.Equal("1 -> 2 -> 3", s);
    }

    [Fact]
    public void PrintExtension_ShouldReturnString()
    {
        var head = ListNodeUtils.FromArray(new[] { 1, 2, 3 });
        var printed = head.Print();

        Assert.Equal("1 -> 2 -> 3", printed);
    }
}

using Xunit;
using LeetCodeUtils;

namespace LeetCodeUtils.Tests;

public class TreeNodeUtilsTests
{
    [Fact]
    public void FromArray_ShouldBuildTree()
    {
        var root = TreeNodeUtils.FromArray(new int?[] { 1, 2, 3, null, 4 });
        var result = TreeNodeUtils.ToArray(root);

        Assert.Equal(new int?[] { 1, 2, 3, null, 4 }, result);
    }

    [Fact]
    public void ToLevelOrderString_ShouldFormatCorrectly()
    {
        var root = TreeNodeUtils.FromArray(new int?[] { 1, 2, 3, null, 4 });
        var s = TreeNodeUtils.ToLevelOrderString(root);

        Assert.Equal("[1,2,3,null,4]", s);
    }

    [Fact]
    public void PrintExtension_ShouldReturnString()
    {
        var root = TreeNodeUtils.FromArray(new int?[] { 1, 2, 3 });
        var printed = root.Print();

        Assert.Equal("[1,2,3]", printed);
    }
}

using Xunit;
using LeetCodeUtils;

public class TreeNodeUtilsTests
{
    [Fact]
    public void Print_ShouldReturnCorrectString()
    {
        var root = TreeNodeUtils.Create(new int[] { 1, 2, 3 });
        Assert.Equal("[1, 2, 3]", root.Print());
    }
}

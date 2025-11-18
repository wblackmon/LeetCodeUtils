using Xunit;
using LeetCodeUtils;

public class ListNodeUtilsTests
{
    [Fact]
    public void Print_ShouldReturnCorrectString()
    {
        var head = ListNodeUtils.Create(new int[] { 1, 2, 3 });
        Assert.Equal("1 -> 2 -> 3", head.Print());
    }
}

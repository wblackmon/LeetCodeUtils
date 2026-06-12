using Xunit;
using LeetCodeUtils;

namespace LeetCodeUtils.Tests;

public class BinaryUtilsTests
{
    [Theory]
    [InlineData("0", "0", "0")]
    [InlineData("1", "1", "10")]
    [InlineData("1010", "1011", "10101")]
    public void AddBinaryStrings_ShouldAddCorrectly(string a, string b, string expected)
    {
        var result = BinaryUtils.AddBinaryStrings(a, b);
        Assert.Equal(expected, result);
    }

    [Fact]
    public void Normalize_ShouldRemoveLeadingZeros()
    {
        var result = BinaryUtils.Normalize("000101");
        Assert.Equal("101", result);
    }
}

param(
    [string]$SolutionName = "LeetCodeUtils",
    [string]$Framework = "net8.0"
)

Write-Host "=== Initializing $SolutionName Solution ==="

# Step 1: Create solution
dotnet new sln -n $SolutionName

# Step 2: Create class library project
dotnet new classlib -n $SolutionName -o "src/$SolutionName" --framework $Framework

# Step 3: Create console project
dotnet new console -n "$SolutionName.Console" -o "src/$SolutionName.Console" --framework $Framework

# Step 4: Create test project
dotnet new xunit -n "$SolutionName.Tests" -o "tests/$SolutionName.Tests" --framework $Framework

# Step 5: Add projects to solution
dotnet sln "$SolutionName.sln" add "src/$SolutionName/$SolutionName.csproj"
dotnet sln "$SolutionName.sln" add "src/$SolutionName.Console/$SolutionName.Console.csproj"
dotnet sln "$SolutionName.sln" add "tests/$SolutionName.Tests/$SolutionName.Tests.csproj"

# Step 6: Add references
dotnet add "src/$SolutionName.Console/$SolutionName.Console.csproj" reference "src/$SolutionName/$SolutionName.csproj"
dotnet add "tests/$SolutionName.Tests/$SolutionName.Tests.csproj" reference "src/$SolutionName/$SolutionName.csproj"

Write-Host "=== Cleaning up default files ==="

# Remove default Class1.cs from class library
Remove-Item "src/$SolutionName/Class1.cs" -ErrorAction SilentlyContinue

# Remove default Program.cs from console project
Remove-Item "src/$SolutionName.Console/Program.cs" -ErrorAction SilentlyContinue

# Remove default UnitTest1.cs from test project
Remove-Item "tests/$SolutionName.Tests/UnitTest1.cs" -ErrorAction SilentlyContinue

Write-Host "=== Creating custom files ==="

# Create ListNode.cs
@"
namespace $SolutionName;

public class ListNode
{
    public int val;
    public ListNode? next;
    public ListNode(int val = 0, ListNode? next = null)
    {
        this.val = val;
        this.next = next;
    }
}
"@ | Set-Content "src/$SolutionName/ListNode.cs"

# Create TreeNode.cs
@"
namespace $SolutionName;

public class TreeNode
{
    public int val;
    public TreeNode? left;
    public TreeNode? right;
    public TreeNode(int val = 0, TreeNode? left = null, TreeNode? right = null)
    {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}
"@ | Set-Content "src/$SolutionName/TreeNode.cs"

# Create ListNodeUtils.cs
@"
using System.Text;

namespace $SolutionName;

public static class ListNodeUtils
{
    public static ListNode Create(int[] values)
    {
        if (values == null || values.Length == 0) return null!;
        var head = new ListNode(values[0]);
        var current = head;
        for (int i = 1; i < values.Length; i++)
        {
            current.next = new ListNode(values[i]);
            current = current.next;
        }
        return head;
    }

    public static string Print(this ListNode head)
    {
        if (head == null) return "[]";
        var sb = new StringBuilder();
        var current = head;
        while (current != null)
        {
            sb.Append(current.val);
            if (current.next != null) sb.Append(" -> ");
            current = current.next;
        }
        return sb.ToString();
    }
}
"@ | Set-Content "src/$SolutionName/ListNodeUtils.cs"

# Create TreeNodeUtils.cs
@"
using System.Text;
using System.Collections.Generic;

namespace $SolutionName;

public static class TreeNodeUtils
{
    public static TreeNode Create(int[] values)
    {
        if (values == null || values.Length == 0) return null!;
        var root = new TreeNode(values[0]);
        var queue = new Queue<TreeNode>();
        queue.Enqueue(root);

        int i = 1;
        while (i < values.Length)
        {
            var node = queue.Dequeue();

            if (i < values.Length)
            {
                node.left = new TreeNode(values[i]);
                queue.Enqueue(node.left);
            }
            i++;

            if (i < values.Length)
            {
                node.right = new TreeNode(values[i]);
                queue.Enqueue(node.right);
            }
            i++;
        }

        return root;
    }

    public static string Print(this TreeNode root)
    {
        if (root == null) return "[]";
        var sb = new StringBuilder();
        var queue = new Queue<TreeNode>();
        queue.Enqueue(root);

        sb.Append("[");
        while (queue.Count > 0)
        {
            var node = queue.Dequeue();
            sb.Append(node.val).Append(", ");
            if (node.left != null) queue.Enqueue(node.left);
            if (node.right != null) queue.Enqueue(node.right);
        }
        if (sb.Length > 2) sb.Length -= 2;
        sb.Append("]");
        return sb.ToString();
    }
}
"@ | Set-Content "src/$SolutionName/TreeNodeUtils.cs"

# Create Program.cs in console project
@"
using $SolutionName;

class Program
{
    static void Main()
    {
        Console.WriteLine("=== Linked List Demo ===");
        var list = ListNodeUtils.Create(new int[] { 1, 2, 3, 4 });
        Console.WriteLine(list.Print());

        Console.WriteLine("\n=== Tree Demo ===");
        var tree = TreeNodeUtils.Create(new int[] { 1, 2, 3, 4, 5 });
        Console.WriteLine(tree.Print());
    }
}
"@ | Set-Content "src/$SolutionName.Console/Program.cs"

# Create ListNodeUtilsTests.cs
@"
using Xunit;
using $SolutionName;

public class ListNodeUtilsTests
{
    [Fact]
    public void Print_ShouldReturnCorrectString()
    {
        var head = ListNodeUtils.Create(new int[] { 1, 2, 3 });
        Assert.Equal("1 -> 2 -> 3", head.Print());
    }
}
"@ | Set-Content "tests/$SolutionName.Tests/ListNodeUtilsTests.cs"

# Create TreeNodeUtilsTests.cs
@"
using Xunit;
using $SolutionName;

public class TreeNodeUtilsTests
{
    [Fact]
    public void Print_ShouldReturnCorrectString()
    {
        var root = TreeNodeUtils.Create(new int[] { 1, 2, 3 });
        Assert.Equal("[1, 2, 3]", root.Print());
    }
}
"@ | Set-Content "tests/$SolutionName.Tests/TreeNodeUtilsTests.cs"

Write-Host "=== All files scaffolded successfully ==="

# LeetCodeUtils

LeetCodeUtils is a lightweight **.NET 8** utility library providing canonical data structures and helper methods commonly used in LeetCode problems.  
It includes:

- **ListNode** (singly linked list)
- **TreeNode** (binary tree)
- **ListNodeUtils** (creation, conversion, printing)
- **TreeNodeUtils** (creation, conversion, pretty‑printing)

Designed for **interview prep**, **algorithm practice**, and **cleaner LeetCode solutions**.

---

## 📦 Install via NuGet

```
dotnet add package LeetCodeUtils
```

NuGet: https://www.nuget.org/packages/LeetCodeUtils

---

## 📂 Solution Structure

```
LeetCodeUtils.sln
│
├── src/
│   ├── LeetCodeUtils/              # Class Library (NuGet package)
│   │   ├── ListNode.cs
│   │   ├── TreeNode.cs
│   │   ├── ListNodeUtils.cs
│   │   └── TreeNodeUtils.cs
│   │
│   └── LeetCodeUtils.Console/      # Console demo
│       └── Program.cs
│
└── tests/
    └── LeetCodeUtils.Tests/        # xUnit test suite
        ├── ListNodeUtilsTests.cs
        └── TreeNodeUtilsTests.cs
```

---

## 🚀 Getting Started

### Build the solution
```bash
git clone https://github.com/wblackmon/LeetCodeUtils.git
cd LeetCodeUtils
dotnet build
```

### Run the console demo
```bash
dotnet run --project src/LeetCodeUtils.Console
```

### Run tests
```bash
dotnet test
```

---

## 🔗 Usage Examples

### Linked List Example

```csharp
using LeetCodeUtils;

// Create a linked list from an array
var head = ListNodeUtils.FromArray(new[] { 1, 2, 3, 4 });

// Convert back to array
int[] values = ListNodeUtils.ToArray(head);

// Pretty-print the list
Console.WriteLine(ListNodeUtils.ToString(head));
// Output: 1 -> 2 -> 3 -> 4
```

### Binary Tree Example

```csharp
using LeetCodeUtils;

// Create a binary tree from level-order input
var root = TreeNodeUtils.FromLevelOrder(new int?[] { 1, 2, 3, null, 5 });

// Pretty-print the tree
Console.WriteLine(TreeNodeUtils.ToPrettyString(root));
```

---

## 🧱 Included Data Structures

### ListNode
```csharp
public class ListNode {
    public int val;
    public ListNode next;
}
```

### TreeNode
```csharp
public class TreeNode {
    public int val;
    public TreeNode left;
    public TreeNode right;
}
```

---

## 🔧 Utility Methods

### ListNodeUtils
- `FromArray(int[])`
- `ToArray(ListNode)`
- `ToString(ListNode)`
- `Append(ListNode, int)`
- `Reverse(ListNode)`

### TreeNodeUtils
- `FromLevelOrder(int?[])`
- `ToLevelOrder(TreeNode)`
- `ToPrettyString(TreeNode)`
- `Height(TreeNode)`
- `IsBalanced(TreeNode)`

---

## 🧪 Testing

Example xUnit test:

```csharp
[Fact]
public void ToString_ShouldReturnCorrectFormat()
{
    var head = ListNodeUtils.FromArray(new[] { 1, 2, 3 });
    Assert.Equal("1 -> 2 -> 3", ListNodeUtils.ToString(head));
}
```

Run tests:

```bash
dotnet test
```

---

## 📦 NuGet Packaging

Build and pack:

```bash
dotnet pack src/LeetCodeUtils/LeetCodeUtils.csproj -c Release -o ./artifacts
```

Publish via GitHub Actions using a NuGet.org API key secret:

```bash
dotnet nuget push ./artifacts/*.nupkg \
  --source https://api.nuget.org/v3/index.json \
  --api-key "$NUGET_API_KEY" \
  --skip-duplicate
```

---

## 🏗️ Roadmap

- PrettyPrint ASCII renderer for binary trees  
- Random linked list & tree generators  
- Additional conversion helpers  
- Expanded test coverage  

---

## 📜 License

MIT License © Wayne Eliot Blackmon

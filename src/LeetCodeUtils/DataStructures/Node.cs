namespace LeetCodeUtils;

public class Node
{
    public int val;
    public IList<Node> children;

    public Node(int val)
    {
        this.val = val;
        children = new List<Node>();
    }

    public override string ToString() => val.ToString();
}

namespace LeetCodeUtils;

public class GraphNode
{
    public int val;
    public IList<GraphNode> neighbors;

    public GraphNode(int val)
    {
        this.val = val;
        neighbors = new List<GraphNode>();
    }

    public override string ToString() => val.ToString();
}

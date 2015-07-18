class Graph

  # We are dealing with an undirected graph,
  # so I increment the "adjacents" in both sides.
  # The breath first will work the same way with
  # a directed graph.
  def add_edge(opinion_a, opinion_b)
    opinion_a.adjacents << opinion_b
    opinion_b.adjacents << opinion_a
  end
end

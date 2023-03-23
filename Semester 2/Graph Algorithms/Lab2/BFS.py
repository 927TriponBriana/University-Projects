import random, time


class Graph:
    def __init__(self, vertices):
        self.__out_vertices = dict()
        self.__in_vertices = dict()
        for vertex in vertices:
            self.__out_vertices[vertex] = list()
            self.__in_vertices[vertex] = list()

    def add_edge(self, x, y):
        self.__out_vertices[x].append(y)
        self.__in_vertices[y].append(x)

    def is_edge(self, x, y):
        return y in self.__out_vertices[x]

    def parse_nout(self, x):
        for y in self.__out_vertices[x]:
            yield y

    def parse_nin(self, x):
        for y in self.__in_vertices[x]:
            yield y

    def parse_nin1(self, x):
        for y in self.__out_vertices:
            if self.is_edge(y, x):
                yield y

    def parse_vertices(self):
        return [x for x in self.__out_vertices]


def print_graph(g):
    print("Outbound:")
    for x in g.parse_vertices():
        print("%s: %s" % (x, [y for y in g.parse_nout(x)]))
    print("Inbound:")
    for x in g.parse_vertices():
        print("%s: %s" % (x, [y for y in g.parse_nin(x)]))


def parse_graph(g):
    start_time = time.time()
    for x in g.parse_vertices():
        for y in g.parse_nout(x):
            pass
    print("Out: %sms" % (1000 * (time.time() - start_time)))
    start_time = time.time()
    for x in g.parse_vertices():
        for y in g.parse_nin(x):
            pass
    print("In: %sms" % (1000 * (time.time() - start_time)))


def build_graph():
    g = Graph([0, 1, 2, 3, 4])
    # (0,1), (0,2), (1,2), (2,1)
    g.add_edge(0, 1)
    g.add_edge(0, 2)
    g.add_edge(1, 2)
    g.add_edge(2, 1)
    g.add_edge(1, 4)
    return g


def build_random_graph(n, m):
    g = Graph(range(n))
    while (m > 0):
        v1 = random.randrange(n)
        v2 = random.randrange(n)
        if not g.is_edge(v1, v2):
            g.add_edge(v1, v2)
            m = m - 1
    return g


def test_graph():
    n = 100000
    g = build_random_graph(n, 10 * n)
    parse_graph(g)


def shortest_path(graph, start_vertex, final_vertex):
    '''Finds the shortest path (min length) between start_vertex and
    end_vertex in the graph 'graph'. Returns the list of vertices along
    the path, starting with start_vertex and ending with end_vertex.
    If start_vertex == end_vertex, it returns [start_vertex].
    If there is no path returns None
    '''
    parents = bfs(graph, start_vertex)
    path = []
    vertex = final_vertex
    while vertex != start_vertex:
        path.append(vertex)
        vertex = parents[vertex]
    path.append(start_vertex)
    path.reverse()
    return path


def bfs(graph, start_vertex):
    '''Does a BFS parsing from start_vertex in the graph 'graph'.
    Returns a dictionary where the keys are the accessible vertices and
    the value is the parent in the BFS for each vertex. Parent of start_vertex
    shall be None.
    '''
    queue = list()
    parents = dict()
    queue.append(start_vertex)
    parents[start_vertex] = None

    while (len(queue) > 0):
        curr_vertex = queue.pop(0)
        nout = graph.parse_nout(curr_vertex)
        for vertex in nout:
            if vertex not in parents:
                queue.append(vertex)
                parents[vertex] = curr_vertex

    return parents


def test_bfs():
    g = build_graph()
    print(shortest_path(g, 0, 2))


test_bfs()
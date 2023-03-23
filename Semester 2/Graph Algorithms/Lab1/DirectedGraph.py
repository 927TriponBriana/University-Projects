import copy


class DirectedGraph:
    def __init__(self, number_of_vertices, number_of_edges):
        self._number_of_vertices = number_of_vertices
        self._number_of_edges = number_of_edges
        self._dict_in = {}
        self._dict_out = {}
        self._dict_cost = {}
        for index in range(number_of_vertices):
            self._dict_in[index] = []
            self._dict_out[index] = []

    @property
    def dictionary_cost(self):
        return self._dict_cost

    @property
    def dictionary_in(self):
        return self._dict_in

    @property
    def dictionary_out(self):
        return self._dict_out

    @property
    def number_of_vertices(self):
        return self._number_of_vertices

    @property
    def number_of_edges(self):
        return self._number_of_edges

    def parse_vertices(self):
        vertices = list(self._dict_in.keys())
        for v in vertices:
            yield v

    def parse_inbound(self, x):
        for y in self._dict_in[x]:
            yield y

    def parse_outbound(self, x):
        for y in self._dict_out[x]:
            yield y

    def parse_cost(self):
        keys = list(self._dict_cost.keys())
        for key in keys:
            yield key

    def add_vertex(self, x):
        if x in self._dict_in.keys() and x in self._dict_out.keys():
            return False
        self._dict_in[x] = []
        self._dict_out[x] = []
        self._number_of_vertices += 1
        return True

    def remove_vertex(self, x):
        if x not in self._dict_in.keys() and x not in self._dict_out.keys():
            return False
        self._dict_in.pop(x)
        self._dict_out.pop(x)
        for key in self._dict_in.keys():
            if x in self._dict_in[key]:
                self._dict_in[key].remove(x)
            elif x in self._dict_out[key]:
                self._dict_out[key].remove(x)
        keys = list(self._dict_cost.keys())
        for key in keys:
            if key[0] == x or key[1] == x:
                self._dict_cost.pop(key)
                self._number_of_edges -= 1
        self._number_of_vertices -= 1
        return True

    def in_degree(self, x):
        if x not in self._dict_in.keys():
            return -1
        return len(self._dict_in[x])

    def out_degree(self, x):
        if x not in self._dict_out.keys():
            return -1
        return len(self._dict_out[x])

    def add_edge(self, x, y, cost):
        if x in self._dict_in[y]:
            return False
        elif y in self._dict_out[x]:
            return False
        elif (x, y) in self._dict_cost.keys():
            return False
        self._dict_in[y].append(x)
        self._dict_out[x].append(y)
        self._dict_cost[(x, y)] = cost
        self._number_of_edges += 1
        return True

    def remove_edge(self, x, y):
        if x not in self._dict_in.keys() or y not in self._dict_in.keys() or x not in self._dict_out.keys() or y not in self._dict_out.keys():
            return False
        if x not in self._dict_in[y]:
            return False
        elif y not in self._dict_out[x]:
            return False
        elif (x, y) not in self._dict_cost.keys():
            return False
        self._dict_in[y].remove(x)
        self._dict_out[x].remove(y)
        self._dict_cost.pop((x, y))
        self._number_of_edges -= 1
        return True

    def find_if_edge(self, x, y):
        if x in self._dict_in[y]:
            return self._dict_cost[(x, y)]
        elif y in self._dict_out[x]:
            return self._dict_cost[(x, y)]
        return False

    def change_cost(self, x, y, cost):
        if (x, y) not in self._dict_cost.keys():
            return False
        self._dict_cost[(x, y)] = cost
        return True

    def make_copy(self):
        return copy.deepcopy(self)

    def find_shortest_path(self, starting_given_vertex, ending_given_vertex):
        """
        This function finds the shortest path between the given vertices, starting_index_vertex and ending_index_vertex
        in the current graph, and returns the list of vertices along the path, starting with the starting_given_vertex
        and ending with the ending_given_vertex. If the starting_given_vertex == ending_given_vertex
        it returns [starting_given_vertex]. If the given vertices are invalid it prints a corresponding message.
        :param starting_given_vertex: the vertex given by the user for the start of the path
        :param ending_given_vertex: the vertex given by the user for the end of the path
        :return: the list of vertices along the path, from the starting_given_vertex to the ending_given_vertex
        """
        if ending_given_vertex >= self._number_of_vertices or starting_given_vertex >= self._number_of_vertices:
            raise ValueError(" The inserted vertices are invalid! ")  # we check firstly if the inserted vertices are valid
        parents = self.breadth_first_search(starting_given_vertex)  # intialize the parents dictionary using bfs
        path = []
        vertex = ending_given_vertex
        while vertex != starting_given_vertex:
            path.append(vertex)
            if vertex not in parents.keys():
                raise ValueError("There is no possible path between the vertices. ")
            vertex = parents[vertex]
        path.append(starting_given_vertex)
        path.reverse()
        return path

    def breadth_first_search(self, start_vertex):
        """
        This function does a BFS parsing from the start vertex int the graph
        :param start_vertex: the given starting vertex for the path
        :return: a dictionary where the keys are the accessible vertices and the value is the parent in the BFS for each
                 vertex. Parent of the start_vertex should be None.
        """
        queue = list()
        parents = dict()
        queue.append(start_vertex)
        parents[start_vertex] = None  # the value of the starting vertex is None

        while len(queue) > 0:
            current_vertex = queue.pop(0)
            nout = self.parse_outbound(current_vertex)  # parsing the vertices outbound in order to take the values for the keys
            for vertex in nout:
                if vertex not in parents:  # we take the vertices if they are not already in
                    queue.append(vertex)  # parents dictionary
                    parents[vertex] = current_vertex
        return parents  # we return the parents dictionary in order to take the path from it


def write_graph_to_file(graph, file):
    file = open(file, "w")
    first_line = str(graph.number_of_vertices) + ' ' + str(graph.number_of_edges) + '\n'
    file.write(first_line)
    if len(graph.dictionary_cost) == 0 and len(graph.dictionary_in) == 0:
        raise ValueError("There is nothing that can be written!")
    for edge in graph.dictionary_cost.keys():
        new_line = "{} {} {}\n".format(edge[0], edge[1], graph.dictionary_cost[edge])
        file.write(new_line)
    for vertex in graph.dictionary_in.keys():
        if len(graph.dictionary_in[vertex]) == 0 and len(graph.dictionary_out[vertex]) == 0:
            new_line = "{}\n".format(vertex)
            file.write(new_line)
    file.close()


def read_graph_from_file(filename):
    file = open(filename, "r")
    line = file.readline()
    line = line.strip()
    vertices, edges = line.split(' ')
    graph = DirectedGraph(int(vertices), int(edges))
    line = file.readline().strip()
    while len(line) > 0:
        line = line.split(' ')
        if len(line) == 1:
            graph.dictionary_in[int(line[0])] = []
            graph.dictionary_out[int(line[0])] = []
        else:
            graph.dictionary_in[int(line[1])].append(int(line[0]))
            graph.dictionary_out[int(line[0])].append(int(line[1]))
            graph.dictionary_cost[(int(line[0]), int(line[1]))] = int(line[2])
        line = file.readline().strip()
    file.close()
    return graph
import copy


class DirectedGraph:
    def __init__(self, number_of_vertices, number_of_edges):
        self._number_of_vertices = number_of_vertices
        self._number_of_edges = number_of_edges
        self._dict_in = {}
        self._dict_out = {}
        self._dict_cost = {}
        for index in range(number_of_vertices):
            self._dict_in[index] = []
            self._dict_out[index] = []

    @property
    def dictionary_cost(self):
        return self._dict_cost

    @property
    def dictionary_in(self):
        return self._dict_in

    @property
    def dictionary_out(self):
        return self._dict_out

    @property
    def number_of_vertices(self):
        return self._number_of_vertices

    @property
    def number_of_edges(self):
        return self._number_of_edges

    def parse_vertices(self):
        vertices = list(self._dict_in.keys())
        for v in vertices:
            yield v

    def parse_inbound(self, x):
        for y in self._dict_in[x]:
            yield y

    def parse_outbound(self, x):
        for y in self._dict_out[x]:
            yield y

    def parse_cost(self):
        keys = list(self._dict_cost.keys())
        for key in keys:
            yield key

    def add_vertex(self, x):
        if x in self._dict_in.keys() and x in self._dict_out.keys():
            return False
        self._dict_in[x] = []
        self._dict_out[x] = []
        self._number_of_vertices += 1
        return True

    def remove_vertex(self, x):
        if x not in self._dict_in.keys() and x not in self._dict_out.keys():
            return False
        self._dict_in.pop(x)
        self._dict_out.pop(x)
        for key in self._dict_in.keys():
            if x in self._dict_in[key]:
                self._dict_in[key].remove(x)
            elif x in self._dict_out[key]:
                self._dict_out[key].remove(x)
        keys = list(self._dict_cost.keys())
        for key in keys:
            if key[0] == x or key[1] == x:
                self._dict_cost.pop(key)
                self._number_of_edges -= 1
        self._number_of_vertices -= 1
        return True

    def in_degree(self, x):
        if x not in self._dict_in.keys():
            return -1
        return len(self._dict_in[x])

    def out_degree(self, x):
        if x not in self._dict_out.keys():
            return -1
        return len(self._dict_out[x])

    def add_edge(self, x, y, cost):
        if x in self._dict_in[y]:
            return False
        elif y in self._dict_out[x]:
            return False
        elif (x, y) in self._dict_cost.keys():
            return False
        self._dict_in[y].append(x)
        self._dict_out[x].append(y)
        self._dict_cost[(x, y)] = cost
        self._number_of_edges += 1
        return True

    def remove_edge(self, x, y):
        if x not in self._dict_in.keys() or y not in self._dict_in.keys() or x not in self._dict_out.keys() or y not in self._dict_out.keys():
            return False
        if x not in self._dict_in[y]:
            return False
        elif y not in self._dict_out[x]:
            return False
        elif (x, y) not in self._dict_cost.keys():
            return False
        self._dict_in[y].remove(x)
        self._dict_out[x].remove(y)
        self._dict_cost.pop((x, y))
        self._number_of_edges -= 1
        return True

    def find_if_edge(self, x, y):
        if x in self._dict_in[y]:
            return self._dict_cost[(x, y)]
        elif y in self._dict_out[x]:
            return self._dict_cost[(x, y)]
        return False

    def change_cost(self, x, y, cost):
        if (x, y) not in self._dict_cost.keys():
            return False
        self._dict_cost[(x, y)] = cost
        return True

    def make_copy(self):
        return copy.deepcopy(self)

    def find_shortest_path(self, starting_given_vertex, ending_given_vertex):
        """
        This function finds the shortest path between the given vertices, starting_index_vertex and ending_index_vertex
        in the current graph, and returns the list of vertices along the path, starting with the starting_given_vertex
        and ending with the ending_given_vertex. If the starting_given_vertex == ending_given_vertex
        it returns [starting_given_vertex]. If the given vertices are invalid it prints a corresponding message.
        :param starting_given_vertex: the vertex given by the user for the start of the path
        :param ending_given_vertex: the vertex given by the user for the end of the path
        :return: the list of vertices along the path, from the starting_given_vertex to the ending_given_vertex
        """
        if ending_given_vertex >= self._number_of_vertices or starting_given_vertex >= self._number_of_vertices:
            raise ValueError(" The inserted vertices are invalid! ")  # we check firstly if the inserted vertices are valid
        parents = self.breadth_first_search(starting_given_vertex)  # intialize the parents dictionary using bfs
        path = []
        vertex = ending_given_vertex
        while vertex != starting_given_vertex:
            path.append(vertex)
            if vertex not in parents.keys():
                raise ValueError("There is no possible path between the vertices. ")
            vertex = parents[vertex]
        path.append(starting_given_vertex)
        path.reverse()
        return path

    def breadth_first_search(self, start_vertex):
        """
        This function does a BFS parsing from the start vertex int the graph
        :param start_vertex: the given starting vertex for the path
        :return: a dictionary where the keys are the accessible vertices and the value is the parent in the BFS for each
                 vertex. Parent of the start_vertex should be None.
        """
        queue = list()
        parents = dict()
        queue.append(start_vertex)
        parents[start_vertex] = None  # the value of the starting vertex is None

        while len(queue) > 0:
            current_vertex = queue.pop(0)
            nout = self.parse_outbound(current_vertex)  # parsing the vertices outbound in order to take the values for the keys
            for vertex in nout:
                if vertex not in parents:  # we take the vertices if they are not already in
                    queue.append(vertex)  # parents dictionary
                    parents[vertex] = current_vertex
        return parents  # we return the parents dictionary in order to take the path from it


def write_graph_to_file(graph, file):
    file = open(file, "w")
    first_line = str(graph.number_of_vertices) + ' ' + str(graph.number_of_edges) + '\n'
    file.write(first_line)
    if len(graph.dictionary_cost) == 0 and len(graph.dictionary_in) == 0:
        raise ValueError("There is nothing that can be written!")
    for edge in graph.dictionary_cost.keys():
        new_line = "{} {} {}\n".format(edge[0], edge[1], graph.dictionary_cost[edge])
        file.write(new_line)
    for vertex in graph.dictionary_in.keys():
        if len(graph.dictionary_in[vertex]) == 0 and len(graph.dictionary_out[vertex]) == 0:
            new_line = "{}\n".format(vertex)
            file.write(new_line)
    file.close()


def read_graph_from_file(filename):
    file = open(filename, "r")
    line = file.readline()
    line = line.strip()
    vertices, edges = line.split(' ')
    graph = DirectedGraph(int(vertices), int(edges))
    line = file.readline().strip()
    while len(line) > 0:
        line = line.split(' ')
        if len(line) == 1:
            graph.dictionary_in[int(line[0])] = []
            graph.dictionary_out[int(line[0])] = []
        else:
            graph.dictionary_in[int(line[1])].append(int(line[0]))
            graph.dictionary_out[int(line[0])].append(int(line[1]))
            graph.dictionary_cost[(int(line[0]), int(line[1]))] = int(line[2])
        line = file.readline().strip()
    file.close()
    return graph

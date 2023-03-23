from DirectedGraph import DirectedGraph
from random import choice
from Exception import myException

class RandomGraphGenerator():
    def __init__(self, n, m):
        self.__graph = DirectedGraph(n)
        self.__generate(n,m)

    def __generate(self, n, m):
        set_of_vertices = [i for i in range(n)]
        costs = [0]
        for i in range(1, 101):
            costs.append(i)
            costs.append(-i)
        index = 0
        while index < m:
            start = choice(set_of_vertices)
            end = choice(set_of_vertices)
            cost = choice(costs)
            try:
                self.__graph.addEdge(start, end, cost)
                index += 1
            except myException:
                pass

    def printGraph(self):
        print("The vertices of the graph are: ")
        print(self.__graph.parseKeys())
        print("The edges of the graph are: ")
        print(self.__graph.edges())
        print("The costs of the graof are: ")
        print(self.__graph.costs())
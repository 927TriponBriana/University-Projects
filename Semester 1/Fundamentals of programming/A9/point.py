class Point:
    def __init__(self, coordinate_x, coordinate_y):
        self.__coordinate_x = int(coordinate_x)
        self.__coordinate_y = int(coordinate_y)

    def get_x(self):
        return self.__coordinate_x

    def get_y(self):
        return self.__coordinate_y

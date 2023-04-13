#include "DynamicArray.h"
#include <stdlib.h>
#include <stdio.h>

DynaminArray* allocateArray(int capacity)
{
    DynaminArray* array = (DynaminArray*)malloc(sizeof(DynaminArray));
    if (array == NULL)
    {
        return NULL;
    }
    array->elements = (TElem*)malloc(sizeof(TElem) * capacity);
    array->length = 0;
    array->capacity = capacity;

    return array;
}

void deallocateArray(DynaminArray* array)
{
    free(array->elements);
    free(array);
}

void addToArray(DynaminArray* array, TElem element)
{
    if (array->length == array->capacity)
    {
        growCapacity(array);
    }

    array->elements[array->length] = element;
    array->length++;
}

void growCapacity(DynaminArray* array)
{
    array->capacity = array->capacity * 2;
}

int searchByDestination(DynaminArray* array, char* destination, int day, int month, int year)
{
    int index;
    if (array == NULL || destination == NULL)
    {
        return NULL;
    }

    for (index = 0; index < array->length; index++)
    {
        if (strcmp(destination, array->elements[index]->destination) == 0 && day == array->elements[index]->day && month == array->elements[index]->month && year == array->elements[index]->year)
        {
            return index;
        }
    }
    return -1;
}

void deleteFromArray(DynaminArray* array, int position)
{
    int index;
    for (index = position; index < array->length - 1; index++)
    {
        array->elements[index] = array->elements[index + 1];
    }
    array->length--;
}

void updateArray(DynaminArray* array, int position, TElem element)
{
    array->elements[position] = element;
}

int getLength(DynaminArray* array)
{
    return array->length;
}
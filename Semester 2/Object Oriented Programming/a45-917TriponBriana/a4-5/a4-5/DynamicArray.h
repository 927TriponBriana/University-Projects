#pragma once
#include "Domain.h"

template <typename TElement>

class DynamicArray
{
private:
	TElement* elements;
	int size;
	int capacity;
	//Function to resize the dynamic array when it reaches the maximum capacity
	void resize_DynamicArray();

public:

	/// Constructor for the DynamicArray class
	/// param capacity - the capacity of the array
	DynamicArray(int capacity = 10);

	//copy constructor for a DynamicArray
	DynamicArray(const DynamicArray& array);

	// assignment operator for a DynamicVector
	DynamicArray& operator=(const DynamicArray& array);

	// subscript operator for the dynamic vector (can replace getter/setter)
	TElement& operator[](int position);

	///Method to add an element to the array
	///\param element - a general element to be added
	void add_element(const TElement& element);

	///Method to delete an element from a position
	///\param position - the position of the element to be deleted
	void delete_element(int position);

	/// Method to update an element from a given position
	///\param position - the position of the element to be updated
	///\param element - the new element
	void update_element(const int position, const TElement element);

	//Getter method for the size of the DynamicArray
	int get_size() const;

	//Getter method for the size of the DynamicArray
	int get_capacity() const;
	
	//gets an element from the given position
	TElement get_element(const int position) const;

	///Destructor
	~DynamicArray();

};


template<typename TElement>
DynamicArray<TElement>::DynamicArray(int capacity)
{
	if (capacity <= 0)
	{
		throw "The capacity is invalid!";
	}
	this->size = 0;
	this->capacity = capacity;
	this->elements = new TElement[capacity];
}

template<typename TElement>
inline void DynamicArray<TElement>::resize_DynamicArray()
{
	auto* new_elements = new TElement[this->capacity * 2];
	for (int current_position = 0; current_position < this->size; current_position++)
	{
		new_elements[current_position] = this->elements[current_position];
	}
	delete[] this->elements;
	this->elements = new_elements;
	this->capacity = this->capacity * 2;
}

template<typename TElement>
inline DynamicArray<TElement>::DynamicArray(const DynamicArray<TElement>& array)
{
	this->size = array.get_size();
	this->capacity = array.get_capacity();
	this->elements = new TElement[this->capacity];
	for (int position = 0; position < this->size; position++)
	{
		this->elements[position] = array.get_element(position);
	}
}

template<typename TElement>
inline DynamicArray<TElement>& DynamicArray<TElement>::operator=(const DynamicArray<TElement>& array)
{
	if (this == &array)
	{
		return *this;
	}
	this->size = array.size;
	this->capacity = array.capacity;

	delete[] this->elements;
	this->elements = new TElement[this->capacity];
	for (int position = 0; position < this->size; position++)
	{
		this->elements[position] = array.elements[position];
	}
	return *this;
}

template<typename TElement>
inline TElement& DynamicArray<TElement>::operator[](int position)
{
	return this->elements[position];
}

template<typename TElement>
inline void DynamicArray<TElement>::add_element(const TElement& element)
{
	if (this->size == this->capacity)
	{
		this->resize_DynamicArray();
	}
	this->elements[this->size] = element;
	this->size++;
}


template<typename TElement>
inline void DynamicArray<TElement>::delete_element(int position)
{
	for (int current_position = position; current_position < this->size - 1; current_position++)
	{
		this->elements[current_position] = this->elements[current_position + 1];
	}
	this->size--;
}

template<typename TElement>
inline void DynamicArray<TElement>::update_element(const int position, const TElement element)
{
	this->elements[position] = element;
}

template<typename TElement>
inline int DynamicArray<TElement>::get_size() const
{
	return this->size;
}

template<typename TElement>
inline int DynamicArray<TElement>::get_capacity() const
{
	return this->capacity;
}


template<typename TElement>
inline TElement DynamicArray<TElement>::get_element(const int position) const
{
	return this->elements[position];
}

template<typename TElement>
inline DynamicArray<TElement>::~DynamicArray()
{
	delete[] this->elements;
}




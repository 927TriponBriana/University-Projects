#pragma once
#include "DynamicArray.h"

class UserRepository
{
private:
	DynamicArray<Dog> adoption_list;

public:
	//default constructor for the repository
	UserRepository() {}

	~UserRepository();

	////gets all the elements from the repository
	//Dog* get_all_user_repository();

	//gets the number of the elements from the repository
	int get_number_of_elements();

	//gets the capacity of the repository
	int get_capacity();

	//adds a dog to the adoption list
	void add_user_repository(const Dog& dog);

	//gets all the elements from the user repository
	DynamicArray<Dog> get_adoption_list() const { return this->adoption_list; }

	/*~UserRepository();*/
};
#pragma once
#include "Domain.h"
#include "DynamicArray.h"

class Repository
{
private:
	DynamicArray<Dog> Dogs;

public:
	//default constructor for the repository
	Repository() {}

	~Repository();

	//initiates the repository with the list of dogs
	void initialise_repository();

	//adds a dog to the repository
	void add_to_repository(const Dog& dog);

	//deletes the dog from the given position
	void delete_from_repository(const string& breed, const string& name);

	//updates the dog from the given position with the given new dog
	void update_repository(const string& breed, const string& name, const Dog& new_dog);

	//gets all the elements from the repository
	DynamicArray<Dog> get_dogs() const { return this->Dogs; }

	//gets the number of elements from the repository
	int get_number_of_elements();

	//gets the capacity of the repository
	int get_repository_capacity();

	//returns the position of the dog with the specified breed and name
	int find_position_by_breed_and_name(const string breed, const string name);
};
#pragma once
#include "Repository.h";

class Service
{
private:
	Repository& repository;

public:
	//default constructor for the service class
	Service(Repository& repo) : repository(repo) {}

	~Service();

	Repository get_repository() const { return repository; }

	//adds a dog
	int add_dog_to_repository(const string& breed, const string& name, int age, const string& photograph);


	//deletes the dog with the given breed and name
	int delete_dog_from_repository(const string& breed, const string& name);

	//updates the dog with the given breed and name with the new information
	int update_dog_from_repository(const string& breed, const string& name, const string& new_breed, const string& new_name, int new_age, const string& new_photograph);

	DynamicArray<Dog> get_all_dogs() const;
};
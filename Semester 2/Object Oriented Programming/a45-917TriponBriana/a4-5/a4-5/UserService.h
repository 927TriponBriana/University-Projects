#pragma once
#include "UserRepository.h"
#include "Repository.h"

class UserService
{
private:
	Repository& repository;
	UserRepository& user_repository;

public:
	//constructor for the user service
	/*UserService(Repository* repository, UserRepository* user_repository);*/
	//default constructor for the service class
	UserService(Repository& repo, UserRepository& user_repo) : repository(repo), user_repository(user_repo) {}

	~UserService();

	Repository get_repository() const { return repository; }

	//gets all the elements from the array
	/*Dog* get_all_user_service();*/

	//gets the number of elements from the array
	/*int get_number_elements_user_service();*/

	//gets the capacity of the array
	/*int get_capacity_user_service();*/

	//adds a dog to the adoption list
	void add_dog_to_user_repository(const string& breed, const string& name, int age, const string& photograph);

	DynamicArray<Dog> get_all_dogs_from_adoption_list() const;

	//selects all the dogs of a given breed, having an age less than a given number
	/*int get_filtered_dogs(Dog* valid_dogs, string given_breed, int given_age);*/
	DynamicArray<Dog> filter_dogs(const string& breed, int age) const;

	/*~UserService()*/;
};
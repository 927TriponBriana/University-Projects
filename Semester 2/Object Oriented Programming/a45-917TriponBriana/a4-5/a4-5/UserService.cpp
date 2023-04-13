#include "UserService.h"


UserService::~UserService() = default;

void UserService::add_dog_to_user_repository(const string& breed, const string& name, int age, const string& photograph)
{
	Dog new_dog = Dog(breed, name, age, photograph);
	this->user_repository.add_user_repository(new_dog);
	this->repository.delete_from_repository(breed, name);
}

DynamicArray<Dog> UserService::get_all_dogs_from_adoption_list() const
{
	return this->user_repository.get_adoption_list();
}


DynamicArray<Dog> UserService::filter_dogs(const string& breed, int age) const
{
	DynamicArray<Dog> new_dogs, dogs = repository.get_dogs();
	for (int current_dog_position = 0; current_dog_position < dogs.get_size(); current_dog_position++)
	{
		Dog dog = dogs[current_dog_position];
		if (dog.get_age() < age && (breed.size() && dog.get_breed() == breed || !breed.size()))
		{
			new_dogs.add_element(dog);
		}
	}
	return new_dogs;
}


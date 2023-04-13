#include "Service.h"


Service::~Service() = default;

int Service::add_dog_to_repository(const string& breed, const string& name, int age, const string& photograph)
{

	if (repository.find_position_by_breed_and_name(breed, name) != -1)
	{
		return false;
	}
	Dog dog_to_be_added = Dog(breed, name, age, photograph);
	this->repository.add_to_repository(dog_to_be_added);
	return true;
}

int Service::delete_dog_from_repository(const string& breed, const string& name)
{
	if (repository.find_position_by_breed_and_name(breed, name) == -1)
	{
		return false;
	}
	this->repository.delete_from_repository(breed, name);
	return true;
}

int Service::update_dog_from_repository(const string& breed, const string& name, const string& new_breed, const string& new_name, int new_age, const string& new_photograph)
{
	if (repository.find_position_by_breed_and_name(breed, name) == -1)
	{
		return false;
	}
	Dog new_dog = Dog(new_breed, new_name, new_age, new_photograph);
	this->repository.update_repository(breed, name, new_dog);
	return true;
}

DynamicArray<Dog> Service::get_all_dogs() const
{
	return this->repository.get_dogs();
}


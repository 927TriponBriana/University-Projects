#include "UserRepository.h"


UserRepository::~UserRepository() = default;

int UserRepository::get_number_of_elements()
{
	return this->adoption_list.get_size();
}

int UserRepository::get_capacity()
{
	return this->adoption_list.get_capacity();
}

void UserRepository::add_user_repository(const Dog& dog)
{
	this->adoption_list.add_element(dog);
}


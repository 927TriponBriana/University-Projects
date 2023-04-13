#include "TestUserService.h"
#include <cassert>

void test_user_service()
{
	auto* dynamicArray = new DynamicArray<Dog>(10);
	Repository repository{};
	repository.initialise_repository();
	UserRepository user_repository{};
	UserService user_service{ repository, user_repository };
	assert(user_service.get_repository().get_number_of_elements() == 10);
	assert(user_service.get_repository().get_repository_capacity() == 10);
	Dog dog = repository.get_dogs()[0];
	user_service.add_dog_to_user_repository(dog.get_breed(), dog.get_name(), dog.get_age(), dog.get_photograph());
}

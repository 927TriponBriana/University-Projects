#include "TestUserRepository.h"
#include <cassert>

void test_user_repository()
{
	auto* dynamic_array = new DynamicArray<Dog>(10);
	UserRepository user_repository{};
	assert(user_repository.get_capacity() == 10);
	Dog dog1 = Dog("German Shepherd", "Bruno", 12, "http://www.zooland.ro/data/articles/39/652/2005421143847lup-0n.jpg");
	Dog dog2 = Dog("Akita Inu", "Thor", 5, "https://s3.publi24.ro/vertical-ro-f646bd5a/extralarge/20190815/1351/fadb271780baa1710c1b2b7708635aa3.jpg");
	user_repository.add_user_repository(dog1);
	assert(user_repository.get_number_of_elements() == 1);
	user_repository.add_user_repository(dog2);
	assert(user_repository.get_number_of_elements() == 2);
}

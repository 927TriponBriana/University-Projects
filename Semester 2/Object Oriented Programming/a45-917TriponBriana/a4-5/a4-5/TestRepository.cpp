#include "TestRepository.h"
#include <cassert>

void test_repository()
{
	auto* dynamicArray = new DynamicArray<Dog>(10);
	Repository repository{};
	repository.initialise_repository();
	assert(repository.get_number_of_elements() == 10);
	assert(repository.get_repository_capacity() == 10);
	Dog dog = Dog("Labrador", "Elena", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	repository.add_to_repository(dog);
	assert(repository.get_number_of_elements() == 11);
	assert(repository.get_repository_capacity() == 20);
	assert(repository.find_position_by_breed_and_name("Labrador", "Leila") == 0);
	repository.delete_from_repository("Labrador", "Leila");
	assert(repository.get_number_of_elements() == 10);
	Dog new_dog = Dog("Labrador", "Elen", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
}

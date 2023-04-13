#include "TestService.h"
#include <cassert>

void test_service()
{
	auto* dynamicArray = new DynamicArray<Dog>(10);
	Repository repository{};
	repository.initialise_repository();
	Service service{ repository };
	assert(service.get_all_dogs()[0].get_name() == "Leila");
	assert(service.get_all_dogs().get_capacity() == 10);
	assert(service.get_all_dogs().get_size() == 10);
	int added = service.add_dog_to_repository("Labrador", "Elena", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	assert(added == true);
	assert(service.get_all_dogs().get_size() == 11);
	assert(service.get_all_dogs().get_capacity() == 20);
	added = service.add_dog_to_repository("Labrador", "Elena", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	assert(added == false);
	int deleted = service.delete_dog_from_repository("Labrador", "Elena");
	assert(deleted == true);
	assert(service.get_all_dogs().get_size() == 10);
	int new_deleted = service.delete_dog_from_repository("l", "El");
	assert(new_deleted == false);
	int updated = service.update_dog_from_repository("Labrador", "Leila", "Labrador", "Emi", 2, "https://static.impact.ro/unsafe/970x546/smart/filters:contrast(5):format(webp):quality(90)/https://www.impact.ro/wp-content/uploads/2020/05/C%C3%A2t-cost%C4%83-de-fapt-un-labrador-cu-pedigree-%C3%AEn-Rom%C3%A2nia-1024x675.jpg");
	assert(updated == true);
	updated = service.update_dog_from_repository("Maltipoo", "Bobi", "B", "Rex", -3, "https://www.sksk");
	assert(updated == false);
}

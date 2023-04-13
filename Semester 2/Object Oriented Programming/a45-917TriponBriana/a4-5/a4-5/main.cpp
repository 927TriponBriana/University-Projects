#include "UI.h"
#include "Service.h"
#include "UserService.h"
#include "UserRepository.h"
#include <Windows.h>
#include <crtdbg.h>
#include "TestDomain.h"
#include "TestDynamicArray.h"
#include "TestRepository.h"
#include "TestService.h"
#include "TestUserRepository.h"
#include "TestUserService.h"
#include "test_all.h"
#include <crtdbg.h>

using namespace std;

void test_aIl()
{
	test_domain();
	test_dynamicArray();
	test_repository();
	test_service();
	test_user_repository();
	test_user_service();
}


int main()
{
	{
		test_all();
		Repository repository{};
		repository.initialise_repository();
		Service service{ repository };
		UserRepository user_repository{};
		UserService user_service{repository, user_repository };
		UI ui{ service, user_service };
		ui.run();

	}
	_CrtDumpMemoryLeaks();
	return 0;
}












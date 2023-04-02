from django.test import TestCase
from app1.models import Patient, Dentist, Consultation, Medication, MedicationDentist


class MedicationByAvgDentistAgeTestCase(TestCase):
    @classmethod
    def setUpTestData(cls):
        med1 = Medication.objects.create(med_name="Algocalmin", med_active_subst="metamizol sodic", med_price=20, med_expiration_date="10-12-2024", med_usage="cu un pahar de apa")
        med2 = Medication.objects.create(med_name="Augmentin", med_active_subst="metamizol sodic", med_price=35, med_expiration_date="10-12-2025", med_usage="cu un pahar de apa")
        med3 = Medication.objects.create(med_name="Nurofen", med_active_subst="metamizol sodic", med_price=30, med_expiration_date="30-01-2024", med_usage="cu un pahar de apa")
        med4 = Medication.objects.create(med_name="Advil", med_active_subst="metamizol sodic", med_price=25, med_expiration_date="20-05-2024", med_usage="cu un pahar de apa")
        dentist1 = Dentist.objects.create(dentist_first_name="Boitor", dentist_last_name="Patrick", dentist_age=31, dentist_country="Romania", dentist_salary=15000)
        dentist2 = Dentist.objects.create(dentist_first_name="Pop", dentist_last_name="Ovidiu", dentist_age=29, dentist_country="Romania", dentist_salary=12000)
        dentist3 = Dentist.objects.create(dentist_first_name="Leiher", dentist_last_name="Nora", dentist_age=46, dentist_country="Romania", dentist_salary=20000)
        med_dentist1 = MedicationDentist.objects.create(prescription_date="19-03-2023", diagnostic="extractie molari de minte", dentist_id=1, medication_id=2)
        med_dentist2 = MedicationDentist.objects.create(prescription_date="19-06-2023",  diagnostic="extractie molari de minte", dentist_id=2, medication_id=2)
        med_dentist3 = MedicationDentist.objects.create(prescription_date="28-02-2023", diagnostic="plombare", dentist_id=3, medication_id=3)
        med_dentist4 = MedicationDentist.objects.create(prescription_date="28-02-2023", diagnostic="plombare", dentist_id=2, medication_id=1)
        med_dentist5 = MedicationDentist.objects.create(prescription_date="28-02-2023", diagnostic="plombare", dentist_id=1, medication_id=4)

    def test_url_exists(self):
        response = self.client.get("/app1/clin/medication/order-by-avg-dentist-age/")
        self.assertEqual(response.status_code, 200)

    def test_count_correctly_returned(self):
         response=self.client.get("/app1/clin/medication/")
         self.assertEqual(len(response.data), 4)

    def test_string_method_medication(self):
        medication = Medication.objects.get(med_name='Algocalmin')
        expected_string = "Algocalmin"
        self.assertEqual(str(medication), expected_string)

    def test_string_method_dentist(self):
        dentist = Dentist.objects.get(dentist_first_name="Boitor")
        expected_string = "Boitor"
        self.assertEqual(str(dentist), expected_string)

    def test_string_method_med_dentist(self):
        med_dentist = MedicationDentist.objects.get(dentist_id=1, medication_id=2)
        expected_string = "Augmentin--Boitor"
        self.assertEqual(str(med_dentist), expected_string)

    def test_medication_dentist_ordered(self):
        response = self.client.get("/app1/clin/medication/order-by-avg-dentist-age/")
        first = response.data[0]['med_name']
        second = response.data[1]['med_name']
        third = response.data[2]['med_name']
        fourth = response.data[3]['med_name']
        expected_med_name_first = "Algocalmin"
        expected_med_name_second = "Augmentin"
        expected_med_name_third = "Advil"
        expected_med_name_fourth = "Nurofen"
        self.assertEqual(str(first), expected_med_name_first)
        self.assertEqual(str(second), expected_med_name_second)
        self.assertEqual(str(third), expected_med_name_third)
        self.assertEqual(str(fourth), expected_med_name_fourth)




# class TravelAgencyOrderedByCityBreakAvgPriceModelTestcase(TestCase):
#     @classmethod
#     def setUpTestData(cls):
#         one_c=CityBreak.objects.create(country='Italy',city='Rome',hotel='Grand Hotel',price=500,transport='plane')
#         two_c=CityBreak.objects.create(country='Spain', city='Madrid', hotel='Blue Hotel', price=250, transport='plane')
#         three_c=CityBreak.objects.create(country='Romania',city='Brasov',hotel='Bran Hotel',price=300,transport='bus')
#         four_c=CityBreak.objects.create(country='Croatia',city='Zagreb',hotel='Sunny Hotel',price=400,transport='train')
#         one_t=TravelAgency.objects.create(name='gama',website='www.gama.com',address='str.Fabricii,nr5',nrOfEmployees=150,nrOfOffers=520)
#         two_t=TravelAgency.objects.create(name='ztour', website='www.ztour.com', address='str.Memorandumului,nr.6', nrOfEmployees=200,nrOfOffers=500)
#         three_t=TravelAgency.objects.create(name='Jubel', website='www.jubel.com', address='3917 Marion Street', nrOfEmployees=700,nrOfOffers=1000)
#         CityBreakAgency.objects.create(creatingDate='2022-02-15',enrollmentDeadline='2022-03-20',cityBreak=one_c,agency=one_t)
#         CityBreakAgency.objects.create(creatingDate='2022-10-24', enrollmentDeadline='2022-11-25', cityBreak=two_c,agency=one_t)
#         CityBreakAgency.objects.create(creatingDate='2023-02-10', enrollmentDeadline='2023-03-15', cityBreak=three_c,agency=two_t)
#         CityBreakAgency.objects.create(creatingDate='2023-01-15', enrollmentDeadline='2023-02-17', cityBreak=four_c,agency=three_t)
#
#     def test_url_exists(self):
#         response=self.client.get("/snippets/travel/by-avg-price/")
#         self.assertEqual(response.status_code,200)
#
#     def test_count_correctly_returned(self):
#         response=self.client.get("/snippets/citAgency/")
#         self.assertEqual(len(response.data),4)
#
#     def test_string_method_citybreak(self):
#         citybreak = CityBreak.objects.get(country='Italy')
#         expected_string = "Italy"
#         self.assertEqual(str(citybreak), expected_string)
#
#     def test_string_method_travelagency(self):
#         travelagency = TravelAgency.objects.get(name="gama")
#         expected_string = "gama"
#         self.assertEqual(str(travelagency), expected_string)
#
#     def test_string_method_citagency(self):
#         citAgency = CityBreakAgency.objects.get(agency=2,cityBreak=3)
#         expected_string = "Romania-ztour"
#         self.assertEqual(str(citAgency), expected_string)
#
#     def test_agency_citybreak_ordered(self):
#         response=self.client.get("/snippets/travel/by-avg-price/")
#         first=response.data[0]['name']
#         second=response.data[1]['name']
#         third=response.data[2]['name']
#         expected_name_first="ztour"
#         expected_name_second="gama"
#         expected_name_third="Jubel"
#         self.assertEqual(str(first),expected_name_first)
#         self.assertEqual(str(second),expected_name_second)
#         self.assertEqual(str(third),expected_name_third)
#


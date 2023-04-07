from django.test import TestCase
from app1.models import Dentist, Consultation, Medication, MedicationDentist


class MedicationByNoOfOtherDentistsPrescribed(TestCase):
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
        med_dentist2 = MedicationDentist.objects.create(prescription_date="19-06-2023",diagnostic="extractie molari de minte", dentist_id=2, medication_id=2)
        med_dentist3 = MedicationDentist.objects.create(prescription_date="28-02-2023", diagnostic="plombare", dentist_id=3, medication_id=3)
        med_dentist4 = MedicationDentist.objects.create(prescription_date="28-02-2023", diagnostic="plombare", dentist_id=2, medication_id=1)
        # med_dentist5 = MedicationDentist.objects.create(prescription_date="28-02-2023", diagnostic="plombare", dentist_id=1, medication_id=4)
        med_dentist5 = MedicationDentist.objects.create(prescription_date="28-02-2023", diagnostic="plombare", dentist_id=1, medication_id=1)
        med_dentist6 = MedicationDentist.objects.create(prescription_date="28-02-2023", diagnostic="plombare", dentist_id=3, medication_id=1)

    def test_medication_by_no_of_other_dentists(self):
        response = self.client.get("/app1/clin/medication/by-number-of-other-dentists/")
        self.assertEqual(len(response.data), 3)
        first = response.data[0]['med_name']
        first_no_other_dentists = response.data[0]['number_other_dentists']
        self.assertEqual(first, 'Algocalmin')
        self.assertEqual(first_no_other_dentists, 2)

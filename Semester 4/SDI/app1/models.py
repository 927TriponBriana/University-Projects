from django.db import models


# Create your models here.


class Patient(models.Model):
    patient_first_name = models.CharField(max_length=50)
    patient_last_name = models.CharField(max_length=50)
    patient_age = models.IntegerField()
    patient_country = models.CharField(max_length=50)
    patient_consultation = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.patient_first_name}"


class Consultation(models.Model):
    consultation_type = models.CharField(max_length=50)
    consultation_price = models.IntegerField()
    consultation_duration = models.IntegerField()
    consultation_date = models.CharField(max_length=10)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)

    def __str__(self):
        return f"{self.consultation_type}"


class Dentist(models.Model):
    dentist_first_name = models.CharField(max_length=50)
    dentist_last_name = models.CharField(max_length=50)
    dentist_age = models.IntegerField()
    dentist_country = models.CharField(max_length=50)
    dentist_salary = models.IntegerField()
    med = models.ManyToManyField('Medication', through='MedicationDentist')

    def __str__(self):
        return f"{self.dentist_first_name}"


class Medication(models.Model):
    med_name = models.CharField(max_length=50)
    med_active_subst = models.CharField(max_length=50)
    med_price = models.IntegerField()
    med_expiration_date = models.CharField(max_length=10)
    med_usage = models.CharField(max_length=50)
    dent = models.ManyToManyField(Dentist, through='MedicationDentist')

    def __str__(self):
        return f"{self.med_name}"


class MedicationDentist(models.Model):
    medication = models.ForeignKey(Medication, on_delete=models.CASCADE)
    dentist = models.ForeignKey(Dentist, on_delete=models.CASCADE)
    prescription_date = models.CharField(max_length=10)
    diagnostic = models.CharField(max_length=50)

    def __str__(self):
        return f"{self.medication}--{self.dentist}"

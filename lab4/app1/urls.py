from django.urls import path
from .views import PatientDetail, PatientInfo, DentistInfo, DentistDetail, PatientOlderThan18, ConsultationDetail, \
    ConsultationInfo, PatientIds, MedicationByNumberOfOtherDentistsPrescribed
from .views import MedicationDetail, MedicationInfo, MedicationDentistDetail, MedicationDentistInfo, MedicationByAvgDentistAge

urlpatterns = [
    path("clin/patient/", PatientDetail.as_view(), name="clin"),
    path("clin/patient/<int:pk>/", PatientInfo.as_view()),
    path("clin/patient/older-than-18/", PatientOlderThan18.as_view()),
    path("clin/patient/patient-ids/", PatientIds.as_view()),

    path("clin/dentist/", DentistDetail.as_view(), name="clin"),
    path("clin/dentist/<int:id>/", DentistInfo.as_view()),

    path("clin/consultation/", ConsultationDetail.as_view(), name="clin"),
    path("clin/consultation/<int:id>/", ConsultationInfo.as_view()),

    path("clin/medication/", MedicationDetail.as_view(), name="clin"),
    path("clin/medication/<int:id>/", MedicationInfo.as_view()),

    path("clin/medication-dentist/", MedicationDentistDetail.as_view(), name="clin"),
    path("clin/medication-dentist/<int:id>/", MedicationDentistInfo.as_view()),
    path("clin/medication/order-by-avg-dentist-age/", MedicationByAvgDentistAge.as_view()),
    path("clin/medication/by-number-of-other-dentists/", MedicationByNumberOfOtherDentistsPrescribed.as_view()),
]

from django.db.models import Avg, Count, OuterRef
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from ..models import Patient, Dentist, Consultation, Medication, MedicationDentist
from ..serializer import PatientSerializer, DentistSerializer, ConsultationSerializer, MedicationSerializer, \
    MedicationDentistSerializer, PatientIdSerializer
from rest_framework import generics


class MedicationByAvgDentistAge(generics.ListAPIView):
    serializer_class = MedicationSerializer

    def get_queryset(self):
        query = Medication.objects.annotate(avg_age=Avg('medicationdentist__dentist__dentist_age')).order_by('avg_age')
        print(query.query)

        return query

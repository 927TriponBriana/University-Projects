from django.db.models import Avg, Count, OuterRef
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from ..models import Patient, Dentist, Consultation, Medication, MedicationDentist
from ..serializer import PatientSerializer, DentistSerializer, ConsultationSerializer, MedicationSerializer, \
    MedicationDentistSerializer, PatientIdSerializer
from rest_framework import generics


class AddConsultations(APIView):
    def post(self, request, id):
        consultation_data = request.data
        msg = "CREATED"

        print(request.data)
        for consultation in consultation_data:
            consultation['patient'] = id
            print(consultation)
            serializer = ConsultationSerializer(data=consultation)
            if serializer.is_valid():
                serializer.save()
        return Response(msg, status=status.HTTP_201_CREATED)

    def get(self, request, id):
        obj = Consultation.objects.filter(id=id)
        serializer = ConsultationSerializer(obj, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


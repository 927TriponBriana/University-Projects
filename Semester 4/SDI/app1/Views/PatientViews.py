from django.db.models import Avg, Count, OuterRef
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from ..models import Patient, Dentist, Consultation, Medication, MedicationDentist
from ..serializer import PatientSerializer, DentistSerializer, ConsultationSerializer, MedicationSerializer, \
    MedicationDentistSerializer, PatientIdSerializer
from rest_framework import generics

class PatientDetail(APIView):
    def get(self, request):
        obj = Patient.objects.all()
        serializer = PatientSerializer(obj, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = PatientSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)


class PatientInfo(APIView):
    def get(self, request, id):
        try:
            obj = Patient.objects.get(id=id)
        except Patient.DoesNotExist:
            msg = {"msg" : "Not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)
        serializer = PatientSerializer(obj)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def put(self, request, id):
        try:
            obj = Patient.objects.get(id=id)
        except Patient.DoesNotExist:
            msg = {"msg" : "Not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)
        serializer = PatientSerializer(obj, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, id):
        try:
            obj = Patient.objects.get(id=id)
        except Patient.DoesNotExist:
            msg = {"msg": "Not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)
        serializer = PatientSerializer(obj, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def delete(self, request, id):
        try:
            obj = Patient.objects.get(id=id)
        except Patient.DoesNotExist:
            msg = {"msg": "Not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)
        obj.delete()
        return Response({"msg" : "Deleted"}, status=status.HTTP_204_NO_CONTENT)

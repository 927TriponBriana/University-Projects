from django.db.models import Avg, Count, OuterRef
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status
from .models import Patient, Dentist, Consultation, Medication, MedicationDentist
from .serializer import PatientSerializer, DentistSerializer, ConsultationSerializer, MedicationSerializer, \
    MedicationDentistSerializer, PatientIdSerializer
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated


# class PatientDetail(APIView):
#     def get(self, request):
#         obj = Patient.objects.all()
#         serializer = PatientSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def post(self, request):
#         serializer = PatientSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
#
# class PatientInfo(APIView):
#     def get(self, request, id):
#         try:
#             obj = Patient.objects.get(id=id)
#         except Patient.DoesNotExist:
#             msg = {"msg" : "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = PatientSerializer(obj)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def put(self, request, id):
#         try:
#             obj = Patient.objects.get(id=id)
#         except Patient.DoesNotExist:
#             msg = {"msg" : "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = PatientSerializer(obj, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def patch(self, request, id):
#         try:
#             obj = Patient.objects.get(id=id)
#         except Patient.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = PatientSerializer(obj, data=request.data, partial=True)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def delete(self, request, id):
#         try:
#             obj = Patient.objects.get(id=id)
#         except Patient.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         obj.delete()
#         return Response({"msg" : "Deleted"}, status=status.HTTP_204_NO_CONTENT)


# class DentistDetail(APIView):
#     def get(self, request):
#         obj = Dentist.objects.all()
#         serializer = DentistSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def post(self, request):
#         serializer = DentistSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
#
# class DentistInfo(APIView):
#     def get(self, request, id):
#         try:
#             obj = Dentist.objects.get(id=id)
#         except Dentist.DoesNotExist:
#             msg = {"msg" : "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = DentistSerializer(obj)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def put(self, request, id):
#         try:
#             obj = Dentist.objects.get(id=id)
#         except Dentist.DoesNotExist:
#             msg = {"msg" : "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = DentistSerializer(obj, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def patch(self, request, id):
#         try:
#             obj = Dentist.objects.get(id=id)
#         except Dentist.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = DentistSerializer(obj, data=request.data, partial=True)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def delete(self, request, id):
#         try:
#             obj = Dentist.objects.get(id=id)
#         except Dentist.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         obj.delete()
#         return Response({"msg": "Deleted"}, status=status.HTTP_204_NO_CONTENT)


# class PatientOlderThan18(generics.ListAPIView):
#     serializer_class = PatientSerializer
#
#     def get_queryset(self):
#         query = Patient.objects.filter(patient_age__gt=18)
#         print(query.query)
#
#         return query


# class PatientIds(APIView):
#     def get(self, request):
#         obj = Patient.objects.all()
#         serializer = PatientIdSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)


# class ConsultationDetail(APIView):
#     def get(self, request):
#         obj = Consultation.objects.all()
#         serializer = ConsultationSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def post(self, request):
#         serializer = ConsultationSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
#
# class ConsultationInfo(APIView):
#     def get(self, request, id):
#         try:
#             obj = Consultation.objects.get(id=id)
#         except Consultation.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = ConsultationSerializer(obj)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def put(self, request, id):
#         try:
#             obj = Consultation.objects.get(id=id)
#         except Consultation.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = ConsultationSerializer(obj, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def patch(self, request, id):
#         try:
#             obj = Consultation.objects.get(id=id)
#         except Consultation.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = ConsultationSerializer(obj, data=request.data, partial=True)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def delete(self, request, id):
#         try:
#             obj = Consultation.objects.get(id=id)
#         except Consultation.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         obj.delete()
#         return Response({"msg" : "Deleted"}, status=status.HTTP_204_NO_CONTENT)


# class AddConsultations(APIView):
#     def post(self, request, id):
#         consultation_data = request.data
#         msg = "CREATED"
#
#         print(request.data)
#         for consultation in consultation_data:
#             consultation['patient'] = id
#             print(consultation)
#             serializer = ConsultationSerializer(data=consultation)
#             if serializer.is_valid():
#                 serializer.save()
#         return Response(msg, status=status.HTTP_201_CREATED)
#
#     def get(self, request, id):
#         obj = Consultation.objects.filter(id=id)
#         serializer = ConsultationSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#

# class AddCitybreaks(APIView):
#
#     def post(self, request, id):
#         city_break_data = request.data
#         msg = "CREATED"
#
#         print(request.data)
#         for cit in city_break_data:
#             cit['person'] = id
#             print(cit)
#             serializer = CityBreakSerializer(data=cit)
#             if serializer.is_valid():
#                 serializer.save()
#         return Response(msg, status=status.HTTP_201_CREATED)
#
#     def get(self, request, id):
#         obj = CityBreak.objects.filter(id=id)
#         serializer = CityBreakSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)


#
# class MedicationDetail(APIView):
#     def get(self, request):
#         obj = Medication.objects.all()
#         serializer = MedicationSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def post(self, request):
#         serializer = MedicationSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
#
# class MedicationInfo(APIView):
#     def get(self, request, id):
#         try:
#             obj = Medication.objects.get(id=id)
#         except Medication.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = MedicationSerializer(obj)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def put(self, request, id):
#         try:
#             obj = Medication.objects.get(id=id)
#         except Medication.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = MedicationSerializer(obj, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#     def patch(self, request, id):
#         try:
#             obj = Medication.objects.get(id=id)
#         except Medication.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = MedicationSerializer(obj, data=request.data, partial=True)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def delete(self, request, id):
#         try:
#             obj = Medication.objects.get(id=id)
#         except Medication.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         obj.delete()
#         return Response({"msg" : "Deleted"}, status=status.HTTP_204_NO_CONTENT)


# class MedicationDentistDetail(APIView):
#     def get(self, request):
#         obj = MedicationDentist.objects.all()
#         serializer = MedicationDentistSerializer(obj, many=True)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def post(self, request):
#         serializer = MedicationDentistSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)
#
#
# class MedicationDentistInfo(APIView):
#     def get(self, request, id):
#         try:
#             obj = MedicationDentist.objects.get(id=id)
#         except MedicationDentist.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = MedicationDentistSerializer(obj)
#         return Response(serializer.data, status=status.HTTP_200_OK)
#
#     def put(self, request, id):
#         try:
#             obj = MedicationDentist.objects.get(id=id)
#         except MedicationDentist.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = MedicationDentistSerializer(obj, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def patch(self, request, id):
#         try:
#             obj = MedicationDentist.objects.get(id=id)
#         except MedicationDentist.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         serializer = MedicationDentistSerializer(obj, data=request.data, partial=True)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
#
#     def delete(self, request, id):
#         try:
#             obj = MedicationDentist.objects.get(id=id)
#         except MedicationDentist.DoesNotExist:
#             msg = {"msg": "Not found"}
#             return Response(msg, status=status.HTTP_404_NOT_FOUND)
#         obj.delete()
#         return Response({"msg": "Deleted"}, status=status.HTTP_204_NO_CONTENT)


# class MedicationByAvgDentistAge(generics.ListAPIView):
#     serializer_class = MedicationSerializer
#
#     def get_queryset(self):
#         query = Medication.objects.annotate(avg_age=Avg('medicationdentist__dentist__dentist_age')).order_by('avg_age')
#         print(query.query)
#
#         return query


# class MedicationByNumberOfOtherDentistsPrescribed(generics.ListAPIView):
#     serializer_class = MedicationSerializer
#
#     def get_queryset(self):
#         query = Medication.objects.annotate(
#             number_other_dentists=Count(
#                 Dentist.med.through.objects.filter(
#                     medication_id=OuterRef('pk')
#                 ).exclude(
#                     dentist_id=OuterRef('dentist__id')
#                 ).values('dentist_id').distinct(),
#                 distinct=True
#             )
#         ).order_by('-number_other_dentists')[:3]
#
#         print(query.query)
#
#         return query

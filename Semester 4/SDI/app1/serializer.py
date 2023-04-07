from rest_framework import serializers
from .models import Patient, Dentist, Consultation, Medication, MedicationDentist


class PatientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Patient
        fields = "__all__"


class DentistSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dentist
        fields = "__all__"


class PatientIdSerializer(serializers.ModelSerializer):
    class Meta:
        model = Patient
        fields = ["id"]


class DentistIdSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dentist
        fields = ['id']


class ConsultationSerializer(serializers.ModelSerializer):
    patients = PatientSerializer(many=True, read_only=True)

    class Meta:
        model = Consultation
        fields = ('id', 'consultation_type', 'consultation_price', 'consultation_duration', 'consultation_date', 'patient', 'patients')
        # fields = "__all__"


class MedicationSerializer(serializers.ModelSerializer):
    dentist_id = serializers.IntegerField(write_only=True)
    med_name = serializers.CharField(max_length=50)
    med_active_subst = serializers.CharField(max_length=50)
    med_price = serializers.IntegerField()
    med_usage = serializers.CharField(max_length=50)
    med_expiration_date = serializers.CharField(max_length=10)

    dentist = DentistSerializer(read_only=True)
    avg_age = serializers.FloatField(read_only=True)
    number_other_dentists = serializers.IntegerField(read_only=True)

    def validate_dentist_id(self, value):
        filter = Dentist.objects.filter(id=value)
        if not filter.exists():
            raise serializers.ValidationError("Dentist does not exist!")
        return value

    class Meta:
        model = Medication
        fields = ('id', 'med_name', 'med_active_subst', 'med_price', 'med_usage', 'med_expiration_date', 'dentist_id', 'dentist', 'avg_age', 'number_other_dentists')


class MedicationDentistSerializer(serializers.ModelSerializer):
    class Meta:
        model = MedicationDentist
        fields = "__all__"

    def validate_medication_id(self, value):
        filter = Medication.objects.filter(id=value)
        if not filter.exists():
            raise serializers.ValidationError("Medication does not exist!")
        return value

    def validate_dentist_id(self, value):
        filter = Dentist.objects.filter(id=value)
        if not filter.exists():
            raise serializers.ValidationError("Dentist does not exist!")
        return value


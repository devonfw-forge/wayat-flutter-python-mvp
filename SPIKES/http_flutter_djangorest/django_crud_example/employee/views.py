from employee.models import Employee
from employee.serializers import EmployeeSerializer
from rest_framework import viewsets

class Employee(viewsets.ModelViewSet):
    queryset = Employee.objects.all()
    serializer_class = EmployeeSerializer
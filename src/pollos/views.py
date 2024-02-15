from django.shortcuts import render
from django.http import HttpResponse


# def index(request):
#     return HttpResponse("G'day mate")

def index(request):
    return render(request, "index.html")
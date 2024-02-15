from django.urls import path

from . import views

app_name = "pollos"

urlpatterns = [
    path("", views.index, name="index"),
]
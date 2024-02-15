from django.urls import path
from . import views

app_name = "authentication"

urlpatterns = [
    path('', views.index , name='index'),
    # path('register', views.register, name='register' ),
    # path('custom',views.custom , name= 'custom'),
    # path('home',views.home , name= 'home'),
    
]
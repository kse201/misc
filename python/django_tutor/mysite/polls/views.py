from django.http import HttpResponse


def index(requeset) -> HttpResponse:
    return HttpResponse("Hello world")

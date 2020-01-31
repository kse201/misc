import datetime

from django.test import TestCase

from django.test import TestCase
from django.utils import timezone

from .models import Question

class QuestionModelTests(TestCase):
    def tet_was_published_recently_with_future_question(self):
        thime = timezone.now() + date

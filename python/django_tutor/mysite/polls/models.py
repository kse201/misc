import datetime

from django.utils import timezone
from django.db import models


class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_data = models.DateTimeField('data published')

    def __str__(self):
        return self.question_text

    def was_published_recently(self):
        return self.pub_data > timezone.now() - datetime.timedelta(days=1)


class Choise(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choise_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)

    def __str__(self):
        return self.choise_text

from django.db import models
from django.utils.crypto import get_random_string
from django.contrib.auth.models import User


random_string = get_random_string(16)
class Article(models.Model):
    hash = models.CharField(max_length=16, default=random_string)
    context = models.CharField(max_length=50)
    father = models.ForeignKey(Article, null=True)
    date = models.DateField(auto_now_add=True, null=True)


class Writer(User):
    class Meta:
        proxy = True
    queue = models.ManyToManyField('Article', related_name='unread')
    star = models.ManyToManyField('Article', related_name='stared')

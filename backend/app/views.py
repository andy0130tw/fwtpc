import json

from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.core import serializers
from django import http

from app.models import Article



@csrf_exempt
def send(request):
    data = json.loads(request.body.decode())
    try:
        context = data.get('context')
    except:
        return http.HttpResponseBadRequest('error context')
    article = Article(context=context, father=None)
    article.save()
    return http.JsonResponse({"status": "success"})


def get(request):
    articles = []
    for article in request.user.queue.all():
        articles.append({
            "id": article.hash,
            "context": article.context,
            "date": article.date,
            })
    return http.JsonResponse({"list": articles})

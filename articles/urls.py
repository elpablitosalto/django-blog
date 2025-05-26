from django.urls import path
from .views import (
    ArticleListView, ArticleDetailView, ArticleCreateView, ArticleUpdateView, ArticleDeleteView, signup
)

urlpatterns = [
    path('', ArticleListView.as_view(), name='article-list'),
    path('article/<int:pk>/', ArticleDetailView.as_view(), name='article-detail'),
    path('article/new/', ArticleCreateView.as_view(), name='article-create'),
    path('article/<int:pk>/edit/', ArticleUpdateView.as_view(), name='article-update'),
    path('article/<int:pk>/delete/', ArticleDeleteView.as_view(), name='article-delete'),
    path('accounts/signup/', signup, name='signup'),
] 
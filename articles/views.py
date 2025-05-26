from django.shortcuts import render
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.urls import reverse_lazy
from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from .models import Article
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import redirect

# Create your views here.

class ArticleListView(ListView):
    model = Article
    template_name = 'articles/article_list.html'
    context_object_name = 'articles'
    ordering = ['-created_at']

class ArticleDetailView(DetailView):
    model = Article
    template_name = 'articles/article_detail.html'
    context_object_name = 'article'

class ArticleCreateView(LoginRequiredMixin, CreateView):
    model = Article
    fields = ['title', 'content']
    template_name = 'articles/article_form.html'
    success_url = reverse_lazy('article-list')

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)

class ArticleUpdateView(LoginRequiredMixin, UserPassesTestMixin, UpdateView):
    model = Article
    fields = ['title', 'content']
    template_name = 'articles/article_form.html'
    success_url = reverse_lazy('article-list')

    def test_func(self):
        article = self.get_object()
        return self.request.user == article.author

class ArticleDeleteView(LoginRequiredMixin, UserPassesTestMixin, DeleteView):
    model = Article
    template_name = 'articles/article_confirm_delete.html'
    success_url = reverse_lazy('article-list')

    def test_func(self):
        article = self.get_object()
        return self.request.user == article.author

def signup(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')
    else:
        form = UserCreationForm()
    return render(request, 'registration/signup.html', {'form': form})

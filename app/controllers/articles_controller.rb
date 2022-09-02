class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: %i[ show edit update destroy ]

  
  def index
    @articles = current_user.articles
  end

  def show 
  end

  def new
    @article= current_user.articles.build
  end

  def create
    @article= current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = "Article was created successfully."
      redirect_to @article 

    else
    render "new"
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end

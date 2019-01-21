class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :update, :purchase]
	
	def index
		#if the parameter "all" is set to false, only select those with count higher than zero
		if params[:instock] == "true"
			@articles = Article.where("inventory_count > ?",0)
		else
			@articles = Article.all
		end
		json_response(@articles)
	end

	def purchase
		if(@article.inventory_count > 0)
			@article.inventory_count = @article.inventory_count-1
			@article.save
			json_response(@article)
		else
			json_response("{Error: article is not in stock}")
		end
	end

	#Use this to create an article
	def create
		@article = Article.create!(article_params)
		json_response(@article, :created)
	end

	def show
		json_response(@article)
	end

	def update
		@article.update(article_params)
		head :no_content
	end

	private

	def article_params
		params.permit(:title, :price, :inventory_count)
	end

	def set_article
		@article = Article.find(params[:id])
	end
end

# README

Simple shop api for the Shopify Summer 2019 Developer Intern Challenge.
I've never used Ruby on rails yet, so needed a few tutorials. Even with those tutorials, I was not able to get the shopping cart part working.

#### Tutorials used :
1. [Build a restful api with rails 5 with Austin Kabiru ](https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one)
2. [Github shopping cart example from RichIsOnRails](https://github.com/RichIsOnRails/ShoppingCartExampleApp)

#### How to use the api :
I've used httpie.
###### Purchasing an item using the id parameter
```bash
$ http GET :3000/purchase?id=0
```

###### Creating an item 
```bash
$ http POST :3000/articles title=chipsVinegar price=2.50 inventory_count=10
```

###### Getting all items no matter what the inventory count is
```bash
$ http GET :3000/articles
```

###### Getting only the items where inventory count is higher than zero
```bash
$ http GET :3000/articles?instock=true
```

###### Modifying an article data (for debugging purposes)
```bash
$ http PUT :3000/articles/1 title=banana price=0.50 inventory_count=2000
```

#### Important pieces of code :
I have modified a bit of the index function of the Article basic controller to check for a passed argument (:instock) :
```ruby
#app/controllers/articles_controller.rb
def index
		if params[:instock] == "true"
			@articles = Article.where("inventory_count > ?",0)
		else
			@articles = Article.all
		end
		json_response(@articles)
	end
```

Also defined a purchase function to manage the decrement of inventory_count and checking if the article is currently in stock :
```ruby
#app/controllers/articles_controller.rb
    def purchase
		if(@article.inventory_count > 0)
			@article.inventory_count = @article.inventory_count-1
			@article.save
			json_response(@article)
		else
			json_response("{Error: article is not in stock}")
		end
	end

```

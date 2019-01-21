require 'rails_helper'

RSpec.describe 'Article API', type: :request do

	let!(:articles) { create_list(:article, 10) }
	let(:article_id) {articles.first.id }

	describe 'GET /articles' do
		before { get '/articles' }

		it 'return articles' do
			expect(json).not_to be_empty
			expect(json.size).to eq(10)
		end

		it 'returns status code 200' do 
			expect(response).to have_http_status(200)
		end
	end

	describe 'GET /articles/:id' do
		before {get "/articles/#{article_id}" }

		context 'when the article exists' do
			it 'returns the article' do
				expect(json).not_to be_empty
				expect(json['id']).to eq(article_id)
			end

			it 'returns status code 200' do 
				expect(response).to have_http_status(200)
			end
		end

		context 'when the record does not exist' do
			let(:article_id) { 100 }

			it 'returns status code 404' do 
				expect(response).to have_http_status(404)
			end

			it 'returns a not found message' do 
				expect(response.body).to match(/Couldn't find Article with/)
			end
		end
	end


	describe 'POST /articles' do
		let(:valid_attributes) {{ title: 'learn Elm', price: '10', inventory_count: '10'}}

		context 'when the request is valid' do 
			before { post '/articles', params: valid_attributes}

			it 'creates an article' do 
				expect(json['title']).to eq('learn Elm')
			end

			it 'returns status code 201' do
				expect(response).to have_http_status(201)
			end
		end

		context 'when the request is invalid' do 
			before { post '/articles', params: {title: 'FooBar'}}

			it 'returns status code 422' do 
				expect(response).to have_http_status(422)
			end

			it 'returns a validation failure message' do
				expect(response.body).to match(/Validation failed: Price can't be blank, Inventory count can't be blank/)
			end
		end
	end


	describe 'PUT /articles/:id' do
		let(:valid_attributes) {{title: 'Shopping'}}

		context 'when the record exists' do 
			before {put "/articles/#{article_id}", params: valid_attributes}

			it 'updates the record' do 
				expect(response.body).to be_empty
			end

			it 'return status code 204' do 
				expect(response).to have_http_status(204)
			end
		end
	end 

	describe 'Delete /articles/:id' do 
		before { delete "/articles/#{article_id}"}

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end
	end
end


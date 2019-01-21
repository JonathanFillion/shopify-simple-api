FactoryBot.define do 
	factory :article do
		title { Faker::Lorem.word }
		price { Faker::Number.number(10) }
		inventory_count {Faker::Number.number(10)}
	end
end
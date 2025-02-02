require 'rails_helper'

RSpec.describe "Receipts API", type: 'request' do 
    describe "POST /receipts/process" do 
        describe "sends a receipt and returns an id" do 
            before :each do 
                @receipt_params = {
                    "retailer": "Target",
                    "purchaseDate": "2022-01-01",
                    "purchaseTime": "13:01",
                    "items": [
                      {
                        "shortDescription": "Mountain Dew 12PK",
                        "price": "6.49"
                      },{
                        "shortDescription": "Emils Cheese Pizza",
                        "price": "12.25"
                      },{
                        "shortDescription": "Knorr Creamy Chicken",
                        "price": "1.26"
                      },{
                        "shortDescription": "Doritos Nacho Cheese",
                        "price": "3.35"
                      },{
                        "shortDescription": "   Klarbrunn 12-PK 12 FL OZ  ",
                        "price": "12.00"
                      }
                    ],
                    "total": "35.35"
                  }
                @headers = {"CONTENT_TYPE" => "application/json"}
            end
            
            it "returns a valid response" do 
                post '/receipts/process', headers: @headers, params: JSON.generate(receipt: @receipt_params)
                expect(response).to be_successful
            end 
            
            it "creates a receipt" do 
                post '/receipts/process', headers: @headers, params: JSON.generate(receipt: @receipt_params)
                receipt = Receipt.last
                expect(receipt.retailer).to eq("Target")
                expect(receipt.purchaseDate).to eq("2022-01-01")
                expect(receipt.purchaseTime).to eq("13:01")
                expect(receipt.total).to eq("35.35")
            end 
            
            it "returns an id" do 
                post '/receipts/process', headers: @headers, params: JSON.generate(receipt: @receipt_params)
                receipt = Receipt.last
                res = JSON.parse(response.body)
                expect(res).to be_a(Hash)
                expect(res).to eq({ "id" => "#{receipt.id}"})
            end 
        end 
    end 
    
    describe "GET /receipts/:id/process" do 
        describe "sends a request and returns a 'total' numeric value" do 
            before :each do 
                @receipt_params = {
                    "retailer": "Target",
                    "purchaseDate": "2022-01-01",
                    "purchaseTime": "13:01",
                    "items": [
                      {
                        "shortDescription": "Mountain Dew 12PK",
                        "price": "6.49"
                      },{
                        "shortDescription": "Emils Cheese Pizza",
                        "price": "12.25"
                      },{
                        "shortDescription": "Knorr Creamy Chicken",
                        "price": "1.26"
                      },{
                        "shortDescription": "Doritos Nacho Cheese",
                        "price": "3.35"
                      },{
                        "shortDescription": "   Klarbrunn 12-PK 12 FL OZ  ",
                        "price": "12.00"
                      }
                    ],
                    "total": "35.35"
                  }
                @headers = {"CONTENT_TYPE" => "application/json"}
            end

            it "returns a valid response" do 
                post '/receipts/process', headers: @headers, params: JSON.generate(receipt: @receipt_params)
                receipt = Receipt.last
                get "/receipts/#{receipt.id}/process"
                expect(response).to be_successful
            end
            
            it "returns a total" do
                post '/receipts/process', headers: @headers, params: JSON.generate(receipt: @receipt_params)
                receipt = Receipt.last
                get "/receipts/#{receipt.id}/process"
                res = JSON.parse(response.body)
                expect(res).to be_a(Hash)
                expect(res).to eq({ "points" => 28 })
            end
        end 
    end 
end 
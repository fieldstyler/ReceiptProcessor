require 'rails_helper'

RSpec.describe "Receipts API", type: 'request' do 
    describe "POST /receipts/process" do 
        describe "sends a receipt and returns an id" do 
            before :each do 
                @receipt_params = {
                    "retailer": "Walgreens",
                    "purchaseDate": "2022-01-02",
                    "purchaseTime": "08:13",
                    "total": "2.65",
                    "items": [
                        {"shortDescription": "Pepsi - 12-oz", "price": "1.25"},
                        {"shortDescription": "Dasani", "price": "1.40"}
                    ]
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
                expect(receipt.retailer).to eq("Walgreens")
                expect(receipt.purchaseDate).to eq("2022-01-02")
                expect(receipt.purchaseTime).to eq("08:13")
                expect(receipt.total).to eq("2.65")
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

            it "returns a valid response" do 

            end

            it "returns a total" do

            end
        end 
    end 
end 
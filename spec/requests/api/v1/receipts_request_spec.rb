require 'rails_helper'

describe "Receipts API" do 
    it "sends a receipt" do 
        post '/receipts/process'

        expect(response).to be_successful
    end 
end 
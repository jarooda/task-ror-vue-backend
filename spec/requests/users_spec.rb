require 'rails_helper'

RSpec.describe "Users testing", :type => :request do

  it "success POST /users (create a user)" do
    post "/users", params: { email: "rspec@mail.com", password: "cobarspec" }
    
    expect(json['email']).to eq("rspec@mail.com")
    expect(response).to have_http_status(:success)
  end

  it "failure POST /users (create a user)" do
    post "/users", params: { }
    
    expect(json['error']).to eq("Invalid email or password")
    expect(response).to have_http_status(:bad_request)
  end
  
  it "failure POST /users because email already used (create a user)" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")

    post "/users", params: { email: "rspec@mail.com", password: "cobarspec" }
    
    expect(json['error']).to eq("Email already used")
    expect(response).to have_http_status(:bad_request)
  end

  it "success POST /login" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")

    post "/login", params: { email: "rspec@mail.com", password: "cobarspec" }
    
    expect(json['email']).to eq("rspec@mail.com")
    expect(response).to have_http_status(:success)
  end

  it "failure POST /login" do
    FactoryBot.create(:user, email: "rspec@mail.com", password: "cobarspec")

    post "/login", params: { email: "rspec@mail.com", password: "cobarSPec" }
    
    expect(json['error']).to eq("Email or password is wrong")
    expect(response).to have_http_status(:bad_request)
  end

end
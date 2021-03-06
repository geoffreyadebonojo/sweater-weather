require 'rails_helper'

RSpec.describe "User login" do
  it "POST user" do

    data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    "password_confirmation": "abc123doremi"
    }

    post "/api/v1/users", params: data

    expect(response.status).to eq(201)
    body = JSON.parse(response.body)["data"]
    expect(body["key"]).to eq(User.first.api_key)
    expect(body["message"]).to eq("Successfully created! Here's your key")
    expect(User.last.email).to eq("awesomesauce@gmail.com")
  end

  it "POST user with wrong password" do

    data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    "password_confirmation": "youandme"
    }

    post "/api/v1/users", params: data

    expect(response.status).to eq(400)
    body = JSON.parse(response.body)
    
    expect(body["message"]).to eq("problem occured!")
    expect(User.count).to eq(0)
  end

  it "POST session" do
    data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    }
    user = User.create!(data)

    post "/api/v1/sessions", params: data

    expect(response.status).to eq(200)
    body = JSON.parse(response.body)["data"]
    expect(body["key"]).to eq(user.api_key)
  end

  it "POST session with wrong password" do
    user_data = {
    "email": "awesomesauce@gmail.com",
    "password": "abc123doremi",
    }
    user = User.create!(user_data)
    bad_data = {
    "email": "awesomesauce@gmail.com",
    "password": "wrong_password_dude",
    }
    post "/api/v1/sessions", params: bad_data

    expect(response.status).to eq(400)
    body = JSON.parse(response.body)
    expect(body["key"]).to be_nil
    expect(body["message"]).to eq("something went wrong!")

  end
end

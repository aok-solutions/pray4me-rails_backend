require 'rails_helper'

describe UsersController do
  before :each do
    User.destroy_all
    3.times do
      create :user, username: create_username
    end
  end

  describe 'GET users#index' do
    it 'retrieves all users' do
      get "/users"
      users_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(users_response.length).to eq(3)
    end
  end

  describe 'GET users#show' do
    it 'retrieves user by ID' do
      user = User.last
      get "/users/#{user.id}"
      users_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(users_response['id']).to eq(user.id)
    end

    it 'returns 404 if user not found' do
      get "/users/1"

      expect(response).to be_not_found
    end
  end

  describe 'POST users#create' do
    new_user = {user: {username: "marvin", email: "marvin@android.com"}}

    it 'creates a new user' do
      post "/users", params: new_user
      users_response = JSON.parse(response.body)

      expect(response).to be_created
      expect(users_response['username']).to eq("marvin")
      expect(users_response['email']).to eq("marvin@android.com")
    end

    it 'returns 422 if validation error' do
      last_user = User.last
      post "/users", params: {user: {username: last_user.username, email: last_user.email}}

      expect(response.status).to eq(422)
    end
  end

  describe 'PUT users#update' do
    update_username = {user: {username: "marvin"}}

    it 'updates the user attribute' do
      user = User.last
      put "/users/#{user.id}", params: update_username
      users_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(users_response['username']).to eq("marvin")
    end

    it 'returns 404 if user not found' do
      put "/users/1", params: update_username

      expect(response).to be_not_found
    end

    it 'returns 422 if validation error' do
      last_user = User.last
      user = create :user, username: create_username
      put "/users/#{user.id}", params: {user: {username: last_user.username}}

      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE users#destroy' do
    it 'updates the user attribute' do
      user = User.last
      delete "/users/#{user.id}"

      expect(User.all.count).to eq(2)
    end

    it 'returns 404 if user not found' do
      delete "/users/1"

      expect(response).to be_not_found
      expect(User.all.count).to eq(3)
    end
  end


  def create_username
    Faker::HitchhikersGuideToTheGalaxy.unique.character.delete(" ").underscore
  end
end
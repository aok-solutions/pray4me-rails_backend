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
      get :index
      users_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(users_response.length).to eq(3)
    end
  end

  describe 'GET users#show' do
    it 'retrieves user by ID' do
      user = User.last
      get :show, params: {id: user.id}
      users_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(users_response['id']).to eq(user.id)
    end

    it 'returns 404 if user not found' do
      get :show, params: {id: "invalid"}

      expect(response).to be_not_found
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'GET users#prayer_requests' do
    it 'retrieves users prayer requests' do
      user = User.last
      create :prayer_request, user_id: user.id
      get :prayer_requests, params: {id: user.id}

      prayer_request_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(response.content_type).to eq('application/json')
      expect(prayer_request_response.length).to eq(1)
    end

    it 'returns 404 if user not found' do
      get :prayer_requests, params: {id: "invalid"}

      expect(response).to be_not_found
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'POST users#create' do
    new_user = {user: {username: "marvin", email: "marvin@android.com"}}

    it 'creates a new user' do
      post :create, params: new_user
      users_response = JSON.parse(response.body)

      expect(response).to be_created
      expect(users_response['username']).to eq("marvin")
      expect(users_response['email']).to eq("marvin@android.com")
    end

    it 'returns 422 if validation error' do
      last_user = User.last
      post :create, params: {user: {username: last_user.username, email: last_user.email}}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'PUT users#update' do
    it 'updates the user attribute' do
      user = User.last
      put :update, params: {id: user.id, user: {username: "marvin"}}
      users_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(users_response['username']).to eq("marvin")
    end

    it 'returns 404 if user not found' do
      put :update, params: {id: "invalid", user: {username: "marvin"}}

      expect(response).to be_not_found
      expect(response.content_type).to eq('application/json')
    end

    it 'returns 422 if validation error' do
      last_user = User.last
      user = create :user, username: create_username
      put :update, params: {id: user.id, user: {username: last_user.username}}

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'DELETE users#destroy' do
    it 'deletes the user' do
      user = User.last
      delete :destroy, params: {id: user.id}

      expect(User.all.count).to eq(2)
      expect(User.pluck(:id)).not_to include(user.id)
    end

    it 'returns 404 if user not found' do
      delete :destroy, params: {id: "invalid"}

      expect(response).to be_not_found
      expect(response.content_type).to eq('application/json')
      expect(User.all.count).to eq(3)
    end
  end


  def create_username
    Faker::HitchhikersGuideToTheGalaxy.unique.character.delete(" ").underscore
  end
end
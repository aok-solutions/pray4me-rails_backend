require 'rails_helper'

describe PrayerRequestsController do
  before :each do
    PrayerRequest.destroy_all
    User.destroy_all

    @user = create :user
    3.times do
      create :prayer_request, user_id: @user.id
    end
  end

  describe 'GET prayer_requests#index' do
    it 'retrieves all prayer requests' do
      get :index
      prayer_requests_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(prayer_requests_response.length).to eq(3)
    end
  end

  describe 'GET prayer_requests#show' do
    it 'retrieves prayer request by ID' do
      prayer_request = PrayerRequest.last
      get :show, params: {id: prayer_request.id}
      prayer_requests_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(prayer_requests_response['id']).to eq(prayer_request.id)
    end

    it 'returns 404 if prayer request not found' do
      get :show, params: {id: "invalid"}

      expect(response).to be_not_found
    end
  end

  describe 'POST prayer_requests#create' do
    subject = Faker::HitchhikersGuideToTheGalaxy.specie
    description = Faker::HitchhikersGuideToTheGalaxy.quote

    it 'creates a new prayer request' do
      new_prayer_request = {prayer_request: {
          user_id: @user.id,
          subject: subject,
          description: description
      }}

      post :create, params: new_prayer_request
      prayer_requests_response = JSON.parse(response.body)

      expect(response).to be_created
      expect(prayer_requests_response['subject']).to eq(subject)
      expect(prayer_requests_response['description']).to eq(description)
    end

    it 'returns 422 if validation error' do
      post :create, params: {prayer_request: {subject: subject, description: description}}

      expect(response.status).to eq(422)
    end
  end

  describe 'PUT prayer_requests#update' do
    description = Faker::HitchhikersGuideToTheGalaxy.quote
    it 'updates the prayer request attribute' do
      put :update, params: {id: PrayerRequest.last.id, prayer_request: {description: description}}
      prayer_requests_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(prayer_requests_response['description']).to eq(description)
    end

    it 'returns 404 if prayer request not found' do
      put :update, params: {id: "invalid", prayer_request: {description: description}}

      expect(response).to be_not_found
    end

    it 'returns 422 if validation error' do
      put :update, params: {id: PrayerRequest.last.id, prayer_request: {user_id: nil}}

      expect(response.status).to eq(422)
    end
  end

  describe 'DELETE prayer_requests#destroy' do
    it 'deletes the prayer request' do
      prayer_request = PrayerRequest.last
      delete :destroy, params: {id: prayer_request.id}

      expect(PrayerRequest.all.count).to eq(2)
      expect(PrayerRequest.pluck(:id)).not_to include(prayer_request.id)
    end

    it 'returns 404 if prayer request not found' do
      delete :destroy, params: {id: "invalid"}

      expect(response).to be_not_found
      expect(PrayerRequest.all.count).to eq(3)
    end
  end
end
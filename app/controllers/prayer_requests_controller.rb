class PrayerRequestsController < ApplicationController
  before_action :set_prayer_request, only: [:show, :update, :destroy]

  # GET /prayer_requests
  def index
    @prayer_requests = PrayerRequest.all

    render json: @prayer_requests
  end

  # GET /prayer_requests/1
  def show
    render json: @prayer_request
  end

  # POST /prayer_requests
  def create
    @prayer_request = PrayerRequest.new(prayer_request_params)

    if @prayer_request.save
      render json: @prayer_request, status: :created, location: @prayer_request
    else
      render json: @prayer_request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /prayer_requests/1
  def update
    if @prayer_request.update(prayer_request_params)
      render json: @prayer_request
    else
      render json: @prayer_request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /prayer_requests/1
  def destroy
    @prayer_request.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prayer_request
      @prayer_request = PrayerRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def prayer_request_params
      params.require(:prayer_request).permit(:user_id, :subject, :description)
    end
end

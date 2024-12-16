class ForecastsController < ApplicationController
  before_action :redirect_to_root, :if => :invalid_address?, only: [:show]

  def lookup
  end
  # Takes an address parameter 
  # Send weather data in case of successful api execution
  def show
      @address = params[:address]
      begin
        location = GeocodeService.call(params["address"])
        @weather_data = WeatherForecastService.call(location, {"units" => "metric"})
      rescue StandardError => e
        flash[:error] = e.message
        redirect_to root_path
      end
  end

  private
  def redirect_to_root
    flash[:error] = "Please enter full address with street, city, state, country"
    redirect_to root_path
  end

  def invalid_address?
    params[:address].empty?
  end

end
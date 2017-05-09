module Api
  class GeolocationsController < ApiController
    # TODO: Implement proper caching mechanism based on `updated_at` attribute
    # and `stale?` Rails method to improve performance
    def show
      if geolocation
        render json: { geolocation: geolocation }.to_json
      else
        render json: { error: "Geolocation with IP #{ params[:id] } does not exist." }, status: 404
      end
    end

    private

    def geolocation
      @geolocation ||= GeoImporter::Models::Geolocation.find(ip_address: params[:id])
    end
  end
end

require 'rails_helper'

describe GeocodeService do
  it "Gets JSON Data" do
    VCR.use_cassette("vcr_geocode_results") do
      service = GeocodeService.new("Dallas, TX")
      expect(service).to be_an_instance_of(GeocodeService)
      expect(service.lat_lng).to be_a(Hash)
      #TODO: test for specific information
      
    end
  end
end

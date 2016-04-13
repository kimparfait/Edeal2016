def index
    if params[:location].blank?
    @listings = Location.all.order("created_at DESC")
  else 
    @location_id = Location.find_by(name: params[:location]).id
    @listings = Listing.where(:location_id => @location_id).order("created_at DESC")
  end
end
 
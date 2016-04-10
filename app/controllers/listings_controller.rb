class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy,:upvote]
   before_filter :authenticate_user!, only: [ :seller, :new, :create, :edit, :update, :destroy, :upvote]
   before_filter :check_user, only: [:edit, :update, :destroy]
  impressionist actions: [:show], unique: [:session_hash]
  
  def search
    if params[:search].present?
      @listings= Listing.search(params[:search])
    else
      @listings = Listing.all
    end
  end

 def seller
      @listings = Listing.where(user: current_user).order("created_at DESC")

 
  end 
  # GET /listings
  # GET /listings.json
  def index


  @listings = Listing.limit(20).order("created_at DESC")

      

  if params[:category].present?
    category_id = Category.find_by(name: params[:category]).try(:id)
    @listings = @listings.where(category_id: category_id) if category_id
  end

  if params[:location].present?
    location_id = Location.find_by(name: params[:location]).try(:id)
    @listings = @listings.where(location_id: location_id) if location_id
  end
   
 
end
 

  # GET /listings/1
  # GET /listings/1.json
  def show
      if @listing.reviews.blank?
      @average_review = 0
    else
      @average_review = @listing.reviews.average(:rating).round(2)
    end

     @listings = Listing.find(params[:id])
  impressionist(@listings)
  end

  # GET /listings/new
  def new
    @listing = Listing.new
    @categories = Category.all.map{|c| [c.name, c.id]}
    @locations= Location.all.map{|c| [c.name, c.id]}
  end 

  # GET /listings/1/edit
  def edit
     @categories = Category.all.map{|c| [c.name, c.id]}
      @locations= Location.all.map{|c| [c.name, c.id]}
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.category_id = params[:category_id]
     
    @listing.user_id = current_user.id


    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      @listing.category_id = params[:category_id]
        @listing.location_id = params[:location_id]

      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def upvote 
    @listing.upvote_by current_user
    redirect_to :back

  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image, :address, :phone, :category_id, :location_id)
    end
    def check_user
       if current_user != @listing.user
          redirect_to root_url, alert: "Sorry, this ads belongs to someone else"
    end 
    end 
end
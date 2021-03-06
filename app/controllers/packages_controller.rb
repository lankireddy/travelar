class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:search_packages]


  # GET /packages
  # GET /packages.json
  def search_packages
    #binding.pry
    if params[:from].present? && params[:to].present?
      @package = Package.where(starting_city: params[:from]).where(trip_to: params[:to])      
    elsif params[:to].present?
      @package = Package.where(trip_to: params[:to])
    elsif params[:from].present?
      @package = Package.where(starting_city: params[:from])
    end
  end
  def index
    #binding.pry
   # if current_user.agents.packages
    #  @packages = current_user.agents.packages
    #end
  @packages = Package.paginate(page: params[:page], per_page: 10)
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
     #binding.pry
    @agency = Agency.find(params[:id])
    @package = @agency.packages.new
  
  end

  # GET /packages/1/edit
  def edit
   # binding.pry
  end

  # POST /packages
  # POST /packages.json
  def create
    #binding.pry
    @package = Package.new(package_params)

    respond_to do |format|
      if @package.save
        #current_user.agent.packages << @package
        format.html { redirect_to @package, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
   # binding.pry
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url(:agency_id=>params[:agency_id]), notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name, :price, :image,:trip_to, :duration, :agency_id, :starting_city,:journey_date, :ticket_no)
    end
end

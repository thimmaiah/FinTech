class InterestsController < ApplicationController
  load_and_authorize_resource :except => ["index"]
  
  # GET /interests or /interests.json
  def index
    @interests = Interest.all
  end

  # GET /interests/1 or /interests/1.json
  def show; end

  # GET /interests/new
  def new
    @interest = Interest.new(company_id:params[:company_id])
  end

  # GET /interests/1/edit
  def edit; end

  # POST /interests or /interests.json
  def create
    @interest = Interest.new(interest_params)
    @interest.user = current_user
    

    respond_to do |format|
      if @interest.save
        format.html { redirect_to interest_url(@interest), notice: "Interest was successfully created." }
        format.json { render :show, status: :created, location: @interest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interests/1 or /interests/1.json
  def update
    respond_to do |format|
      if @interest.update(interest_params)
        format.html { redirect_to interest_url(@interest), notice: "Interest was successfully updated." }
        format.json { render :show, status: :ok, location: @interest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interests/1 or /interests/1.json
  def destroy
    @interest.destroy

    respond_to do |format|
      format.html { redirect_to interests_url, notice: "Interest was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_interest
    @interest = Interest.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def interest_params
    params.require(:interest).permit(:side, :share_type, :shares_min, :shares_max, 
                          :price_per_share, :company_id)
  end
end

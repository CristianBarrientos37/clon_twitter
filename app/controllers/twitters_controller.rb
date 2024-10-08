class TwittersController < ApplicationController
  before_action :set_twitter, only: %i[ show edit update destroy ]

  # GET /twitters or /twitters.json
  
  def index
    @pagy, @twitters = pagy(Twitter.order(created_at: :desc))

    if params[:query_text].present?
      @twitters = @twitters.search_full_text(params[:query_text])
    end
  end

  # GET /twitters/1 or /twitters/1.json
  def show
  end

  # GET /twitters/new
  def new
    @twitter = Twitter.new
  end

  # GET /twitters/1/edit
  def edit
  end

  def preview
  end

  def search
  end

  # POST /twitters or /twitters.json
  def create
    @twitter = Twitter.new(twitter_params)

    respond_to do |format|
      if @twitter.save
        format.html { redirect_to @twitter, notice: "Twitter was successfully created." }
        format.json { render :show, status: :created, location: @twitter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @twitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twitters/1 or /twitters/1.json
  def update
    respond_to do |format|
      if @twitter.update(twitter_params)
        format.html { redirect_to @twitter, notice: "Twitter was successfully updated." }
        format.json { render :show, status: :ok, location: @twitter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @twitter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twitters/1 or /twitters/1.json
  def destroy
    @twitter.destroy!

    respond_to do |format|
      format.html { redirect_to twitters_path, status: :see_other, notice: "Twitter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitter
      @twitter = Twitter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def twitter_params
      params.require(:twitter).permit(:description, :username)
    end
end

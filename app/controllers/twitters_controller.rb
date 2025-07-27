class TwittersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_twitter, only: %i[ show edit update destroy ]
  before_action :check_owner, only: %i[ edit update destroy ]

  # GET /twitters or /twitters.json
  def index
    @twitters = Twitter.public_tweets.recent
    
    if params[:query_text].present?
      @twitters = @twitters.search_full_text(params[:query_text])
    end
    
    @pagy, @twitters = pagy(@twitters)
  end

  # GET /twitters/1 or /twitters/1.json
  def show
  end

  # GET /twitters/new
  def new
    @twitter = current_user.twitters.build
  end

  # GET /twitters/1/edit
  def edit
  end

  def preview
  end

  def search
    @twitters = Twitter.public_tweets.recent
    
    if params[:query_text].present?
      @twitters = @twitters.search_full_text(params[:query_text])
    end
    
    @pagy, @twitters = pagy(@twitters)
    render :index
  end

  # POST /twitters or /twitters.json
  def create
    @twitter = current_user.twitters.build(twitter_params)

    respond_to do |format|
      if @twitter.save
        format.html { redirect_to @twitter, notice: "Tweet creado exitosamente!" }
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
        format.html { redirect_to @twitter, notice: "Tweet actualizado exitosamente!" }
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
      format.html { redirect_to twitters_path, status: :see_other, notice: "Tweet eliminado exitosamente!" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitter
      @twitter = Twitter.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to twitters_path, alert: "Tweet no encontrado."
    end

    # Check if current user owns the twitter
    def check_owner
      unless @twitter.user == current_user
        redirect_to twitters_path, alert: "No tienes permiso para realizar esta acción."
      end
    end

    # Only allow a list of trusted parameters through.
    def twitter_params
      params.require(:twitter).permit(:description)
    end
end

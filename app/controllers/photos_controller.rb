class PhotosController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_photo, only: [:show, :edit, :update, :destroy]


  # GET /post_attachments
  # GET /post_attachments.json
  def index
    @photos = Photo.all
  end

  # GET /post_attachments/1
  # GET /post_attachments/1.json
  def show
  end

  # GET /post_attachments/new
  def new
    @photo = Photo.new
  end

  # GET /post_attachments/1/edit
  def edit
  end

  # POST /post_attachments
  # POST /post_attachments.json
  def create
    @photo = Photo.new(photo_params)
    @photo.order = Photo.where({:album_id => photo_params[:album_id]}).maximum(:order) + 1 || 1

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo successfully added.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_attachments/1
  # PATCH/PUT /post_attachments/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo.post, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_attachments/1
  # DELETE /post_attachments/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photo_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:album_id, :picture)
    end
end

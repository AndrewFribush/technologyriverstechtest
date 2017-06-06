class AlbumsController < ApplicationController
    load_and_authorize_resource
    skip_authorize_resource :only => :reorder
    before_action :authenticate_user!
    before_action :set_album, only: [:show, :edit, :update, :destroy]

    # GET /posts
    # GET /posts.json
    def index
      @albums = Album.all.order(:order)
    end

    def reorder
      params[:order].each do |a, v|
        Album.update(a.to_i, {:order => v.to_i})
      end
      render json: {
        status: :ok
      }
    end

    # GET /posts/1
    # GET /posts/1.json
    def show
      @album_attachments = @album.photos.all
    end

    def new
     @album = Album.new
     @album_attachment = @album.photos.build
    end

    # GET /posts/1/edit
    def edit
    end

    # POST /posts
    # POST /posts.json
    def create
     @album = Album.new(album_params);
     @album.order = Album.maximum(:order).to_i + 1

      respond_to do |format|
        if @album.save
          params[:photo]['picture'].each do |a|
            order =
            @photo = @album.photos.create!(:picture => a, :album_id => @album.id, :order => Photo.where({:album_id => @album.id}).maximum(:order).to_i + 1)
          end
         format.html { redirect_to @album, notice: 'Album was successfully created.' }
        else
         format.html { render action: 'new' }
        end
      end
    end

    # PATCH/PUT /posts/1
    # PATCH/PUT /posts/1.json
    def update
      respond_to do |format|
        if @album.update(album_params)
          format.html { redirect_to @album, notice: 'Album was successfully updated.' }
          format.json { render :show, status: :ok, location: @album }
        else
          format.html { render :edit }
          format.json { render json: @album.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /posts/1
    # DELETE /posts/1.json
    def destroy
      @album.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Album was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_album
        @album = Album.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def album_params
        params.require(:album).permit(:title)
      end
end

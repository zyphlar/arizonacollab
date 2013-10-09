class SpacesController < ApplicationController
  before_action :set_space, only: [:show, :edit, :update, :destroy]

  # GET /spaces
  # GET /spaces.json
  def index
    @spaces = Space.all

    # Index, downcase, and capitalize the categories
    dot_index = 0
    @spaces.group_by{|s| s.category.downcase}.each do |group|
      dot_color = Space.dot_colors[dot_index]
      group.last.each do |space|
        space.category = group.first.capitalize
        space.dot_color = dot_color
      end
      dot_index += 1
    end

    # Don't bother with generating markers for JSON
    respond_to do |format|
      format.html {

        @json = @spaces.to_gmaps4rails do |space, marker|
          marker.infowindow render_to_string(:partial => "/spaces/marker", :locals => { :space => space})
          marker.picture({
                          :picture => "http://maps.google.com/intl/en_us/mapfiles/ms/micons/#{space.dot_color}-dot.png",
                          :width   => 32,
                          :height  => 32
                         })
          marker.title   space.name
          marker.json({ :id => space.id })
        end
      }
      format.json #render json
    end
  end

  # GET /spaces/1
  # GET /spaces/1.json
  def show
  end

  # GET /spaces/new
  def new
    @space = Space.new
  end

  # GET /spaces/1/edit
  def edit
  end

  # POST /spaces
  # POST /spaces.json
  def create
    @space = Space.new(space_params)

    respond_to do |format|
      if @space.save
        format.html { redirect_to @space, notice: 'Space was successfully created.' }
        format.json { render action: 'show', status: :created, location: @space }
      else
        format.html { render action: 'new' }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spaces/1
  # PATCH/PUT /spaces/1.json
  def update
    respond_to do |format|
      if @space.update(space_params)
        format.html { redirect_to @space, notice: 'Space was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @space.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spaces/1
  # DELETE /spaces/1.json
  def destroy
    @space.destroy
    respond_to do |format|
      format.html { redirect_to spaces_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_space
      @space = Space.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def space_params
      params.require(:space).permit(:name, :category, :address, :city, :state, :hours, :phone, :email, :website, :description)
    end
end

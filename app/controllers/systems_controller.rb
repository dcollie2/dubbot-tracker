class SystemsController < ApplicationController
  before_action :set_system, only: %i[ show edit update destroy ]

  # GET /systems or /systems.json
  def index
    @systems = System.all.sort_by {|s| s.current_overall_score }.reverse
  end

  # GET /systems/1 or /systems/1.json
  def show
  end

  # GET /systems/new
  def new
    @system = System.new
  end

  # GET /systems/1/edit
  def edit
  end

  # POST /systems or /systems.json
  def create
    @system = System.new(system_params)

    respond_to do |format|
      if @system.save
        format.html { redirect_to system_url(@system), notice: "System was successfully created." }
        format.json { render :show, status: :created, location: @system }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /systems/1 or /systems/1.json
  def update
    respond_to do |format|
      if @system.update(system_params)
        format.html { redirect_to system_url(@system), notice: "System was successfully updated." }
        format.json { render :show, status: :ok, location: @system }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /systems/1 or /systems/1.json
  def destroy
    @system.destroy

    respond_to do |format|
      format.html { redirect_to systems_url, notice: "System was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system
      @system = System.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def system_params
      params.require(:system).permit(:name, :notes)
    end
end

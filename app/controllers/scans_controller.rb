class ScansController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show list ]
  before_action :set_scan, only: %i[ show edit update destroy ]
  before_action :system_check, only: :list
  require 'csv'
  # GET /scans or /scans.json
  def index
  end

  def list
    column = params[:column] == 'site_name' ? 'sites.name' : params[:column]
    # this all seems super dangerous; should cleanse column & direction
    scans = Scan.joins(:site).most_recent.order(:size_group).order("#{column} #{params[:direction]}")
    scans = scans.in_system(@system.id) if @system.present?
    render(partial: 'scans', locals: { scans: scans })
  end


  # GET /scans/1 or /scans/1.json
  def show
  end

  # GET /scans/new
  def new
    @scan = Scan.new
  end

  # GET /scans/1/edit
  def edit
  end

  # POST /scans or /scans.json
  def create
    @scan = Scan.new(scan_params)

    respond_to do |format|
      if @scan.save
        format.html { redirect_to scan_url(@scan), notice: "Scan was successfully created." }
        format.json { render :show, status: :created, location: @scan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  def import_csv
    if params[:scan_file].present?
      scans = []
      file = params[:scan_file]
      CSV.foreach(file, headers: true) do |row|
        scans << row.to_h
        if row['Name'] == 'CHSS - College of Humanities and Social Sciences'
          puts row.to_h
          puts "batch_number, pages: #{row['Pages']}, overall_score: #{row['Overall Score']}, accessibility_issues: scan['Accessibility Issues'], broken_links: scan['Broken Links'], misspellings: scan['Misspellings'], flagged_words: scan['Flagged Words'])"
        end
      end
      Scan.import_scans(scans)
      redirect_to scans_path, notice: "File uploaded"
    else
      redirect_to scans_path, notice: "You must upload a suitable CSV file."
    end
  end

  # PATCH/PUT /scans/1 or /scans/1.json
  def update
    respond_to do |format|
      if @scan.update(scan_params)
        format.html { redirect_to scan_url(@scan), notice: "Scan was successfully updated." }
        format.json { render :show, status: :ok, location: @scan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scans/1 or /scans/1.json
  def destroy
    @scan.destroy

    respond_to do |format|
      format.html { redirect_to scans_url, notice: "Scan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_scan
    @scan = Scan.find(params[:id])
  end

  def system_check
    logger.debug("SYSTEM CHECK RUNNING--#{params[:system_id]}--")
    @system = System.find(params[:system_id]) if params[:system_id].present?
    logger.debug(@system.present?)
  end

  # Only allow a list of trusted parameters through.
  def scan_params
    params.require(:scan).permit(:pages, :overall_score, :broken_links, :accessibility_issues, :misspellings, :flagged_words, :last_crawled_on, :site_id)
  end
end

require 'digest'
require 'uri'

class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_account!
  after_action :save_temporary_path, only: [:create, :update]

  # GET /repositories
  # GET /repositories.json
  def index
    @repositories = Repository.all
  end

  # GET /repositories/1
  # GET /repositories/1.json
  def show
    user = @repository.username
    repo = @repository.repository_name
    temp_path = @repository.temporary_path

    system("git clone https://github.com/#{user}/#{repo} /#{temp_path}") unless File.exist? temp_path

    relative_path = params[:current_path].present? ? params[:current_path] : ""
    @current_path = "/#{temp_path}/#{URI.unescape(relative_path)}"
  end

  # GET /repositories/new
  def new
    @repository = current_account.repositories.build
  end

  # GET /repositories/1/edit
  def edit
  end

  # POST /repositories
  # POST /repositories.json
  def create
    @repository = current_account.repositories.new(repository_params)

    respond_to do |format|
      if @repository.save
        format.html { redirect_to repositories_url, notice: 'Repository was successfully created.' }
        format.json { render :show, status: :created, location: @repository }
      else
        format.html { render :new }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repositories/1
  # PATCH/PUT /repositories/1.json
  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to repositories_url, notice: 'Repository was successfully updated.' }
        format.json { render :show, status: :ok, location: @repository }
      else
        format.html { render :edit }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repositories/1
  # DELETE /repositories/1.json
  def destroy
    @repository.destroy
    respond_to do |format|
      format.html { redirect_to repositories_url, notice: 'Repository was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      @repository = Repository.find_by(temporary_path: params[:temporary_path])
    end

    def save_temporary_path
      path = @repository.username + "/" + @repository.repository_name
      temp_path = "tmp/#{@repository.repository_name}-#{Digest::SHA2.hexdigest(path)}"
      @repository.temporary_path = temp_path
      @repository.save
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repository_params
      params.require(:repository).permit(:username, :repository_name, :account_id)
    end
end

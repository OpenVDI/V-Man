class TemplatesController < ApplicationController

  filter_access_to :all

  # GET /templates
  def index
    @templates = Template.all

    respond_with @templates
  end

  # GET /templates/1
  def show
    @template = Template.find(params[:id])

    respond_with @template
  end

  # GET /templates/new
  def new
    @template = Template.new

    respond_with @template
  end

  # GET /templates/1/edit
  def edit
    @template = Template.find(params[:id])
  end

  # POST /templates
  def create
    @template = Template.new(params[:template])
    flash[:notice] = 'Template was successfully created.' if @template.save

    respond_with @template
  end

  # PUT /templates/1
  def update
    @template = Template.find(params[:id])
    flash[:notice] = 'Template was successfully updated.' if @template.update_attributes(params[:template])

    respond_with @template
  end

  # DELETE /templates/1
  def destroy
    @template = Template.destroy(params[:id])

    respond_with @template
  end

end

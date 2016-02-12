class MenuCategoriesController < ApplicationController
  before_action :set_menu_category, only: [:show, :edit, :update, :destroy]

  # GET /menu_categorys
  # GET /menu_categorys.json
  def index
    @menu_categories = MenuCategory.all
    @menu_category = MenuCategory.new
  end

  # GET /menu_categorys/1
  # GET /menu_categorys/1.json
  def show
  end

  # GET /menu_categorys/new
  def new
    @menu_category = MenuCategory.new
  end

  # GET /menu_categorys/1/edit
  def edit
  end

  # POST /menu_categorys
  # POST /menu_categorys.json
  def create
    @menu_category = MenuCategory.new(menu_category_params)
    @menu_category.save
    @menu_categories = MenuCategory.all
  end

  # PATCH/PUT /menu_categorys/1
  # PATCH/PUT /menu_categorys/1.json
  def update
    @menu_category.update(menu_category_params)
    @menu_categories = MenuCategory.all
  end

  # DELETE /menu_categorys/1
  # DELETE /menu_categorys/1.json
  def destroy
    @menu_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_category
      @menu_category = MenuCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_category_params
      params.require(:menu_category).permit(:name, :image)
    end
end

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  #protect_from_forgery except: [:create, :delete]
  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @reviews = @product.reviews.page(params[:page]).per(3).order(created_at: 'DESC')
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: I18n.t('products.success.create') }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: I18n.t('products.success.update') }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: I18n.t('products.success.destroy') }
      format.json { head :no_content }
    end
  end

  # DOWNLOAD /products/download/1?filename=
  def download
    # [vulnerability]: Directory traversal
    # [Safe pattern]:
    # filePath = Rails.root.join('app', 'assets', 'images', params[:filename].gsub(/[\/\.;:+\|]/,""))
    filePath = Rails.root.join('app', 'assets', 'images', params[:filename])
    # "app/assets/images/#{params[:filename]}"


    # [vulnerability]: OS Command Injection
    # [Safe pattern]:
    # send_file filePath,
    #  filename: params[:filename],
    #  type: 'image/jpeg'  

    file = `cat #{filePath}`
    send_data file,
      filename: params[:filename],
      type: 'image/jpeg'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :info, :value, :img_path)
    end

end

class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /products
  # GET /products.json
  def index
    # 'desc' atau descending = diurutkan dari yg akhir ke awal. Z - A / paling lama dulu baru ke yg baru
    #  ascending atau ascending = diurutkan dari yg awal ke akhir. A - Z / paling baru dulu baru ke yg lama
<<<<<<< HEAD
    products = Product.all
    products.order('name asc') if params[:urutkan] == "nama" 
    products.order('created_at asc') if params[:urutkan] == "tanggal"
=======
    if params[:urutkan] == "nama" 
      products = Product.order('name asc') 
    elsif params[:urutkan] == "tanggal"
      products = Product.order('created_at desc')
    else
      products = Product.all
    end
>>>>>>> 988b4c0c5dc628156eb296ed01ee357be77c8d64


    @keyword = params[:filter][:name] if params[:filter].present?
    if @keyword.present?
      @products = products.paginate(:page => params[:page], :per_page => 5).where("name LIKE ?", "%#{@keyword}%")
    else
      @products = products.paginate(:page => params[:page], :per_page => 5)
    end

    
  end
  # GET /products/1
  # GET /products/1.json
  def show
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
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
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
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
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
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :image)
    end
end

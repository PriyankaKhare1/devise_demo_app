class LineItemsController < ApplicationController
  # before_action :set_cart
  before_action :set_cart, only: [:create, :decrease, :increase]
  skip_before_action :verify_authenticity_token

	def index
    @line_items = LineItem.all
  end

  def show
  	@line_item = LineItem.find(params[:id])
  end

  def new
    @line_item = LineItem.new
  end

  def edit
  	@line_item = LineItem.find(params[:id])
  end

  def create
    @product = Product.find(params[:product_id])
    @line_item = @cart.add_product(@product)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to unauthenticated_root_path, notice: 'Line item was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @line_item = LineItem.find(params[:id])
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to @cart, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def decrease
    line_item = LineItem.find(params[:id])
    @line_item = @cart.remove_line_item(line_item)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @cart, notice: 'Line item was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { redirect_to cart_path }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def increase
    line_item = LineItem.find(params[:id])
    @line_item = @cart.add_line_item(line_item)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to @cart, notice: 'Line item was successfully updated.' }
        format.js
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { redirect_to cart_path }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def line_item_params
    params.require(:line_item).permit(:product_id)
  end

  
end

class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /items
  # GET /items.json
  def index
    @on_index_page = true
    @items = current_user.items.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = current_user.items.new
  end

  # GET /items/1/edit
  def edit
  end

  def record_sale
    @items = current_user.items.all
  end

  def add_stock
    @items = current_user.items.all
  end

  def update_stock
    current_user.items.update(params[:items].keys, params[:items].values)
    current_user.items.all.each do |i|
      if i.days
        i.days = i.days + 1
      else
        i.days = 1
      end
      i.avg_sales = i.avg_sales + (i.sold_today / i.days)
      i.qty_current = i.qty_current - i.sold_today
      i.qty_sold = i.qty_sold + i.sold_today
      i.save
    end
    flash[:notice] = "Sales added. "
    redirect_to items_url
  end


  def update_purchases
    current_user.items.update(params[:items].keys, params[:items].values)
    current_user.items.all.each do |i|
      i.bought_today ||= 0
      i.qty_current = i.qty_current + i.bought_today
      i.save
    end
    flash[:notice] = "New stock registered. "
    redirect_to items_url
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.items.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'You Successfully added a new Item.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = current_user.items.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :price, :details, :qty_current, :qty_ideal, :sold_today, :qty_sold, :avg_sales, :supplier, :exp_date, :pur_date, :bought_today)
    end
end

class ItemsController < ApplicationController
  include CurrentOrder

  before_action :authenticate_user!

  def index
    @items = Item.all
    @items = Item.search(params[:query]) if params[:query].present?
    @items = @items.order(created_at: :desc)
    @items = @items.select { |item| item.itemable.available? } if current_user&.role == "customer"

    if request.headers["Accept"] == "text/html"
      render partial: "items", locals: { items: @items }, layout: false
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private
end

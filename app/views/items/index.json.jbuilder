json.array!(@items) do |item|
  json.extract! item, :name, :price, :details, :qty_current, :qty_ideal, :qty_sold, :avg_sales, :supplier, :exp_date, :pur_date
  json.url item_url(item, format: :json)
end

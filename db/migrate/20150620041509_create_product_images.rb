class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.integer     :product_id
      t.attachment  :picture
    end
  end
end

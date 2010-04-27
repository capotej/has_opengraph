ActiveRecord::Schema.define(:version => 0) do
  create_table :movies, :force => true do |t|
    t.string :name
    t.string :genre
    t.string :descr
    t.string :cover_image_url
  end
end

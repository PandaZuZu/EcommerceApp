class Product < ActiveRecord::Base
  validates :name,
            :presence => true,
            :format => {
              :multiline => true,
              :with => /^[A-z0-9]+$/
            }

  validates :description,
            :presence => true,
            :format => {
              :multiline => true,
              :with => /^[A-z0-9]+$/
            }

  validates :picture,
            :presence => true

  validates :quantity,
            :presence => true

  validates :price,
            :presence => true
end

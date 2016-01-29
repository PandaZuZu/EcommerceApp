class Product < ActiveRecord::Base
  attr_accessor :pictures
  serialize :pictures

  mount_uploaders :pictures, ThumbsUploader

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

  validates :pictures,
            :presence => true

  validates :quantity,
            :presence => true,
            :numericality => {
              :greater_than_or_equal_to => 0
            }

  validates :price,
            :presence => true,
            :numericality => {
              :greater_than_or_equal_to => 0
            }

end

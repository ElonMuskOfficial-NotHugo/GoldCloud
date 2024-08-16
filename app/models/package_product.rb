class PackageProduct < ApplicationRecord
  belongs_to :package
  belongs_to :product
end

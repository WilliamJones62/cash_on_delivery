class Invheadview < ApplicationRecord
  establish_connection "prod".to_sym
  self.table_name = "invheadview"
end

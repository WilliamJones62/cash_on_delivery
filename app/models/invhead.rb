class Invhead < ApplicationRecord
  establish_connection "prod".to_sym
  self.table_name = "invhead"
end

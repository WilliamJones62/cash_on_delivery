class User < ApplicationRecord
  establish_connection "prod".to_sym
  self.table_name = "zz_users"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
end

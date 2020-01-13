class AddTermsCodeToInvheads < ActiveRecord::Migration[5.1]
  def change
    add_column :invheads, :terms_code, :string
  end
end

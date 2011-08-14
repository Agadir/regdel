class AccountBase < ActiveRecord::Base
  set_table_name "accounts"
  include AccountMethods

end

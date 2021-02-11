class EnableHstore < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
  end
end

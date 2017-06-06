class Role < ActiveRecord::Base
  has_many :users

  def self.types
    ["Global", "Institution", "Program"]
  end

  def self.all_permissions
    [
     :reorder,
     :upload,
     :delete
    ]
  end

  def current_permissions
    permissions.collect{ |p| p.parameterize.underscore.to_sym }
  end

  # check if role has a specific permission
  # :finalize_6_month_evaluation
  def has_permission?(permission)
    current_permissions.include?(permission)
  end

  def self.string_to_sym(string)
    string.parameterize.underscore.to_sym
  end

end

class Invoice < Entry

  def account_types_valid? 
    entry_amounts.map(&:account).any?{|x| x.is_a?(Customer)}
  end
end

module AccountMethods

  def self.included(base)
    base.module_eval do
      def account_name
        self.type.underscore.titleize
      end
    end
  end
end

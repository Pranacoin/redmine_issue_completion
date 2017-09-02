module RedmineAutoPercent
  module IssuePatch
    def self.included(base)
      base.extend(ClassMethods)

      base.send(:include, InstanceMethods)

      base.class_eval do
   #     before_save :custom_field_set_value
 		before_save :update_due_date
      end
    end
  end

  module ClassMethods
  end

  module InstanceMethods
def custom_field_set_value
  self.custom_field_values.each do |field|
    if ( ( field.custom_field.id == 2 ) && self.status.is_closed?)
      field.value = 100
    end
  end
end
 	def update_due_date
 	  if (!(self.done_ratio == self.status.default_done_ratio) && self.status.is_closed?)
		self.due_date = Date.today
	  end
	end
  end
end

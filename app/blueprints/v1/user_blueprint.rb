module V1
	class UserBlueprint < Blueprinter::Base
		fields :id, :email, :first_name, :last_name
	end
end

class UserAsStudentController < UserController
 def initialize
	@roleingroup_id = Role.find('Estudiante Asociado').id
 end
end

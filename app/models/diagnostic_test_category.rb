class DiagnosticTestCategory < ActiveRecord::Base
	has_many :diagnostic_test_question
end

class DiagnosticTestQuestion < ActiveRecord::Base
	has_one :diagnostic_test_answer
	has_one :diagnostic_test_level
	has_one :diagnostic_test_category
end

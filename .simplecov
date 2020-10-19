# frozen_string_literal: true

SimpleCov.start 'rails' do
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/models/application_record.rb'
end
SimpleCov.minimum_coverage 100

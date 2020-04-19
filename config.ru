require_relative './config/environment'

#if ActiveRecord::Migrator.needs_migration?
#  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
#end

use Rack::MethodOverride
### use OtherController1
### use OtherController2
### use OtherController3
run ApplicationController
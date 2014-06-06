# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Applicant::JobRequest.destroy_all
Admin::Account.destroy_all

Admin::Account.create! full_name: 'ابن سينا', username: 'admin', password: 'admin', deletable: false

job_requests = [
  {full_name: 'الخليل أحمد الفراهيدي', phone: '0512345678', address: 'عمان',
    specialization: 'علم النحو و البلاغة', degree: 'عالم مسلم'},
  {full_name: 'ابن خلدون', phone: '0521345678', address: 'تونس',
    specialization: 'علم الاجتماع', degree: 'عالم مسلم'},
  {full_name: 'ابن سينا', phone: '0521345678', address: 'بخارى',
    specialization: 'رياضيات', degree: 'عالم مسلم'},
]

job_requests.each do |job_request|
  Applicant::JobRequest.create! job_request
end

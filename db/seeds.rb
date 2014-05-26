# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Applicant.destroy_all

applicants = [
  {first_name: 'الخليل', last_name: 'أحمد الفراهيدي', phone: '0512345678', address: 'عمان',
    specialization: 'علم النحو و البلاغة', degree: 'عالم مسلم'},
  {first_name: 'ابن', last_name: 'خلدون', phone: '0521345678', address: 'تونس',
    specialization: 'علم الاجتماع', degree: 'عالم مسلم'},
  {first_name: 'ابن', last_name: 'سينا', phone: '0521345678', address: 'بخارى',
    specialization: 'رياضيات', degree: 'عالم مسلم'},
]

applicants.each do |applicant|
  Applicant.create! applicant
end

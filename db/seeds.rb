# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
school = School.create! name: 'Ioanid', email: 'office@ioanid.com', phone: '0700123456', country: 'România', city: 'București', address: 'Strada General Constantin Budișteanu', registration_code: '123456'

teacher1 = Staff.create! initial_password: 'password', current_school: school, schools: [school]
user1 = User.create! profile: teacher1, email: 'stefan.ionescu@mail.com', first_name: 'Ștefan', last_name: 'Ionescu', phone: '0722233344', gender: 0, address: 'Strada Dunării', birth_date: Date.parse('1980/11/10'), newsletter: true, active: true, password: 'password'

teacher2 = Staff.create! initial_password: 'password', current_school: school, schools: [school]
user2 = User.create! profile: teacher2, email: 'iolanda.popescu@mail.com', first_name: 'Iolanda', last_name: 'Popescu', phone: '0722233344', gender: 1, address: 'Strada Plopilor', birth_date: Date.parse('1970/06/19'), newsletter: true, active: true, password: 'password'

teacher3 = Staff.create! initial_password: 'password', current_school: school, schools: [school]
user3 = User.create! profile: teacher3, email: 'andreea.stan@mail.com', first_name: 'Andreea', last_name: 'Stan', phone: '0722233344', gender: 1, address: 'Strada Dunării', birth_date: Date.parse('1990/01/09'), newsletter: true, active: true, password: 'password'

c1 = Classroom.create! name: '10R', optional: false, color: 'info', form_tutor: teacher1, allow_registration: true, registration_code: '1234567', school: school, archived: false

c2 = Classroom.create! name: '7A', optional: false, color: 'warning', form_tutor: teacher2, allow_registration: true, registration_code: '2345678', school: school, archived: false

c3 = Classroom.create! name: 'Chemistry Club', optional: true, color: 'info', form_tutor: nil, allow_registration: true, registration_code: '3456789', school: school, archived: false
c3.staffs << teacher2

c4 = Classroom.create! name: '8A', optional: false, color: 'success', form_tutor: teacher3, allow_registration: true, registration_code: '4567890', school: school, archived: false

family1 = Family.create! name: 'Frățilă'

student1 = Student.create! initial_password: 'password', form: c2, family: family1, school: school
user4 = User.create! profile: student1, email: 'tiberiu.fratila@gmail.com', first_name: 'Tiberiu', last_name: 'Frățilă', phone: '0758043386', gender: 0, address: 'Strada Dunării', birth_date: Date.parse('2003/12/05'), newsletter: true, active: true, password: 'password'
student1.classrooms << c3

family2 = Family.create! name: 'Băbiceanu'

student2 = Student.create! initial_password: 'password', form: c1, family: family2, school: school
user5 = User.create! profile: student2, email: 'babiceanum4@gmail.com', first_name: 'Matei', last_name: 'Băbiceanu', phone: '0758043386', gender: 0, address: 'Strada Sofia', birth_date: Date.parse('2003/06/11'), newsletter: true, active: true, password: 'password'

parent1 = Parent.create! initial_password: 'password', family: family2
user6 = User.create! profile: parent1, email: 'geaninababiceanu@gmail.com', first_name: 'Geanina', last_name: 'Băbiceanu', phone: '0721280866', gender: 1, address: 'Strada Sofia', birth_date: Date.parse('1970/06/11'), newsletter: true, active: true, password: 'password'

sub1 = Subject.create! title: 'Mathematics', color: 'danger', icon: 'function', staff_only: false, individual_activity: false, attendance: true, evaluation: 1

sub1 = Subject.create! title: 'English', color: 'yellow', icon: 'books', staff_only: false, individual_activity: false, attendance: true, evaluation: 2
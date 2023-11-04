ROLES.each { |role| Role.create(name: role) }

# create testing accounts 
u_admin = User.create!(email: 'admin@admin.com', username: 'admin', password: '123456')
u_admin.roles << Role.find_by(name: 'admin')

u_operator = User.create!(email: 'operator@operator.com', username: 'operator', password: '123456')
u_operator.roles << Role.find_by(name: 'operator')

u_owner = User.create!(email: 'owner@owner.com', username: 'owner', password: '123456')
u_owner.roles << Role.find_by(name: 'owner')

User.create!(email: 'guest@guest.com', username: 'guest', password: '123456')
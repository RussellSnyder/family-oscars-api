password = ENV['USERPASSWORD']
users = ["Irini", "Max", "Laura", "Mellisa", "Russell", "Harry", "Zaxos"]

users.each { |userName| 
  User.create!({
    'name': userName,
    'email': "#{userName}@terzakis.de",
    'password': password
  })
}

categories = ["Familienmitglied Des Jahres", "Newcomer Des Jahres", "Unperson Des Jahres", "Unsituation Des Jahres", "Kracher"]

categories.each { |categoryTitle| 
  Category.create!({
    title: categoryTitle,
    created_by: 1
  })
}


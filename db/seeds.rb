
discussionM = Discussion.create(:title => "Redução da Maioridade Penal")


user = User.new(:email => "gbre.111@gmail.com", name: "Guilherme Baufaker", encrypted_password: "$2a$10$WjyKsUO.ij673kFwCknHh.mMnJ9FdsF/IyCW8b879Hm/F/oVXNnZe", reset_password_token: nil, reset_password_sent_at: nil)

user.save(validate: false)

opinion = Opinion.new(:body => "Eu sou contra a redução da Maioridade Penal para 16 anos de idade", :user_id => user.id)
discussionM.opinions << opinion


discussionA = Discussion.create(:title => "Legalização do Aborto")


opinion = Opinion.new(:body => "Eu sou a favor da Legalização do Aborto", :user_id => user.id)
discussionA.opinions << opinion
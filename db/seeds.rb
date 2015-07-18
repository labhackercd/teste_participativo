
discussionM = Discussion.create(:title => "Redução da Maioridade Penal", :proposal_enabled => true)


user = User.new(:email => "gbre.111@gmail.com", name: "Guilherme Baufaker", encrypted_password: "$2a$10$WjyKsUO.ij673kFwCknHh.mMnJ9FdsF/IyCW8b879Hm/F/oVXNnZe", reset_password_token: nil, reset_password_sent_at: nil)


user.save(validate: false)

root = Opinion.new(:body => "j", :user_id => user.id)

discussionM.opinions << root



k = Opinion.new(:body => "k", :user_id => user.id, :parent_opinion => root, :parent_position => "against")

z = Opinion.new(:body => "z", :user_id => user.id, :parent_opinion => k, :parent_position => "against")

f = Opinion.new(:body => "f", :user_id => user.id, :parent_opinion => root, :parent_position => "pro")

h = Opinion.new(:body => "h", :user_id => user.id, :parent_opinion => f, :parent_position => "pro")

a = Opinion.new(:body => "a", :user_id => user.id, :parent_opinion => f, :parent_position => "against")

d = Opinion.new(:body => "d", :user_id => user.id, :parent_opinion => a, :parent_position => "pro")

discussionM.opinions << k
discussionM.opinions << z
discussionM.opinions << f
discussionM.opinions << h
discussionM.opinions << a
discussionM.opinions << d



discussionA = Discussion.create(:title => "Legalização do Aborto")


opinion = Opinion.new(:body => "A livre escolha pelo aborto deve ser legalizada já!", :user_id => user.id)
discussionA.opinions << opinion
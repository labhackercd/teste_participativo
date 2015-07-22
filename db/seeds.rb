
teste = Discussion.create(:title => "Teste", :proposal_enabled => true)
user = User.where(:name => /Diego/).first

parent_opinion = Opinion.create(:body => "teste", :user => user)

teste.opinions << parent_opinion
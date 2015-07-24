
teste = Discussion.create(:title => "Teste", :proposal_enabled => true)
user = User.where(:name => /Diego/).first

root_opinion = Opinion.create(:body => "teste", :user => user)


another_opinion = Opinion.create(:body => "Teste23", :user => User.find_by(:name => /Guilherme/))


teste.opinions << root_opinion

teste.opinions << another_opinion

root_opinion.children << another_opinion
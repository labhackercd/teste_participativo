
teste = Discussion.create(:title => "Teste", :proposal_enabled => true)
user = User.where(:name => /Diego/).first

root_opinion = Opinion.create(:body => "teste", :user => user)


another_opinion = Opinion.create(:body => "Teste23", :user => User.find_by(:name => /Guilherme/),  :parent_position => 'pro')

another_opinion2 = Opinion.create(:body => "Teste234", :user => User.find_by(:name => /Diego/),  :parent_position => 'against')

teste.opinions << root_opinion

teste.opinions << another_opinion
teste.opinions << another_opinion2

root_opinion.children << another_opinion

another_opinion.children << another_opinion2
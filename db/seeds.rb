
discussion = Discussion.create(:title => "Redução da Maioridade Penal")


opinion = Opinion.new(:body => "Eu sou contra a redução da Maioridade Penal")
discussion.opinions << opinion

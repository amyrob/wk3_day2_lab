require('pry-byebug')
require_relative('models/bounty.rb')

bounty1 = Bounty.new (
  {
    'name' => 'Bert',
    'species' => 'Rugger Fan',
    'bounty_value' => 10,
    'danger_value' => 'Low'
  }
)
bounty2 = Bounty.new (
  {
    'name' => 'Arthur',
    'species' => 'Bearded Fella',
    'bounty_value' => 200,
    'danger_value' => 'Ermagerdyerderd'
  }
)
bounty1.save()
bounty2.save()
binding.pry


nil

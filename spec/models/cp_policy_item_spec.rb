# encoding: utf-8

require 'rspec'
require 'spec_helper'

describe CpPolicyItem do

  it 'check province exist' do
    found = CpPolicyItem.province_exsit?(254,'上海')
    found.should eq(true)
  end

  it 'check not exist' do
    found = CpPolicyItem.province_exsit?(253, '南京')
    found.should eq(false)
  end
end

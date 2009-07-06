require File.dirname(__FILE__) + '/spec_helper'

begin
  require "moneta/rufus"

  describe "Moneta::Rufus" do
    before(:each) do
      @file = File.join(File.dirname(__FILE__), 'cache')
      @cache = Moneta::Rufus.new(:file => @file)
      @cache.clear
    end
  
    after(:all) do
      File.delete("#{@file}.tch")
      File.delete("#{@file}_expires.tch")
    end
  
    it_should_behave_like "a read/write Moneta cache"
    
    it "should close the expiration database when #close is called" do
      @expiration = mock('expiration')
      @expiration.should_receive(:close)
      @cache.instance_variable_set(:@expiration, @expiration)
      @cache.close
    end
  end
rescue SystemExit
end
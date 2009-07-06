require File.dirname(__FILE__) + '/spec_helper'

begin
  require "moneta/rufus"

  describe "Moneta::Rufus" do
    before(:each) do
      @cache = Moneta::Rufus.new(:file => "cache")
      @cache.clear
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
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_title' do
    context 'page has a title' do
      it 'displays the full title' do
        expect(full_title('Dashboard')).to eq 'Dashboard | Montreal Newtech'
      end
    end

    context 'page does not have a title' do
      it 'displays the right title' do
        expect(full_title(' ')).to eq 'Montreal Newtech'
      end
    end
  end

  describe '#show_error' do
    it 'returns the content tag for an object that has errors' do
      object = build :initiative, title: nil
      object.valid?

      expect(show_error(object, :title)).
        to eq '<p class="field-error">Title can&#39;t be blank</p>'
    end

    it 'returns nothing for an object that has no errors' do
      object = build :initiative
      object.valid?

      expect(show_error(object, :title)).to eq nil
    end
  end

  describe '#google_search_link' do
    it 'returns a link to google maps searching for the given destination' do
      destination = '123 Place Ville Marie'
      expect(helper.google_search_link(destination)).
        to match Regexp.escape('https://www.google.com/maps/search/123+Place+Ville+Marie')
      expect(helper.google_search_link(destination)).
        to match(/#{destination}/)
      expect(helper.google_search_link(destination)).
        to match(/target="_blank"/)
    end
  end

  describe '#hyperlink_urls' do
    let(:text) { nil }

    context 'the method is called with a nil argument' do
      it 'returns nil' do
        expect(helper.hyperlink_urls(text)).to eq nil
      end
    end

    context 'the method is given some text with a url in it' do
      let(:text) { 'whoo some text http://averylongurlwith.com/yesveryverylong' }

      it 'turns the urls in the text into links' do
        expect(helper.hyperlink_urls(text)).
          to match(/<a href=/)
        expect(helper.hyperlink_urls(text)).
          to match(/target="_blank"/)
      end

      it 'cuts off the the url after 25 characters and ellipsizes the link text' do
        expect(helper.hyperlink_urls(text)).
          to match Regexp.escape('http://averylongurlwith.c... ')
      end

      it 'returns a paragraph tag' do
        expect(helper.hyperlink_urls(text)).
          to match %r{<p.+<\/p>}
      end

      context 'some extra options are passed along to the helper' do
        it 'adds the options to the helper' do
          expect(helper.hyperlink_urls(text, class: 'description')).
            to match %r{<p class="description".+<\/p>}
        end
      end
    end
  end
end

require 'spec_helper'

describe 'the index page', type: :feature, js: true do
  before { visit '/index.html' }
  it 'is the index page' do
    expect(current_path).to eq '/index.html'
    expect(page).to have_text "Draigan Le Febvre"
  end
  it 'has a working menu' do
    within ".header--menu" do
      click_on 'Projects'
    end
    expect(page).to have_css "h1", text: "Projects"
  end
  it 'has hero section' do
    has_css? (".herasdasdo")
  end
end

require 'spec_helper'

describe 'the index page', type: :feature, js: true do
  before { visit '/index.html' }
  it 'is the index page' do
    expect(current_path).to eq '/index.html'
    expect(page).to have_text "Draigan Le Febvre"
  end
  it 'has a working menu - projects' do
    within ".header--menu" do
      click_on 'Projects'
    end
    expect(page).to have_css "h1", text: "Projects"
  end
  it 'has a working menu - tech-skills' do
    within ".header--menu" do
      click_on 'Tech & Skills'
    end
    expect(page).to have_css "h1", text: "Tech & Skills"
  end
  it 'has hero section' do
    page.should have_css('.hero')
  end
  it 'has a project' do
    page.should have_css('.project')
  end
  it 'has a project wrapper' do
    page.should have_css('.project-wrapper')
  end
end

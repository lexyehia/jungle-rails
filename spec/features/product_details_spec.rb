require 'rails_helper'

RSpec.feature "Visitor navigating to the product detaisl page", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see a single product's details" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    all('article.product header a').first.click
    save_screenshot

    expect(page).to have_css 'section.products-show', count: 1
  end
end
